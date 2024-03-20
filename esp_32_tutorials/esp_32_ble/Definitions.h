#pragma once
#include <Arduino.h>
#include <BLEDevice.h>

// Default UUID for Environmental Sensing Service
// https://www.bluetooth.com/specifications/assigned-numbers/
#define SERVICE_ENVIRONMENTAL_SENSING_UUID (BLEUUID((uint16_t)0x181A))
#define CHARACTERISTIC_TEMPERATURE_UUID (BLEUUID((uint16_t)0x2A6E))
#define CHARACTERISTIC_DATETIME_UUID (BLEUUID((uint16_t)0x2A08))

#define SERVICE_SWITCH_UUID "05811a0b-f418-488e-87b9-bf47ee64fda3"
#define CHARACTERISTIC_SWITCH_UUID "a766ed81-3e5d-4503-af8e-25dbf9b90557"

#define EPSILON 0.01
#define BUFFER_SIZE 10 // 7000 possible
// define the pin port where the temperature sensor is connected
#define ONE_WIRE_BUS 4

#define STATUS_LED 2
#define SWITCH_LED 16
