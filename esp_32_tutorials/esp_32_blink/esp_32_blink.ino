constexpr int LEDPIN = 2;

void setup()
{
    Serial.begin(115200);
    pinMode(LEDPIN, OUTPUT);
    Serial.println("Setup done...");
}

void loop()
{
    Serial.println("Wait for 500ms...");
    delay(500);
    Serial.println("Set LEDPIN to HIGH...");
    digitalWrite(LEDPIN, HIGH);
    Serial.println("Wait for 500ms...");
    delay(500);
    Serial.println("Set LEDPIN to LOW...");
    digitalWrite(LEDPIN, LOW);
}