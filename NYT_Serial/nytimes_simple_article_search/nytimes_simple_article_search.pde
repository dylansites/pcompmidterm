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

  /*String[] words = {
    "Gay", "Christian"
  };
  color[] colors = {
    #FF0000, #00FF00, #0000FF, #FF3300, #FF9900
  };

  int barSize = 25;
  int startY = 80;

  String start = "20130301";
  String end = "20130315";

    for (int i = 0; i < words.length; i++) {
      if(i == 0){
      freqOne = getArticleKeywordCount( words[i], start, end);
      fill(colors[i]);
      rect(0, startY + (barSize  *i), freqOne/5, barSize);
      }else{
      freqTwo = getArticleKeywordCount( words[i], start, end);
      fill(colors[i]);
      rect(0, startY + (barSize  *i), freqTwo/5, barSize);
      }
    };*/
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


/*int getArticleKeywordCount(String word, String beginDate, String endDate) {
  String request = baseURL + "?query=" + word + "&begin_date=" + beginDate + "&end_date=" + endDate+ "&api-key="+apiKey;
  String result = join(loadStrings(request), "");
  
  int total = 0;

  try {
    JSONObject nytData = new JSONObject(join(loadStrings(request), ""));
    JSONArray results = nytData.getJSONArray("results");
    total = nytData.getInt("total");
    println("There were " + total + " occurences of the term " + word + " between " + beginDate + " and " + endDate);
  }
  catch (JSONException e) {
    println("There was an error parsing the JSONObject");
  };
  return(total);
  
};*/


