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
int inByte = 3;

void setup() {
  println(Serial.list());
  arduinoPort = new Serial(this, Serial.list()[0], 9600);
  if(arduinoPort.available() > 0) {
    arduinoPort.clear();//clears arduino port initially to prepare for first value of a single 1 or 0
  }
  size(500, 300);
};


void draw() {
  if (arduinoPort.available() > 0) {
    inByte = arduinoPort.read();
    println("Reset:" + inByte); //debugging print; verifies that draw is looping properly(it wasn't at one point)
  }
  if (inByte == 1) {
    println("NW before:" + inByte); //debugging print: verifies that the value of inByte is 1
    newsWire();
    arduinoPort.clear(); //clears port so that when the loop comes back around, it needs a new 1 to continue
    inByte = arduinoPort.read(); //makes sure inByte is holding a new 0 or 1 and not just the old value or nothing at all(may be extraneous)
    return; //makes sure if statement isn't looping for some reason (it was at one point)
  }
  if (inByte == 0){
    println("MP before:" + inByte); //debugging print: verifies that the value of inByte is 0
    mostPop();
    arduinoPort.clear(); //clears port to ready for new 0 or 1 after function runs
    inByte = arduinoPort.read(); //replacement byte so that inByte is not empty or holding an old value (may be extraneous)
    return; //makes sure if statement isn't looping (it was at one point)
  }
  
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
  alert = newAlert;
  
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
  
  int endByte; //new value to hold 0 that could break the function
  
  //modified delay that checks for a value from Arduino every 2 seconds
  //after 20 seconds, if Arduino is still sending 1 if keeps going
  for(int t=0; t<11; t++){
     time = millis();
     shortDelay(time);
     if(arduinoPort.available() > 0) {
     endByte = arduinoPort.read();  //checks to see if value from Arduino has changed
     println("NW at end:" + endByte); //prints out new value for debugging
       if (endByte == 0) {
         println("You should have broken!"); 
         break;   //if value has changed to 0 i.e. the button is no longer pressed, this breaks loop and ends function
       }
     }
   arduinoPort.clear(); //clears port after getting another 0, so it can search for a 1 
   }
};

void mostPop() {
  
  //captures ranked array of section totals, from least to greatest 
  topTrends = getMPArticles(mpapi, resourceType, mpsection, mptime, mpoffset, mpapikey);
  
  //gets last 3 array values, which have the 3 highest section totals
  for( int i=7; i >4; i--){
    String [] section = split(topTrends[i], ":");
    println(section[1]);
    if(i==7){
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
   for( int i=7; i >4; i--){
    String [] section = split(topTrends[i], ":");
    println(section[1]);
    if(i==7){
      winners[0] = section[1];
    }
    if(i==6){
      winners[1] = section[1];
    }
    if(i==5){
      winners[2] = section[1];
    }
  }
  //tells arduino what are the top sections
   for(int i=0; i<winners.length; i++){
     //println(i); //print statement used for debugging
     if(i == 0){
       arduinoPort.write('X');//becomes the unexecuted first value; fixes error
       println("Sending an X to Arduino");
       time = millis();
       delay(time);
     }
     if(winners[i].equals("Science")){
       arduinoPort.write('S');
        println("Sending an S to Arduino");
     }
     if(winners[i].equals("Crime")){
       arduinoPort.write('P');
         println("Sending an P to Arduino");
     }
     if(winners[i].equals("Mourning")){
       arduinoPort.write('E');
         println("Sending a E to Arduino");
     }
     if(winners[i].equals("Health")){
       arduinoPort.write('B');
         println("Sending a B to Arduino");
     }
     if(winners[i].equals("Politics")){
       arduinoPort.write('W');
         println("Sending a W to Arduino");
     }
     if(winners[i].equals("Money")){
       arduinoPort.write('I');
         println("Sending an I to Arduino");
     }
     if(winners[i].equals("Military")){
       arduinoPort.write('A');
         println("Sending an A to Arduino");
     }
     if(winners[i].equals("Human Rights")){
       arduinoPort.write('R');
         println("Sending an R to Arduino");
     }
     //println(i); //print statement used for debugging
     
     arduinoPort.clear();//clears arduino Port of extra 0s and 1s
     
     //modified delay that checks for a value from Arduino every 2 seconds
     //after 20 seconds, if Arduino is still sending 0 if keeps going
     int endByte;
     for(int t=0; t<11; t++){
       time = millis();
       shortDelay(time);
       if(arduinoPort.available() > 0) {
       endByte = arduinoPort.read();  //checks to see if value from Arduino has changed
       println("MP at end:" + endByte); //prints out new value for debugging
         if (endByte == 1) {
           println("You should have broken!"); 
           break;   //if value has changed to 1 i.e. the button is now pressed, this delay for loop breaks
         }
       }
     arduinoPort.clear(); //clears port after getting another 0, so it can search for a 1 
     }
     //if the delay for loop breaks, this keeps the larger for loop from going onto the next section
     //it breaks the larger for loop and ends the function
     if(arduinoPort.available() > 0) {
       int breakByte = arduinoPort.read();
       if (breakByte == 1){
         println("BREAK");
         break;
       }
     }
   }
};

void delay(int time){
  int pause = 100;
  int m = millis();
  while( m < time + pause){
    m = millis();
  }
};

void shortDelay(int time){
  int pause = 2000;
  int m = millis();
  while( m < time + pause){
    m = millis();
  }
}

