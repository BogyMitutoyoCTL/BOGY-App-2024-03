#pragma once
#include <Arduino.h>
#include <BLEDevice.h>
#include "Definitions.h"
#include <RTClib.h>

void status_led_blink();
uint8_t* get_byte_array(DateTime dt);

