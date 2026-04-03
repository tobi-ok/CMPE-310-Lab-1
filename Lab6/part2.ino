// Define Pins
#define LED1 3
#define LED2 5

void setup()
{
pinMode(LED1, OUTPUT);
pinMode(LED2, OUTPUT);
digitalWrite(LED1, HIGH); // Set LED off at start
digitalWrite(LED2, LOW);
}

// main loop
void loop()
{
// Cycle LED1
digitalWrite(LED1, HIGH);
delay(500);
digitalWrite(LED1, LOW);
delay(500);

digitalWrite(LED1, HIGH);
delay(500);
digitalWrite(LED1, LOW);
delay(500);

// Cycle LED2digitalWrite(LED2, HIGH);
delay(1000);
digitalWrite(LED2, LOW);
delay(1000);

digitalWrite(LED2, HIGH);
delay(1000);
digitalWrite(LED2, LOW);
delay(1000);
}