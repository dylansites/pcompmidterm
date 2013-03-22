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
       setColor(255, 0, 0); //red for US
       break;
     case 'W':
       setColor(0, 0, 255); //blue for World
       break;
     case 'I':   
       setColor(0, 255, 0); //green for Science
       break;
     case 'S':
       setColor(0, 255, 150); //cyan for Sports
       break;
     case 'E':
       setColor(200, 0, 255); //purple for Education
       break;
     case 'B':  
       setColor(255, 100, 100 ); //white for Business;
       break;
     case 'P':
       setColor(255, 80, 0); //yellow for Health
       break;
     case 'H':
       blinkLoop(); //if returns > 0, blink red (newswire only)
       break;
     case 'L':
       setColor(0, 0, 0); //if returns = 0, off (newswire only)
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
 for (i=0; i<10; i++){
  setColor(255, 0, 0); //red
  delay(1000);
  setColor(0, 0, 0);
  delay(500);
 }
}


