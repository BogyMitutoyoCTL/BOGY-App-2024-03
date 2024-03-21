#include "DateTimeCharacteristicCallbacks.h"
#include "RTClib.h"
#include "Helpers.h"

void DateTimeCharacteristicCallbacks::onRead(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param)
{
    // Serial.printf("Callback function to support a read request.\n");
    // uint8_t* dataPtr = pCharacteristic->getData();
    // auto dt = get_date_time(dataPtr, 7);
    // Serial.printf("DateTime: %d-%d-%d %d:%d:%d\n", dt.day(), dt.month(), dt.year(), dt.hour(), dt.minute(), dt.second());
}

void DateTimeCharacteristicCallbacks::onNotify(BLECharacteristic *pCharacteristic)
{
    // Serial.printf("Callback function to support a Notify request.\n");
}

void DateTimeCharacteristicCallbacks::onStatus(BLECharacteristic *pCharacteristic, Status s, uint32_t code)
{
    // Serial.printf("Callback function to support a Notify/Indicate Status report.\n");
    // Serial.printf("Status: %d Code: %d\n", s, code);
}

void DateTimeCharacteristicCallbacks::onWrite(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param)
{
    /* The Value from the Master as list of chars aka string */
    uint8_t *dataPtr{pCharacteristic->getData()};
    auto dt{get_date_time(dataPtr, 7)};
    print_date_time(dt, "SetTime -> ");
    rtc_.adjust(dt);
}
