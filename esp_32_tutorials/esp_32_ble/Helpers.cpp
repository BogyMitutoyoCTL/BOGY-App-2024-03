#include "Helpers.h"

void status_led_blink()
{
    digitalWrite(STATUS_LED, true);
    delay(20);
    digitalWrite(STATUS_LED, false);
}

uint8_t *get_byte_array(const DateTime &dt) // return type- address of integer array
{
    static uint8_t DateTimeCharArray[7];       // array declared as static
    DateTimeCharArray[0] = dt.year() & 0x00FF; // LSB (0xE2) 2018 = 0x07E2
    DateTimeCharArray[1] = dt.year() >> 8;     // MSB (0x07)
    DateTimeCharArray[2] = dt.month();
    DateTimeCharArray[3] = dt.day();
    DateTimeCharArray[4] = dt.hour();
    DateTimeCharArray[5] = dt.minute();
    DateTimeCharArray[6] = dt.second();
    return DateTimeCharArray;
}

uint8_t *get_byte_array(const TemperatureData& temp_data)
{
    // 4 bytes for the seconds (unsigned long)
    // 4 bytes for temperature (float)
    auto seconds{temp_data.secondstime};
    auto temperature{temp_data.temperature};
    static uint8_t data[sizeof(TemperatureData)];
    memcpy(data, &seconds, sizeof(seconds));
    memcpy(data + sizeof(seconds), &temperature, sizeof(temperature));
    Serial.printf("   Notify Data!\n");
    Serial.printf("   (UINT32 - Little Endian) Data Seconds: 0x%02X%02X%02X%02X Value: %d\n", data[0], data[1], data[2], data[3], seconds);
    Serial.printf("   (Float - Little Endian) Data Temperature: 0x%02X%02X%02X%02X Value: %f\n", data[4], data[5], data[6], data[7], temperature);
    Serial.flush();
    return data;
}

DateTime get_date_time(uint8_t *ptr, const uint size)
{
    if (size == 7)
    {
        auto year_lsb = static_cast<uint16_t>(ptr[0]);
        auto year_msb = ptr[1];
        auto year = static_cast<int>(year_lsb | year_msb << 8);
        auto month = static_cast<int>(ptr[2]);
        auto day = static_cast<int>(ptr[3]);
        auto hour = static_cast<int>(ptr[4]);
        auto minute = static_cast<int>(ptr[5]);
        auto second = static_cast<int>(ptr[6]);
        return DateTime(year, month, day, hour, minute, second);
    }
    else
    {
        return DateTime();
    }
}

void print_date_time(const DateTime &dt, const String &prefix)
{
    Serial.printf("%sDateTime: %.4u/%.2u/%.2u %.2u:%.2u:%.2u\n", prefix, dt.year(), dt.month(), dt.day(), dt.hour(), dt.minute(), dt.second());
    Serial.flush();
}

void print_temperature(const float temp, const String &prefix)
{
    Serial.printf("%sTemperature: %.2f°C\n", prefix, temp);
    Serial.flush();
}

void print_temperature(const float temp1, const float temp2, const String &prefix)
{
    if (are_equal(temp1, temp2))
    {
        Serial.printf("%sEqual: %.2f Celsius\n", prefix, temp1);
    }
    else
    {
        Serial.printf("%sTempdiff: %.2f Grad / %.2f C / %.2f C\n", prefix, fabs(temp1 - temp2), temp1, temp2);
    }
    Serial.flush();
}

void print_status_value(const BinaryValue &bv, const String &prefix)
{
    Serial.printf("%sBinary Value: %s\n", prefix, bv.value ? "true" : "false");
    Serial.flush();
}

void print_values_read_changed(const long read, const long changed, const String &prefix)
{
    Serial.printf("%sValues Read/Changed %d/%d\n", prefix, read, changed);
    Serial.flush();
}

void print_buffer_ratio(const CircularBuffer<TemperatureData, BUFFER_SIZE> &temperatures, const String &prefix)
{
    printf("%sBuffer: %d/%d Used/Free Ratio\n", prefix, temperatures.size(), temperatures.available());
    Serial.flush();
}

void print_buffer_values(const CircularBuffer<TemperatureData, BUFFER_SIZE> &temperatures, const String &prefix)
{
    if (temperatures.isEmpty())
    {
        Serial.printf("%sBuffer is empty!\n", prefix);
    }
    else
    {
        Serial.printf("%sValues [", prefix);
        for (auto i = 0; i < temperatures.size(); i++)
        {
            Serial.printf("%.2f", temperatures[i].temperature);
            if (i != temperatures.size() - 1)
            {
                Serial.printf(", ");
            }
        }
        Serial.printf("]\n");
    }
    Serial.flush();
}

std::string get_bt_mac_address()
{
    uint8_t baseMac[6];
    esp_read_mac(baseMac, ESP_MAC_BT);
    char baseMacChr[18] = {0};
    sprintf(baseMacChr, "%02X:%02X:%02X:%02X:%02X:%02X", baseMac[0], baseMac[1], baseMac[2], baseMac[3], baseMac[4], baseMac[5]);
    std::string ret{baseMacChr};
    return ret;
}

std::string get_unique_device_name(const std::string &name)
{
    uint8_t baseMac[6];
    esp_read_mac(baseMac, ESP_MAC_BT);
    char baseChr[7] = {0};
    sprintf(baseChr, "%02X%02X%02X", baseMac[3], baseMac[4], baseMac[5]);
    std::string unique_name{name + " " + baseChr};
    return unique_name;
}

bool are_equal(const float a, const float b)
{
    return fabs(a - b) < EPSILON;
}