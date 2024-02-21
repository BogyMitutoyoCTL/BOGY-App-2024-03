#include <BLEDevice.h>
#include <BLE2902.h>
#include <BLE2904.h>

#include <OneWire.h>
#include <DallasTemperature.h>

// Default UUID for Environmental Sensing Service
// https://www.bluetooth.com/specifications/assigned-numbers/
#define SERVICE_UUID (BLEUUID((uint16_t)0x181A))

// define the pin port where the temperature sensor is connected
#define ONE_WIRE_BUS 4

#define STATUS_LED 2

OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);

BLEServer *pServer = NULL;
BLECharacteristic *pCharacteristic = NULL;

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

class MyCharacteristicCallbacks : public BLECharacteristicCallbacks
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

void setup()
{
    Serial.begin(115200);

    sensors.begin();

    pinMode(2, OUTPUT);

    BLEDevice::init("BOGY Temperature BLE");

    pServer = BLEDevice::createServer();
    pServer->setCallbacks(new MyServerCallbacks());
    BLEService *pService = pServer->createService(SERVICE_UUID);
    pCharacteristic = pService->createCharacteristic(
        BLEUUID((uint16_t)0x2A6E),
        BLECharacteristic::PROPERTY_READ |
            BLECharacteristic::PROPERTY_NOTIFY |
            BLECharacteristic::PROPERTY_INDICATE);
    pCharacteristic->addDescriptor(new BLE2902());
    pCharacteristic->setCallbacks(new MyCharacteristicCallbacks());

    pService->start();
    BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
    pAdvertising->addServiceUUID(SERVICE_UUID);

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
        pCharacteristic->setValue((uint8_t *)&temperature, 4);
        pCharacteristic->notify();
    }
}