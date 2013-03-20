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
  
}

void loop(){
  
  if(Serial.available()>0){
   incomingByte = Serial.read();
   
   if(incomingByte == 'H'){
     //setColor(color, 0, 0);
       setColor(255, 0, 0); //red for newswire
   }
   
   if(incomingByte == 'A'){
     //setColor(color, 0, 0);
       setColor(255, 0, 0); //red for US
   }
   
   if(incomingByte == 'W'){
     //setColor(color, 0, 0);
       setColor(0, 0, 255); //blue for World
   }
   
   if(incomingByte == 'I'){
     //setColor(color, 0, 0);
       setColor(255, 255, 0); //yellow for Science
   }
   
   if(incomingByte == 'S'){
     setColor(255, 255, 255);//white for Sports
   }
  }
}

void setColor(int red, int green, int blue){
  analogWrite(redPin, red);
  analogWrite(greenPin, green);
  analogWrite(bluePin, blue);
}
