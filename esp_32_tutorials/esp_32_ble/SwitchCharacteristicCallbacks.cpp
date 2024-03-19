#include "SwitchCharacteristicCallbacks.h"

void SwitchCharacteristicCallbacks::onRead(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param)
{
    //Serial.printf("Callback function to support a read request.\n");
}

void SwitchCharacteristicCallbacks::onNotify(BLECharacteristic *pCharacteristic)
{
    //Serial.printf("Callback function to support a Notify request.\n");
}

void SwitchCharacteristicCallbacks::onStatus(BLECharacteristic *pCharacteristic, Status s, uint32_t code)
{
    //Serial.printf("Callback function to support a Notify/Indicate Status report.\n");
    //Serial.printf("Status: %d Code: %d\n", s, code);
}

void SwitchCharacteristicCallbacks::onWrite(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param)
{
    /*std::string rxValue = pCharacteristic->getValue();
    if (rxValue.length() > 0)
    {
        Serial.printf("Received Value: ");
        for (int i = 0; i < rxValue.length(); i++)
        {
            Serial.print(rxValue[i], HEX);
        }
        Serial.printf("\n");
    }
    */
}