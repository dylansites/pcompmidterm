import org.json.*;

String apiKey = "cdde3295f18cd01107ebebdb71ea3c09:3:60479132";
PImage icon;
PFont title;
PFont subtitle;
PFont national;
PFont international;

void setup () {
  size(1024, 768);
  smooth();
  String source = "/nyt"; // possible values are: "all", "nyt", "iht" [intl. herald tribune]
  String section = "/arts"; 
  String timePeriod = "/all";
  String offset = "0";
  getArticles(apiKey, source, section, timePeriod, offset);
  }


void draw () {
  
  background(255);

}
