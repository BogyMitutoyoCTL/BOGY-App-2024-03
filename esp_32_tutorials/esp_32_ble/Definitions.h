#pragma once
#include <Arduino.h>
#include <BLEDevice.h>

constexpr char SERVICE_GENERIC_ACCESS_UUID[]{"1800"};
constexpr char CHARACTERISTIC_DEVICE_NAME_UUID[]{"2A00"};
constexpr char DEVICE_NAME_STRING[]{"BOGY Temperature Sensoring Device"};

constexpr char SERVICE_DEVICE_INFORMATION_UUID[]{"180A"};
constexpr char CHARACTERISTIC_MANUFACTURER_NAME_STRING_UUID[]{"2A29"};
constexpr char MANUFACTURER_NAME_STRING[]{"Mitutoyo CTL Germany GmbH"};
constexpr char CHARACTERISTIC_MODEL_NUMBER_STRING_UUID[]{"2A24"};
constexpr char MODEL_NUMBER_STRING[]{"BOGY-2024-03"};
constexpr char CHARACTERISTIC_FIRMWARE_REVISION_STRING_UUID[]{"2A26"};
constexpr char FIRMWARE_REVISION_STRING[]{"01"};
constexpr char CHARACTERISTIC_SOFTWARE_REVISION_STRING_UUID[]{"2A28"};
constexpr char SOFTWARE_REVISION_STRING[]{"01-01"};

// Default UUID for Environmental Sensing Service
// https://www.bluetooth.com/specifications/assigned-numbers/
constexpr char SERVICE_ENVIRONMENTAL_SENSING_UUID[]{"181A"};
constexpr char CHARACTERISTIC_TEMPERATURE_UUID[]{"2A6E"};
constexpr char CHARACTERISTIC_DATETIME_UUID[]{"2A08"};

constexpr char SERVICE_SWITCH_UUID[]{"05811a0b-f418-488e-87b9-bf47ee64fda3"};
constexpr char CHARACTERISTIC_SWITCH_UUID[]{"a766ed81-3e5d-4503-af8e-25dbf9b90557"};

constexpr char SERVICE_DATA_UUID[]{"6a7f7672-ef00-4e7c-bba1-46179b152ad9"};
constexpr char CHARACTERISTIC_GET_DATA_UUID[]{"4df03e85-818b-4f41-b26c-71d68b24814f"};
constexpr char CHARACTERISTIC_DATA_UUID[]{"db919837-6ddb-42e0-afd5-f4a46ca99c8f"};
constexpr char CHARACTERISTIC_BUFFER_SIZE_UUID[]{"b7865b8e-8b37-4383-94f0-7201689e16ea"};
constexpr char CHARACTERISTIC_BUFFER_CAPACITY_UUID[]{"b7865b8e-8b37-4383-94f0-7201689e16ea"};

constexpr float EPSILON{0.01};
constexpr size_t BUFFER_SIZE{10802}; // 10802 was the max size 21.03.2024 high noon
// define the pin port where the temperature sensor is connected
constexpr uint8_t ONE_WIRE_BUS{4};

constexpr uint8_t STATUS_LED{2};
constexpr uint8_t SWITCH_LED{16};

constexpr unsigned long BAUD_RATE{115200};
