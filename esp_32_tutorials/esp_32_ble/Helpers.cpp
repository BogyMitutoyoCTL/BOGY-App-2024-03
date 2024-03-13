#include "Helpers.h"

void status_led_blink()
{
    digitalWrite(STATUS_LED, true);
    delay(20);
    digitalWrite(STATUS_LED, false);
}

uint8_t* get_byte_array(DateTime dt) //return type- address of integer array
{
	static uint8_t DateTimeCharArray[7]; //array declared as static
    DateTimeCharArray[0] = dt.year() & 0x00FF; // LSB (0xE2) 2018 = 0x07E2
    DateTimeCharArray[1] = dt.year() >> 8;     // MSB (0x07)
    DateTimeCharArray[2] = dt.month();
    DateTimeCharArray[3] = dt.day();
    DateTimeCharArray[4] = dt.hour();
    DateTimeCharArray[5] = dt.minute();
    DateTimeCharArray[6] = dt.second();
    return DateTimeCharArray;
}