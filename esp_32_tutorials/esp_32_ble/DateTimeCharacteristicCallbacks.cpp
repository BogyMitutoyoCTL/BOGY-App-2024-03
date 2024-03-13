#include "DateTimeCharacteristicCallbacks.h"
#include "RTClib.h"

void DateTimeCharacteristicCallbacks::onRead(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param)
{
    Serial.printf("Callback function to support a read request.\n");
    uint8_t* received_data = pCharacteristic->getData();
    Serial.printf("Status: %s ", *received_data);
}

void DateTimeCharacteristicCallbacks::onNotify(BLECharacteristic *pCharacteristic)
{
    Serial.printf("Callback function to support a Notify request.\n");
}

void DateTimeCharacteristicCallbacks::onStatus(BLECharacteristic *pCharacteristic, Status s, uint32_t code)
{
    Serial.printf("Callback function to support a Notify/Indicate Status report.\n");
    Serial.printf("Status: %d Code: %d\n", s, code);
}

void DateTimeCharacteristicCallbacks::onWrite(BLECharacteristic *pCharacteristic, esp_ble_gatts_cb_param_t *param)
{
    /* The Value from the Master as list of chars aka string */
    std::string rxValue = pCharacteristic->getValue();
    if (rxValue.length() > 0)
    {
        String s;
        Serial.printf("Received Value: ");
        for (int i = 0; i < rxValue.length(); i++)
        {
            char buf[8 * sizeof(rxValue[i]) + 1]; // Assumes 8-bit chars plus zero byte.
            char *str = &buf[sizeof(buf) - 1];
            *str = '\0';
            do
            {
                char c = rxValue[i] % HEX;
                rxValue[i] /= HEX;

                *--str = c < 10 ? c + '0' : c + 'A' - 10;
            } while (rxValue[i]);
            s.concat(str);
        }
        // The difference between the string here and the string rxValue is that the rxValue uses the string as list of numbers. The string s is the numbers as text. For example the string "a" translated with ascii has the value 97 (Dec)
        Serial.printf("%s\n", s);
    }
}
