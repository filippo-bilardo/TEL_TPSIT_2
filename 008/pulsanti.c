/** ****************************************************************************************
* @file pulsanti.c
* @brief 202021_TPS2_A_ES04 - Collegamento e gestione di pulsanti con i microcontrollori 
* 
* @author Filippo Bilardo - http://fb-labs.blogspot.com/
* @date <data> 
* @version 1.0 12/12/20 Versione iniziale
* @version 1.1 21/11/21 
*/

#define LED_GREEN_PIN 12
#define LED_BLUE_PIN  13
#define SW_UP_PIN 2
#define SW_DW_PIN 3

int sw_up_pressed=0;
int stato_led_green=0;
int stato_led_blue=0;

void setup() {
  pinMode(LED_GREEN_PIN, OUTPUT);
  pinMode(LED_BLUE_PIN, OUTPUT); 
  pinMode(SW_UP_PIN, INPUT_PULLUP);
  pinMode(SW_DW_PIN, INPUT_PULLUP);
}

void loop() {
  if(swUpIsClicked()) {
    if(stato_led_green==1) stato_led_green=0; else stato_led_green=1;
  }
  
  if(swDwIsLongPressed()) {
    if(stato_led_blue==1) stato_led_blue=0; else stato_led_blue=1;
  }

  if(stato_led_green==1) {
    digitalWrite(LED_GREEN_PIN, HIGH);
  } else {
    digitalWrite(LED_GREEN_PIN, LOW);
  }  
  
  if(stato_led_blue==1) {
    digitalWrite(LED_BLUE_PIN, HIGH);
  } else {
    digitalWrite(LED_BLUE_PIN, LOW);
  }
}

int swUpIsPressedRaw() {
  //Pulsante collegato con resistenza di pull-up
  if(digitalRead(SW_UP_PIN)==0) return 1;
  return 0;
}

int swDwIsPressedRaw() {
  //Pulsante collegato con resistenza di pull-up
  if(digitalRead(SW_DW_PIN)==0) return 1;
  return 0;
}

int swUpIsPressed() {
  // Controllo che il pulsante sia premuto per un tempo minimo
  if(swUpIsPressedRaw()==1) {
    for(int cont=0; cont<50; ++cont) {
      delay(1);
      if(swUpIsPressedRaw()==0) return 0;
    }
    return 1;
  } 
  return 0;	
}

int swDwIsLongPressed() {
  // Controllo che il pulsante sia premuto per un tempo lungo
  if(swDwIsPressedRaw()==1) {
    for(int cont=0; cont<500; ++cont) {
      delay(1);
      if(swDwIsPressedRaw()==0) return 0;
    }
    return 1;
  } 
  return 0;	
}

int swUpIsClicked() {
  if(swUpIsPressedRaw()==1) {
    if(sw_up_pressed==0) sw_up_pressed=1;
    return 0;
  } else { 
    if(sw_up_pressed==1) {
      sw_up_pressed=0;
      return 1;
    } else {
  	  return 0;	
    }
  }
}

int swUpIsClickedBlocking() {
  if(swUpIsPressedRaw()==1) {
    while (swUpIsPressedRaw()==1) {;}
    return 1;
  } 
  return 0;	
}

