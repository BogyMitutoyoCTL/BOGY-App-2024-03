#pragma once
#include <Arduino.h>
#include <BLEDevice.h>
#include "Helpers.h"

class TemperatureCharacteristicCallbacks : public BLECharacteristicCallbacks
{
private:
    InternalLedToggle &internalLed_;

public:
    TemperatureCharacteristicCallbacks(InternalLedToggle &internalLed) : internalLed_{internalLed} {};
    void onRead(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param) override;
    void onNotify(BLECharacteristic *pCharacteristic) override;
    void onStatus(BLECharacteristic *pCharacteristic, Status s, uint32_t code) override;
};