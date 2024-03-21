#pragma once
#include <Arduino.h>
#include <BLEDevice.h>
#include "Definitions.h"
#include <RTClib.h>
#include "CircularBuffer.hpp"

struct BinaryValue
{
  bool value;
};

struct TemperatureData
{
  // Temperature
  float temperature;
  // Number of seconds since 2000-01-01 00:00:00.
  uint32_t secondstime;
};

void status_led_blink();
uint8_t *get_byte_array(DateTime dt);
DateTime get_date_time(uint8_t *ptr, uint size);
void print_temperature(const float temp, const String prefix = "");
void print_temperature(const float temp1, const float temp2, const String prefix = "");
void print_date_time(const DateTime dt, const String prefix = "");
void print_status_value(const BinaryValue &bv, const String prefix = "");
void print_buffer_ratio(const CircularBuffer<TemperatureData, BUFFER_SIZE> &temperatures, const String prefix = "");
void print_buffer_values(const CircularBuffer<TemperatureData, BUFFER_SIZE> &temperatures, const String prefix = "");
void print_values_read_changed(const long read, const long changed, const String prefix = "");
std::string get_bt_mac_address();
std::string get_unique_device_name(const std::string &name);
bool are_equal(float a, float b);
