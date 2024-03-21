#include "DataCharacteristicCallbacks.h"
#include "Helpers.h"

void DataCharacteristicCallbacks::onRead(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param)
{
    // Serial.printf("Callback function to support a read request.\n");
}

void DataCharacteristicCallbacks::onNotify(BLECharacteristic *pCharacteristic)
{
    // Serial.printf("Callback function to support a Notify request.\n");
}

void DataCharacteristicCallbacks::onStatus(BLECharacteristic *pCharacteristic, Status s, uint32_t code)
{
    // Serial.printf("Callback function to support a Notify/Indicate Status report.\n");
    // Serial.printf("Status: %d Code: %d\n", s, code);
}