import org.json.*;
import processing.serial.*;
Serial arduinoPort;

//variables for newsire
String apiKey = "cdde3295f18cd01107ebebdb71ea3c09:3:60479132";
String source = "/nyt"; // possible values are: "all", "nyt", "iht" [intl. herald tribune]
String section = "/all"; 
String timePeriod = "/all";
int offset = 0;

//variables for most popular
String mpapikey = "98814e026d926aa330b2b01db28d3376:14:67453798";
String mpapi = "http://api.nytimes.com/svc/mostpopular/v2";
String resourceType = "/mostshared";
String mpsection = "/all-sections";
String mptime = "/1";
int mpoffset = 0;

int alert = 0;
int newAlert;
String [] topTrends;
String [] winners = new String[3];

int time;
int inByte;

void setup() {
  println(Serial.list());
  arduinoPort = new Serial(this, Serial.list()[0], 9600);
  size(500, 300);
};


void draw() {
  while (arduinoPort.available() > 0) {
    inByte = arduinoPort.read();
    println(inByte);
  }
  if (inByte == 1) {
   newsWire();
  }
  else { mostPop();}
  
};

void newsWire() {
  newAlert = getArticles(apiKey, source, section, timePeriod, offset);
     
  //newswire will run 4 times to get 100 articles and will then reset   
  if(offset >= 100){
    offset = 0;
    alert = 0;
  }
  else{
    offset = offset + 20;
  }
  
  //adds number of hits from last pull down
  alert = alert + newAlert;
  
  //tells arduino if there's been a hit on the keyword or not
  if(alert > 0){
    arduinoPort.write('H');
      println("Sending an H to Arduino");
   }
   else{
     arduinoPort.write('L');
       println("Sending an L to Arduino");
   }
   
  println("Returns: " + alert);
  
  //delays loop for 20 seconds
  time = millis();
  delay(time);
};

void mostPop() {
  
  //captures ranked array of section totals, from least to greatest 
  topTrends = getMPArticles(mpapi, resourceType, mpsection, mptime, mpoffset, mpapikey);
  
  //gets last 3 array values, which have the 3 highest section totals
  for( int i=6; i >3; i--){
    String [] section = split(topTrends[i], ":");
    println(section[1]);
    if(i==6){
      winners[0] = section[1];
    }
    if(i==5){
      winners[1] = section[1];
    }
    if(i==4){
      winners[2] = section[1];
    }
  }
  //tells arduino what are the top sections
   for(int i=0; i<winners.length; i++){
     if(i != 0){
       time = millis();
       delay(time);
     }
     if(winners[i].equals("Sports")){
       arduinoPort.write('S');
         println("Sending an S to Arduino");
     }
     if(winners[i].equals("Education")){
       arduinoPort.write('E');
         println("Sending an E to Arduino");
     }
     if(winners[i].equals("Business")){
       arduinoPort.write('B');
         println("Sending a B to Arduino");
     }
     if(winners[i].equals("Health")){
       arduinoPort.write('P');
         println("Sending a P to Arduino");
     }
     if(winners[i].equals("World")){
       arduinoPort.write('W');
         println("Sending a W to Arduino");
     }
     if(winners[i].equals("Science")){
       arduinoPort.write('I');
         println("Sending an I to Arduino");
     }
     if(winners[i].equals("US")){
       arduinoPort.write('A');
         println("Sending an A to Arduino");
     }
   } 
};
