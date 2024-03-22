#include <BLEDevice.h>
#include <BLE2902.h>
#include <BLE2904.h>

#include <RTClib.h>
#include <OneWire.h>
#include <DallasTemperature.h>

#include "MyServerCallbacks.h"
#include "TemperatureCharacteristicCallbacks.h"
#include "DateTimeCharacteristicCallbacks.h"
#include "SwitchCharacteristicCallbacks.h"
#include "DataCharacteristicCallbacks.h"

#include <CircularBuffer.hpp>

#include "Definitions.h"
#include "Helpers.h"

// https://github.com/rlogiacco/CircularBuffer
CircularBuffer<TemperatureData, BUFFER_CAPACITY> temperatures;
// define this here because of the index_t type
using index_t = decltype(temperatures)::index_t;

InternalLedToggle internLed;

const std::string deviveName{"BTBLE"};
auto unique_device_name{get_unique_device_name(deviveName)};

float last_temperature{0.0};
long values_read{0};
long values_changed{0};

RTC_DS3231 rtc;
OneWire oneWire{ONE_WIRE_BUS};
DallasTemperature temperature_sensors{&oneWire};
BinaryValue status{false};
BinaryValue get_data{false};

BLEServer *pServer{NULL};
BLECharacteristic *pCharacteristicTemperature{NULL};
BLECharacteristic *pCharacteristicDateTime{NULL};
BLECharacteristic *pCharacteristicSwitch{NULL};
BLECharacteristic *pCharacteristicGetData{NULL};
BLECharacteristic *pCharacteristicData{NULL};
BLECharacteristic *pCharacteristicBufferSize{NULL};
BLECharacteristic *pCharacteristicBufferCapacity{NULL};
BLECharacteristic *pCharacteristicManufacturerNameString{NULL};
BLECharacteristic *pCharacteristicModelNumberString{NULL};
BLECharacteristic *pCharacteristicFirmwareRevisionString{NULL};
BLECharacteristic *pCharacteristicSoftwareRevisionString{NULL};

void setup()
{
  Serial.begin(BAUD_RATE);
  pinMode(SWITCH_LED, OUTPUT);
  status.value = false;
  digitalWrite(SWITCH_LED, status.value);

  pinMode(STATUS_LED, OUTPUT);

  temperature_sensors.begin();
  Serial.printf("Found %d temperature sensor devices\n", temperature_sensors.getDeviceCount());
  temperature_sensors.requestTemperatures();

  if (!rtc.begin())
  {
    Serial.printf("Couldn't find RTC\n");
    Serial.flush();
    abort();
  }
  else
  {
    Serial.printf("RTC found... :-D\n");
    Serial.flush();
  }

  BLEDevice::init(unique_device_name);

  pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());

  // #### Environmental Sensing Service
  BLEService *pService{pServer->createService(SERVICE_ENVIRONMENTAL_SENSING_UUID)};
  pCharacteristicTemperature = pService->createCharacteristic(
      CHARACTERISTIC_TEMPERATURE_UUID,
      BLECharacteristic::PROPERTY_READ |
          BLECharacteristic::PROPERTY_NOTIFY |
          BLECharacteristic::PROPERTY_INDICATE);
  pCharacteristicTemperature->addDescriptor(new BLE2902());
  pCharacteristicTemperature->setCallbacks(new TemperatureCharacteristicCallbacks(internLed));

  pCharacteristicDateTime = pService->createCharacteristic(
      CHARACTERISTIC_DATETIME_UUID,
      BLECharacteristic::PROPERTY_READ |
          BLECharacteristic::PROPERTY_NOTIFY |
          BLECharacteristic::PROPERTY_INDICATE |
          BLECharacteristic::PROPERTY_WRITE);
  pCharacteristicDateTime->addDescriptor(new BLE2902());
  pCharacteristicDateTime->setCallbacks(new DateTimeCharacteristicCallbacks(rtc));

  pService->start();
  // #### End Environmental Sensing Service

  // #### Switch Service (for LED)
  BLEService *pServiceSwitch{pServer->createService(SERVICE_SWITCH_UUID)};
  pCharacteristicSwitch = pServiceSwitch->createCharacteristic(
      CHARACTERISTIC_SWITCH_UUID,
      BLECharacteristic::PROPERTY_READ |
          BLECharacteristic::PROPERTY_NOTIFY |
          BLECharacteristic::PROPERTY_INDICATE |
          BLECharacteristic::PROPERTY_WRITE);
  pCharacteristicSwitch->addDescriptor(new BLE2902());
  pCharacteristicSwitch->setCallbacks(new SwitchCharacteristicCallbacks(status));

  pServiceSwitch->start();
  // #### End Switch Service (for LED)

  // #### Get Data Service
  BLEService *pServiceGetData{pServer->createService(SERVICE_DATA_UUID)};
  pCharacteristicGetData = pServiceGetData->createCharacteristic(
      CHARACTERISTIC_GET_DATA_UUID,
      BLECharacteristic::PROPERTY_READ |
          BLECharacteristic::PROPERTY_NOTIFY |
          BLECharacteristic::PROPERTY_INDICATE |
          BLECharacteristic::PROPERTY_WRITE);
  pCharacteristicGetData->addDescriptor(new BLE2902());
  pCharacteristicGetData->setCallbacks(new SwitchCharacteristicCallbacks(get_data));

  pCharacteristicData = pServiceGetData->createCharacteristic(
      CHARACTERISTIC_DATA_UUID,
      BLECharacteristic::PROPERTY_NOTIFY);
  pCharacteristicData->addDescriptor(new BLE2902());
  pCharacteristicData->setCallbacks(new DataCharacteristicCallbacks());

  pCharacteristicBufferSize = pServiceGetData->createCharacteristic(
      CHARACTERISTIC_GET_DATA_UUID, BLECharacteristic::PROPERTY_READ | BLECharacteristic::PROPERTY_NOTIFY);
  pCharacteristicBufferSize->addDescriptor(new BLE2902());
  int buffer_size = 0;
  pCharacteristicBufferSize->setValue(buffer_size);

  pCharacteristicBufferCapacity = pServiceGetData->createCharacteristic(
      CHARACTERISTIC_GET_DATA_UUID, BLECharacteristic::PROPERTY_READ);
  pCharacteristicBufferCapacity->addDescriptor(new BLE2902());
  auto buffer_capacity = BUFFER_CAPACITY;
  pCharacteristicBufferCapacity->setValue(buffer_capacity);
  pServiceGetData->start();
  // #### End Get Data Service

  // #### Start Device Information Service
  BLEService *pServiceDeviceInformation{pServer->createService(SERVICE_DEVICE_INFORMATION_UUID)};
  pCharacteristicManufacturerNameString =
      pServiceDeviceInformation->createCharacteristic(
          CHARACTERISTIC_MANUFACTURER_NAME_STRING_UUID,
          BLECharacteristic::PROPERTY_READ);
  pCharacteristicManufacturerNameString->setValue(MANUFACTURER_NAME_STRING);

  pCharacteristicModelNumberString = pServiceDeviceInformation->createCharacteristic(
      CHARACTERISTIC_MODEL_NUMBER_STRING_UUID,
      BLECharacteristic::PROPERTY_READ);
  pCharacteristicModelNumberString->setValue(MODEL_NUMBER_STRING);

  pCharacteristicFirmwareRevisionString = pServiceDeviceInformation->createCharacteristic(
      CHARACTERISTIC_FIRMWARE_REVISION_STRING_UUID,
      BLECharacteristic::PROPERTY_READ);
  pCharacteristicFirmwareRevisionString->setValue(FIRMWARE_REVISION_STRING);

  pCharacteristicSoftwareRevisionString = pServiceDeviceInformation->createCharacteristic(
      CHARACTERISTIC_SOFTWARE_REVISION_STRING_UUID,
      BLECharacteristic::PROPERTY_READ);
  pCharacteristicSoftwareRevisionString->setValue(SOFTWARE_REVISION_STRING);

  pServiceDeviceInformation->start();
  // #### End Generic Access Service

  BLEAdvertising *pAdvertising{BLEDevice::getAdvertising()};
  pAdvertising->addServiceUUID(SERVICE_ENVIRONMENTAL_SENSING_UUID);
  pAdvertising->addServiceUUID(SERVICE_SWITCH_UUID);

  //?? TODO: Check what this is doing...
  pAdvertising->setScanResponse(true);
  pAdvertising->setMinPreferred(0x06); // functions that help with iPhone connections issue
  pAdvertising->setMinPreferred(0x12);

  BLEDevice::startAdvertising();
  Serial.printf("BT MAC Address: %s\n", get_bt_mac_address().c_str());
  Serial.printf("BLE Device %s started up.\n", unique_device_name.c_str());
  Serial.printf("Waiting a client connection to notify...\n");
  Serial.flush();
}

unsigned long previousMillis{0};
const long interval{1000};

void do_normal_loop_cycle()
{
  // read the sensor values
  float temperature{temperature_sensors.getTempCByIndex(0)};
  // request already for next reading
  temperature_sensors.requestTemperatures();
  values_read++;

  DateTime now{rtc.now()};
  print_date_time(now, "Now -> ");
  print_temperature(last_temperature, temperature, " ");
  if (!are_equal(last_temperature, temperature))
  {
    temperatures.push({temperature, now.secondstime()});
    auto buffer_size = temperatures.size();
    pCharacteristicBufferSize->setValue(buffer_size);
    pCharacteristicBufferSize->notify();
    values_changed++;
  }
  last_temperature = temperature;
  print_buffer_ratio(temperatures, " ");
  print_values_read_changed(values_read, values_changed, " ");
  print_buffer_values(temperatures, " ");
  print_status_value(status, " IoPin? -> ");
  print_status_value(get_data, " GetData? -> ");

  // Serial.printf("Totally there are: %d connected\n", pServer->getConnectedCount());
  auto connectedDevices{pServer->getPeerDevices(true)};
  for (auto item : connectedDevices)
  {
    auto conn_status{item.second};
    auto device{conn_status.peer_device};
    //?? TODO: Check for the device mac address
    // Serial.printf("Peer device: %s\n", device);
  }

  // notify changed value
  if (pServer->getConnectedCount() > 0)
  {
    pCharacteristicDateTime->setValue(get_byte_array(now), 7);
    pCharacteristicDateTime->notify();
    pCharacteristicTemperature->setValue((uint8_t *)&temperature, sizeof(temperature));
    pCharacteristicTemperature->notify();
    pCharacteristicSwitch->notify();
    pCharacteristicGetData->notify();
  }
}

void send_data()
{
  for (index_t i = 0; i < temperatures.size(); i++)
  {
    if (i % 100 == 0)
    { // toggle led after 100 items
      internLed();
    }
    auto t{temperatures[i]};
    uint8_t data[sizeof(TemperatureData)];
    memcpy(data, &t.secondstime, sizeof(t.secondstime));
    memcpy(data + sizeof(t.secondstime), &t.temperature, sizeof(t.temperature));
    pCharacteristicData->setValue(data, sizeof(TemperatureData));
    pCharacteristicData->notify();
    Serial.printf("   Notify Data!\n");
    Serial.printf("   (UINT32 - Little Endian) Data Seconds: 0x%02X%02X%02X%02X Value: %d\n", data[0], data[1], data[2], data[3], t.secondstime);
    Serial.printf("   (Float - Little Endian) Data Temperature: 0x%02X%02X%02X%02X Value: %f\n", data[4], data[5], data[6], data[7], t.temperature);
    Serial.flush();
    delayMicroseconds(10);
  }

  get_data.value = false;
}

void loop()
{
  digitalWrite(SWITCH_LED, status.value);

  // return if inverval has not reached...
  unsigned long currentMillis{millis()};
  if (currentMillis - previousMillis < interval)
  {
    return;
  }
  previousMillis = currentMillis;

  if (!get_data.value)
  {
    do_normal_loop_cycle();
  }
  else
  {
    send_data();
  }
}