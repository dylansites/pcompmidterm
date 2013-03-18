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
     //setColor(color, 0, 0);
     for(color = 0; color < 255; color += 1;){
       setColor(color, 0, 0);
     } 
   }
   
   if(incomingByte == 'L'){
     setColor(0, 0, 250);
   }
  }
}

void setColor(int red, int green, int blue){
  analogWrite(redPin, red);
  analogWrite(greenPin, green);
  analogWrite(bluePin, blue);
}