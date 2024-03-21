#pragma once
#include <Arduino.h>
#include <BLEDevice.h>

// Default UUID for Environmental Sensing Service
// https://www.bluetooth.com/specifications/assigned-numbers/
constexpr char SERVICE_ENVIRONMENTAL_SENSING_UUID[]{"181A"};
constexpr char CHARACTERISTIC_TEMPERATURE_UUID[]{"2A6E"};
constexpr char CHARACTERISTIC_DATETIME_UUID[]{"2A08"};

constexpr char SERVICE_SWITCH_UUID[]{"05811a0b-f418-488e-87b9-bf47ee64fda3"};
constexpr char CHARACTERISTIC_SWITCH_UUID[]{"a766ed81-3e5d-4503-af8e-25dbf9b90557"};

constexpr char SERVICE_GET_DATA_UUID[]{"06e2d59b-8087-4338-b347-1b6322b5d8be"};
constexpr char CHARACTERISTIC_GET_DATA_UUID[]{"4df03e85-818b-4f41-b26c-71d68b24814f"};

constexpr char SERVICE_DATA_UUID[]{"6a7f7672-ef00-4e7c-bba1-46179b152ad9"};
constexpr char CHARACTERISTIC_DATA_UUID[]{"db919837-6ddb-42e0-afd5-f4a46ca99c8f"};

constexpr float EPSILON{0.01};
constexpr size_t BUFFER_SIZE{10}; // 7000 possible
// define the pin port where the temperature sensor is connected
constexpr uint8_t ONE_WIRE_BUS{4};

constexpr uint8_t STATUS_LED{2};
constexpr uint8_t SWITCH_LED{16};
