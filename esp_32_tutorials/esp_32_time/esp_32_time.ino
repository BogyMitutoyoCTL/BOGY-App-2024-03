// Code Example from https://wolles-elektronikkiste.de/ds3231-echtzeituhr
#include "RTClib.h"

RTC_DS3231 rtc;

char daysOfTheWeek[7][12] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};

void setup()
{
    Serial.begin(115200);

#ifndef ESP8266
    while (!Serial)
        ; // wait for serial port to connect. Needed for native USB
#endif

    if (!rtc.begin())
    {
        Serial.println("Couldn't find RTC");
        Serial.flush();
        abort();
    }

    Serial.println("Setting the time...");
    // When time needs to be set on a new device, or after a power loss, the
    // following line sets the RTC to the date & time this sketch was compiled
    rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));
    // This line sets the RTC with an explicit date & time, for example to set
    // January 21, 2014 at 3am you would call:
    // rtc.adjust(DateTime(2014, 1, 21, 3, 0, 0));
}

void loop()
{
    DateTime now = rtc.now();
    Serial.printf("DateTime: %.4u/%.2u/%.2u %.2u:%.2u:%.2u\n", now.year(), now.month(), now.day(), now.hour(), now.minute(), now.second());
    Serial.flush();
    delay(3000);
}