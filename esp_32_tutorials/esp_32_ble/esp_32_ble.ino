#include <BLEDevice.h>
#include <BLE2902.h>
#include <BLE2904.h>

#include <RTClib.h>
#include <OneWire.h>
#include <DallasTemperature.h>

#include "TemperatureCharacteristicCallbacks.h"
#include "DateTimeCharacteristicCallbacks.h"
#include "SwitchCharacteristicCallbacks.h"

#include "Definitions.h"
#include "Helpers.h"

const std::string deviveName{"BTBLE"};
auto unique_device_name = get_unique_device_name(deviveName);

RTC_DS3231 rtc;
OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);
BinaryValue status;

BLEServer *pServer = NULL;
BLECharacteristic *pCharacteristicTemperature = NULL;
BLECharacteristic *pCharacteristicDateTime = NULL;
BLECharacteristic *pCharacteristicSwitch = NULL;

// create a callback class to support BLE callbacks
class MyServerCallbacks : public BLEServerCallbacks
{
    // if a new device connecting to the server
    void onConnect(BLEServer *pServer)
    {
        Serial.printf("New client connected.\n");
    };

    // if a device is disconnecting from the server
    void onDisconnect(BLEServer *pServer)
    {
        Serial.printf("Client disconnected.\n");
        // do advertising again, that the next client could connect...
        BLEDevice::startAdvertising();
    }
};

void setup()
{
    Serial.begin(115200);
    pinMode(SWITCH_LED, OUTPUT);
    status.value = false;
    digitalWrite(SWITCH_LED, status.value);

    sensors.begin();

    pinMode(STATUS_LED, OUTPUT);

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
    BLEService *pService = pServer->createService(SERVICE_ENVIRONMENTAL_SENSING_UUID);
    pCharacteristicTemperature = pService->createCharacteristic(
        CHARACTERISTIC_TEMPERATURE_UUID,
        BLECharacteristic::PROPERTY_READ |
            BLECharacteristic::PROPERTY_NOTIFY |
            BLECharacteristic::PROPERTY_INDICATE);
    pCharacteristicTemperature->addDescriptor(new BLE2902());
    pCharacteristicTemperature->setCallbacks(new TemperatureCharacteristicCallbacks());

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
    BLEService *pServiceSwitch = pServer->createService(SERVICE_SWITCH_UUID);
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

    BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
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

unsigned long previousMillis = 0;
const long interval = 1000;

void loop()
{
    //?? TODO: Check for overflow
    unsigned long currentMillis = millis();
    if (currentMillis - previousMillis < interval)
    {
        return;
    }
    previousMillis = currentMillis;

    // read the sensor values
    sensors.requestTemperatures();
    float temperature = sensors.getTempCByIndex(0);

    DateTime now = rtc.now();
    print_date_time(now, "Now -> ");
    print_temperature(temperature);
    print_status_value(status);

    // Serial.printf("Totally there are: %d connected\n", pServer->getConnectedCount());
    auto connectedDevices = pServer->getPeerDevices(true);
    for (auto item : connectedDevices)
    {
        auto conn_status = item.second;
        auto device = conn_status.peer_device;
        //?? TODO: Check for the device mac address
        // Serial.printf("Peer device: %s\n", device);
    }

    // notify changed value
    if (pServer->getConnectedCount() > 0)
    {

        pCharacteristicDateTime->setValue(get_byte_array(now), 7);
        pCharacteristicDateTime->notify();

        pCharacteristicTemperature->setValue((uint8_t *)&temperature, 4);
        pCharacteristicTemperature->notify();

        pCharacteristicSwitch->notify();
    }
}