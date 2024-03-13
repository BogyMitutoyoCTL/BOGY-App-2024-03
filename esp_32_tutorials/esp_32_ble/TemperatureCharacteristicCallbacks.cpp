#include "TemperatureCharacteristicCallbacks.h"
#include "Helpers.h"

void TemperatureCharacteristicCallbacks::onRead(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param)
{
    Serial.printf("Callback function to support a read request.\n");
    status_led_blink();
}

void TemperatureCharacteristicCallbacks::onNotify(BLECharacteristic *pCharacteristic)
{
    Serial.printf("Callback function to support a Notify request.\n");
    status_led_blink();
}

void TemperatureCharacteristicCallbacks::onStatus(BLECharacteristic *pCharacteristic, Status s, uint32_t code)
{
    Serial.printf("Callback function to support a Notify/Indicate Status report.\n");
    Serial.printf("Status: %d Code: %d\n", s, code);
}