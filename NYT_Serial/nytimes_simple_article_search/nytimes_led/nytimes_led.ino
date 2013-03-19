int redPin = A0;
int greenPin = A2;
int bluePin = A1;
int incomingByte;
int color;


void setup(){
 
 Serial.begin(9600);
 pinMode(redPin, OUTPUT);
 pinMode(greenPin, OUTPUT);
 pinMode(bluePin, OUTPUT);
  
}

void loop(){
  
  if(Serial.available()>0){
   incomingByte = Serial.read();
   
   if(incomingByte == 'H'){
       blinkLoop(); //if returns > 0, blink red
   }
   
   if(incomingByte == 'L'){
     setColor(0, 0, 0); //if returns = 0, off
   }
  }
  else {setColor(0, 0, 0);} //defaults to off if no incoming bytes
}

void setColor(int red, int green, int blue){
  //RGB values for anode LED -> +5v
  analogWrite(redPin, 255-red);
  analogWrite(greenPin, 255-green);
  analogWrite(bluePin, 255-blue); 
 
  //RGB values for cathode LED -> GRD
  //analogWrite(redPin, red);
  //analogWrite(greenPin, green);
  //analogWrite(bluePin, blue); 
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

