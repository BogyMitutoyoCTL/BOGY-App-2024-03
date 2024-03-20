#include "Helpers.h"

void status_led_blink()
{
    digitalWrite(STATUS_LED, true);
    delay(20);
    digitalWrite(STATUS_LED, false);
}

uint8_t *get_byte_array(DateTime dt) // return type- address of integer array
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

DateTime get_date_time(uint8_t *ptr, uint size)
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

void print_date_time(DateTime dt, String prefix)
{
    Serial.printf("%s DateTime: %.4u/%.2u/%.2u %.2u:%.2u:%.2u\n", prefix, dt.year(), dt.month(), dt.day(), dt.hour(), dt.minute(), dt.second());
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