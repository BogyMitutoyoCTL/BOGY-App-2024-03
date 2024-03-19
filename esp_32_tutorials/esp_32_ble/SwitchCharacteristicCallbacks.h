#pragma once
#include <Arduino.h>
#include <BLEDevice.h>
#include "Helpers.h"

class SwitchCharacteristicCallbacks : public BLECharacteristicCallbacks
{
    private:
        BinaryValue binary_value_;
    public:
        SwitchCharacteristicCallbacks(BinaryValue& bv) : binary_value_(bv){};
        void onRead(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param) override;
        void onNotify(BLECharacteristic *pCharacteristic) override;
        void onStatus(BLECharacteristic *pCharacteristic, Status s, uint32_t code) override;
        void onWrite(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param) override;
};