import org.json.*;

String apiKey = "6c29ec9a6575de0926fc4d582adf33fb:19:66326490";
String baseURL = "http://api.nytimes.com/svc/search/v1/article";

void setup() {
  size(500, 300);

  String[] words = {
    "Obama", "Bloomberg"
  };
  color[] colors = {
    #FF0000, #00FF00, #0000FF, #FF3300, #FF9900
  };

  int barSize = 25;
  int startY = 80;

  String start = "20130301";
    String end = "20130312";

  for (int i = 0; i < words.length; i++) {
    int freq = getArticleKeywordCount( words[i], start, end);
    fill(colors[i]);
    rect(0, startY + (barSize  *i), freq/5, barSize);
  };
};


void draw() {
};

int getArticleKeywordCount(String word, String beginDate, String endDate) {
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
};

