const int redPin = 11;
const int greenPin = 10;
const int bluePin = 9;
const int switchPin = A0;
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
  int switchVal = analogRead(switchPin);
  switchVal = map(switchVal, 0, 1023, 0, 255);
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
      alertLoop(); //keyword found; red alert blink.
      break;
    case 'L':
      blinkLoop(); //if returns > 0, blink white (newswire only)
      break;
    case 'Z':
      setColor(0, 0, 0); //if returns  0, nothing
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
  int t;
  for(t=0; t<3; t++){
    for (i=0; i<= 255; i++){
      setColor(i, i, i); //red
      delay(10);
    }
    int newSwitchVal = analogRead(switchPin);
    newSwitchVal = map(newSwitchVal, 0, 1023, 0, 255);
    for (i=255; i >= 0; i--){
      setColor(i, i, i); //red
      delay(10);
    }
    newSwitchVal = analogRead(switchPin);
    newSwitchVal = map(newSwitchVal, 0, 1023, 0, 255);
    if(newSwitchVal <= 140){
      return;
    }
  }
}

void alertLoop(){
  int i;
  for(i=0; i<10; i++){
    setColor(255, 0, 0);
    delay(100);
    setColor(0, 0, 0);
    delay(100);
  }
  int newSwitchVal = analogRead(switchPin);
  newSwitchVal = map(newSwitchVal, 0, 1023, 0, 255);
  if(newSwitchVal <= 140){
    return;
  }
}



