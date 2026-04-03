// Define Pins
#define LED1 3

// Auto-lauch setup
void setup()
{
pinMode(LED1, OUTPUT); // Allow voltage to be output through LED pin
digitalWrite(LED1, HIGH); // Set LED off at start
}

// main loop
void loop()
{
// Blink LED1, (HIGH - On, LOW - Off)
digitalWrite(LED1, HIGH);
delay(1000);
digitalWrite(LED1, LOW);
delay(1000);

digitalWrite(LED1, HIGH);
delay(1000);
digitalWrite(LED1, LOW);
delay(1000);
}