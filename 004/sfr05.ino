#define LED 9
#define US  10 

void setup()
{
  Serial.begin(9600);
  pinMode(LED, OUTPUT);
}

int getDistance() {
  
  //Set pin US output
  pinMode(US, OUTPUT);
  //Send trig pulse
  digitalWrite(US, HIGH);
  delayMicroseconds(15);
  digitalWrite(US, LOW);

  //Set pin US intput
  pinMode(US, INPUT);
  //Wait for echo start
  while(digitalRead(US)==LOW) {;}

  //Wait for echo end
  long startTime = micros();
  while(digitalRead(US)==HIGH) {;}
  long travelTime = micros() - startTime;

  //Get distance in cm
  int distance = travelTime/58;

  return distance;
}
void loop()
{
  Serial.print("Distanza ostacolo ");
  Serial.print(getDistance());
  Serial.println();
  delay(200);
  
  //TODO accendere il led solo se la distanza
  //dell'ostacolo risulta minore a 20cm
  digitalWrite(LED, HIGH);
}
