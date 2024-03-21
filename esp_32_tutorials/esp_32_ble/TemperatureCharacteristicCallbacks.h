#pragma once
#include <Arduino.h>
#include <BLEDevice.h>

class TemperatureCharacteristicCallbacks : public BLECharacteristicCallbacks
{
    void onRead(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param) override;
    void onNotify(BLECharacteristic *pCharacteristic) override;
    void onStatus(BLECharacteristic *pCharacteristic, Status s, uint32_t code) override;
};