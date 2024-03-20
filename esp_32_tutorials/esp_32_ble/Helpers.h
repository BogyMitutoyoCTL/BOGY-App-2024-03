#pragma once
#include <Arduino.h>
#include <BLEDevice.h>
#include "Definitions.h"
#include <RTClib.h>

struct BinaryValue
{
  bool value;
};

void status_led_blink();
uint8_t *get_byte_array(DateTime dt);
DateTime get_date_time(uint8_t *ptr, uint size);
void print_temperature(const float temp, const String prefix = "");
void print_date_time(const DateTime dt, const String prefix = "");
void print_status_value(const BinaryValue &bv, const String prefix = "");
std::string get_bt_mac_address();
std::string get_unique_device_name(const std::string &name);
