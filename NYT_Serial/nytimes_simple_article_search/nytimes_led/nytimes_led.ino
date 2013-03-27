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
    case 'J':
      alertLoop(130, 200); //keyword found; red alert blink.(newswire 1st)
      break;
    case 'H':
      alertLoop(200, 400); //keyword found; red alert blink.(newswire 2nd)
      break;
    case 'L':
      whiteLoop(); //searching, pulses white (newswire only 2nd)
      break;
    case 'G':
      purpleLoop(); //searching, pulses purple (newswire only 1st)
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

void whiteLoop(){//pulses white
  int i;
  int t;
  for(t=0; t<4; t++){
    for (i=0; i<= 200; i++){
      setColor(i, i, i); 
      delay(10);
    }
    int newSwitchVal = analogRead(switchPin);
    newSwitchVal = map(newSwitchVal, 0, 1023, 0, 255);
    if(newSwitchVal < 200){
      setColor(0, 0, 0);
      return;
    }
    for (i=200; i >= 0; i--){
      setColor(i, i, i);
      delay(10);
    }
    newSwitchVal = analogRead(switchPin);
    newSwitchVal = map(newSwitchVal, 0, 1023, 0, 255);
    if(newSwitchVal < 200){
      setColor(0, 0, 0);
      return;
    }
  }
  //setColor(255, 255, 255);
}

void purpleLoop(){//pulses purple
  int newSwitchVal = analogRead(switchPin);
  newSwitchVal = map(newSwitchVal, 0, 1023, 0, 255);
  if(newSwitchVal < 130 || newSwitchVal > 200){
    setColor(0, 0, 0);
    return;
  }
  int i;
  int t;
  for(t=0; t<4; t++){
    for (i=0; i<= 255; i++){
      setColor(i, 0, i); 
      delay(10);
    }
    newSwitchVal = analogRead(switchPin);
    newSwitchVal = map(newSwitchVal, 0, 1023, 0, 255);
    if(newSwitchVal < 130 || newSwitchVal > 200){
      setColor(0, 0, 0);
      break;
    }
    for (i=255; i >= 0; i--){
      setColor(i, 0, i);
      delay(10);
    }
    newSwitchVal = analogRead(switchPin);
    newSwitchVal = map(newSwitchVal, 0, 1023, 0, 255);
    if(newSwitchVal < 130 || newSwitchVal > 200){
      setColor(0, 0, 0);
      break;
    }
  }
  //setColor(200, 0, 200);
}

void alertLoop(int a, int b){
  int newSwitchVal = analogRead(switchPin);
  newSwitchVal = map(newSwitchVal, 0, 1023, 0, 255);
  if(newSwitchVal < a || newSwitchVal > b){
    setColor(0, 0, 0);
    return;
  }
  int i;
  for(i=0; i<30; i++){
    setColor(255, 0, 0);
    delay(100);
    setColor(0, 0, 0);
    delay(100);
    newSwitchVal = analogRead(switchPin);
    newSwitchVal = map(newSwitchVal, 0, 1023, 0, 255);
    if(newSwitchVal < a || newSwitchVal > b){
      setColor(0, 0, 0);
      break;
    }
  }
  setColor(255, 0, 0);
}







