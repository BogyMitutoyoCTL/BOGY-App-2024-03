#include <BLEDevice.h>
#include <BLE2902.h>
#include <BLE2904.h>

#include <OneWire.h>
#include <DallasTemperature.h>

// Default UUID for Environmental Sensing Service
// https://www.bluetooth.com/specifications/assigned-numbers/
#define SERVICE_ENVIRONMENTAL_SENSING_UUID (BLEUUID((uint16_t)0x181A))

#define SERVICE_SWITCH_UUID "05811a0b-f418-488e-87b9-bf47ee64fda3"
#define CHARACTERISTIC_SWITCH_UUID "a766ed81-3e5d-4503-af8e-25dbf9b90557"

// define the pin port where the temperature sensor is connected
#define ONE_WIRE_BUS 4

#define STATUS_LED 2

OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);

BLEServer *pServer = NULL;
BLECharacteristic *pCharacteristicTemperature = NULL;
BLECharacteristic *pCharacteristicSwitch = NULL;

void status_led_blink()
{
    digitalWrite(STATUS_LED, true);
    delay(20);
    digitalWrite(STATUS_LED, false);
}

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

class TemperatureCharacteristicCallbacks : public BLECharacteristicCallbacks
{
    void onRead(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param)
    {
        Serial.printf("Callback function to support a read request.\n");
        status_led_blink();
    }

    void onNotify(BLECharacteristic *pCharacteristic)
    {
        Serial.printf("Callback function to support a Notify request.\n");
        status_led_blink();
    }

    void onStatus(BLECharacteristic *pCharacteristic, Status s, uint32_t code)
    {
        Serial.printf("Callback function to support a Notify/Indicate Status report.\n");
        Serial.printf("Status: %d Code: %d\n", s, code);
    }
};

class SwitchCharacteristicCallbacks : public BLECharacteristicCallbacks
{
    void onRead(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param)
    {
        Serial.printf("Callback function to support a read request.\n");
        status_led_blink();
    }

    void onNotify(BLECharacteristic *pCharacteristic)
    {
        Serial.printf("Callback function to support a Notify request.\n");
        status_led_blink();
    }

    void onStatus(BLECharacteristic *pCharacteristic, Status s, uint32_t code)
    {
        Serial.printf("Callback function to support a Notify/Indicate Status report.\n");
        Serial.printf("Status: %d Code: %d\n", s, code);
    }

	void onWrite(BLECharacteristic* pCharacteristic, esp_ble_gatts_cb_param_t* param){
        std::string rxValue = pCharacteristic->getValue();
        if (rxValue.length() > 0){
            Serial.printf("Received Value: ");
            for (int i = 0; i < rxValue.length(); i++){
                Serial.print(rxValue[i], HEX);
            }
            Serial.printf("\n");
        }
    }
};

void setup()
{
    Serial.begin(115200);

    sensors.begin();

    pinMode(STATUS_LED, OUTPUT);

    BLEDevice::init("BOGY Temperature BLE");

    pServer = BLEDevice::createServer();
    pServer->setCallbacks(new MyServerCallbacks());

    // #### Environmental Sensing Service
    BLEService *pService = pServer->createService(SERVICE_ENVIRONMENTAL_SENSING_UUID);
    pCharacteristicTemperature = pService->createCharacteristic(
        BLEUUID((uint16_t)0x2A6E),
        BLECharacteristic::PROPERTY_READ |
            BLECharacteristic::PROPERTY_NOTIFY |
            BLECharacteristic::PROPERTY_INDICATE);
    pCharacteristicTemperature->addDescriptor(new BLE2902());
    pCharacteristicTemperature->setCallbacks(new TemperatureCharacteristicCallbacks());

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
    pCharacteristicSwitch->setCallbacks(new SwitchCharacteristicCallbacks());

    pServiceSwitch->start();
    // #### End Switch Service (for LED)

    BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
    pAdvertising->addServiceUUID(SERVICE_ENVIRONMENTAL_SENSING_UUID);

    //?? TODO: Check what this is doing...
    pAdvertising->setScanResponse(true);
    pAdvertising->setMinPreferred(0x06);  // functions that help with iPhone connections issue
    pAdvertising->setMinPreferred(0x12);

    BLEDevice::startAdvertising();
    Serial.printf("Waiting a client connection to notify...\n");
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


    Serial.printf("Totally there are: %d connected\n", pServer->getConnectedCount());
    auto connectedDevices = pServer->getPeerDevices(true);
    for (auto item : connectedDevices)
    {
        auto conn_status = item.second;
        auto device = conn_status.peer_device;
        //?? TODO: Check for the device mac address
        Serial.printf("Peer device: %s\n", device);
    }
    
    // notify changed value
    if (pServer->getConnectedCount() > 0)
    {
        pCharacteristicTemperature->setValue((uint8_t *)&temperature, 4);
        pCharacteristicTemperature->notify();
    }
}