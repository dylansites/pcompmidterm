import org.json.*;
import processing.serial.*;
Serial arduinoPort;
//String apiKey = "6c29ec9a6575de0926fc4d582adf33fb:19:66326490";
//String baseURL = "http://api.nytimes.com/svc/search/v1/article";
String apiKey = "cdde3295f18cd01107ebebdb71ea3c09:3:60479132";
String source = "/nyt"; // possible values are: "all", "nyt", "iht" [intl. herald tribune]
String section = "/all"; 
String timePeriod = "/all";
int offset = 0;

int alert = 0;
int newAlert;

int freqOne;
int freqTwo;


void setup() {
  println(Serial.list());
  arduinoPort = new Serial(this, Serial.list()[1], 9600);
  size(500, 300);
};


void draw() {
     newAlert = getArticles(apiKey, source, section, timePeriod, offset);
     
     if(alert > 0){
       arduinoPort.write('H');
     }
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
  
  alert = alert + newAlert;
  println("Returns: " + alert);
  
  int time = millis();
  delay(time);
};
