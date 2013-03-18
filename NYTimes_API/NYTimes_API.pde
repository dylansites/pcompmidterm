import processing.serial.*;
Serial arduinoPort;

import org.json.*;

String apiKey = "cdde3295f18cd01107ebebdb71ea3c09:3:60479132";
PImage icon;
PFont title;
PFont subtitle;
PFont national;
PFont international;
int alert = 5;

void setup () {
  println(Serial.list());
  arduinoPort = new Serial (this, Serial.list()[1], 9600);
  
  size(100, 100);
  smooth();
  String source = "/nyt"; // possible values are: "all", "nyt", "iht" [intl. herald tribune]
  String section = "/arts"; 
  String timePeriod = "/all";
  int offset = 40;
 //getArticles(apiKey, source, section, timePeriod, offset);
 getMPArticles(mpapi, resourceType, mpsection, mptime, mpapikey);
  }


void draw () {
  
  background(255);
  if(alert > 0){
    arduinoPort.write('H');
  }

}
