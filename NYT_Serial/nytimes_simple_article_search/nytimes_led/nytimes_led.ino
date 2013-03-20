int redPin = A0;
int greenPin = A1;
int bluePin = A2;
int incomingByte;
int color;

void setup(){
 
 Serial.begin(9600);
 pinMode(redPin, OUTPUT);
 pinMode(greenPin, OUTPUT);
 pinMode(bluePin, OUTPUT);
 
 setColor(0, 0, 0); //default to off

}

void loop(){

  
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
       setColor(0, 255, 255); //cyan for Sports
       break;
     case 'P':
       setColor(255, 255, 0); //yellow for Health
       break;
     case 'H':
       blinkLoop(); //if returns > 0, blink purple (newswire only)
       break;
     case 'L':
       setColor(0, 0, 0); //if returns = 0, off (newswire only)
       break;
   }

  } 
  
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
  setColor(255, 0, 255); //purple
  delay(1000);
  setColor(0, 0, 0);
  delay(500);
 }
}


