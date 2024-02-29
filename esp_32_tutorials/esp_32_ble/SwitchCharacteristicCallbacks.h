#pragma once
#include <Arduino.h>
#include <BLEDevice.h>

class SwitchCharacteristicCallbacks : public BLECharacteristicCallbacks
{
    void onRead(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param);

    void onNotify(BLECharacteristic *pCharacteristic);

    void onStatus(BLECharacteristic *pCharacteristic, Status s, uint32_t code);

    void onWrite(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param);
};