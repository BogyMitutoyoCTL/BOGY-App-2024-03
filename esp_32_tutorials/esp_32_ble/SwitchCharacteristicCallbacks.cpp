#include "SwitchCharacteristicCallbacks.h"

void SwitchCharacteristicCallbacks::onRead(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param)
{
    // Serial.printf("Callback function to support a read request.\n");
}

void SwitchCharacteristicCallbacks::onNotify(BLECharacteristic *pCharacteristic)
{
    // Serial.printf("Callback function to support a Notify request.\n");
    auto val = binary_value_.value;
    pCharacteristic->setValue((uint8_t *)&val, 1);
}

void SwitchCharacteristicCallbacks::onStatus(BLECharacteristic *pCharacteristic, Status s, uint32_t code)
{
    // Serial.printf("Callback function to support a Notify/Indicate Status report.\n");
    // Serial.printf("Status: %d Code: %d\n", s, code);
}

void SwitchCharacteristicCallbacks::onWrite(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param)
{
    uint8_t *dataPtr = pCharacteristic->getData();
    size_t data_lenght = pCharacteristic->getLength();
    bool value = static_cast<bool>(dataPtr[0]);
    binary_value_.value = value;
}