const int redPin = 11;
const int greenPin = 10;
const int bluePin = 9;
const int switchPin = 5;
int incomingByte;
int color;

void setup(){
 
 Serial.begin(9600);
 pinMode(redPin, OUTPUT);
 pinMode(greenPin, OUTPUT);
 pinMode(bluePin, OUTPUT);
 pinMode(switchPin, INPUT); 
  
 setColor(0, 0, 0); //default to off

}

void loop(){
  int switchVal = digitalRead(switchPin);
  Serial.write(switchVal);
  
  if(Serial.available()>0){
   incomingByte = Serial.read();
   
   switch(incomingByte){
     case 'A':
       setColor(255, 0, 0); //red for Military
       break;
     case 'W':
       setColor(0, 0, 255); //blue for Politics
       break;
     case 'I':   
       setColor(0, 255, 0); //green for Money
       break;
     case 'S':
       setColor(0, 255, 150); //cyan for Science
       break;
     case 'E':
       setColor(200, 0, 255); //purple for Mourning
       break;
     case 'B':  
       setColor(255, 30, 0); // orange for Health
       break;
     case 'P':
       setColor(255, 80, 0); //yellow for Crime
       break;
     case 'R':
       setColor(255, 100, 100); //white for Human Rights
       break;
     case 'H':
       setColor(255, 0, 0); //keyword found; solid red.
       break;
     case 'L':
       blinkLoop(); //if returns > 0, blink white (newswire only)
       break;
     case 'X':
       break;
   }

  } 
  
}

void setColor(int red, int green, int blue){
  //RGB values for anode LED -> +5v
//  analogWrite(redPin, 255-red);
//  analogWrite(greenPin, 255-green);
//  analogWrite(bluePin, 255-blue);
 
  //RGB values for cathode LED -> GRD
  analogWrite(redPin, red);
  analogWrite(greenPin, green);
  analogWrite(bluePin, blue); 
}

void blinkLoop(){
 int i;
 for (i=0; i<20; i++){
  setColor(255, 100, 100); //red
  delay(500);
  setColor(0, 0, 0);
  delay(500);
  int newSwitchVal = digitalRead(switchPin);
  if(newSwitchVal == LOW){
    break;
  }
 }
}


