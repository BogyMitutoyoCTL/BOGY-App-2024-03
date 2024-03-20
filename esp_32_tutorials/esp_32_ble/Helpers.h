#pragma once
#include <Arduino.h>
#include <BLEDevice.h>
#include "Definitions.h"
#include <RTClib.h>

void status_led_blink();
uint8_t *get_byte_array(DateTime dt);
DateTime get_date_time(uint8_t *ptr, uint size);
void print_date_time(DateTime dt, String prefix = "");
std::string get_bt_mac_address();
std::string get_unique_device_name(const std::string &name);
struct BinaryValue
{
  bool value;
};