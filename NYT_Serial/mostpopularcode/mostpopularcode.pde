//MP API
import org.json.*;
import processing.serial.*;
Serial arduinoPort;

int offset = 0;

int alert = 0;
int newAlert;


void setup() {
  println(Serial.list());
  arduinoPort = new Serial(this, Serial.list()[1], 9600);
  size(500, 300);

};


void draw() {
   
  getMPArticles(mpapi, resourceType, mpsection, mptime, mpapikey);
     
     if(opinioncount > uscount && opinioncount > artscount){
       arduinoPort.write('O');
     }
     else if(uscount > opinioncount && uscount > 
     else{
       arduinoPort.write('L');
     }
  if(offset >= 100){
    offset = 0;
    alert = 0;
  }
  else{
    offset = offset + 20;
  }
  
  //int time = millis();
  //delay(time);
};


