#pragma once
#include <Arduino.h>
#include <BLEDevice.h>
#include <RTClib.h>

class DateTimeCharacteristicCallbacks : public BLECharacteristicCallbacks
{
private:
    RTC_DS3231& rtc_;
public:
    DateTimeCharacteristicCallbacks(RTC_DS3231 &rtc) : rtc_{rtc}{};
    void onRead(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param) override;
    void onNotify(BLECharacteristic *pCharacteristic) override;
    void onStatus(BLECharacteristic *pCharacteristic, Status s, uint32_t code) override;
    void onWrite(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param) override;
};