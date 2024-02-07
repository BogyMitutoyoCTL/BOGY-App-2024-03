#include <OneWire.h>
#include <DallasTemperature.h>

constexpr int ONE_WIRE_BUS = 4;
OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);

void setup()
{
    Serial.begin(115200);
    pinMode(ONE_WIRE_BUS, INPUT);
    sensors.begin();
    Serial.println("Setup done...");
}

void loop()
{
    Serial.println("Wait for 500ms...");
    delay(500);
    Serial.println("Request the temperatures...");
    sensors.requestTemperatures();
    Serial.println("Read the temperature in celsius from the first sensor...");
    float temperatur = sensors.getTempCByIndex(0);
    Serial.printf("Temperature in Celsius: %3.5f", temperatur);
}