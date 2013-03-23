
String [] getMPArticles(String mpapi, String resourceType, String mpsection, String mptime, int mpoffset, String mpapikey) {
  //counters for each of the 7 sections were watching
  int worldcount = 0;
  int uscount = 0;
  int educationcount = 0;
  int sportscount = 0;
  int sciencecount = 0;
  int healthcount = 0;
  int businesscount = 0;
  
  //String mpapi = "http://api.nytimes.com/svc/mostpopular/v2";
  String mpquery = (mpapi + resourceType + mpsection + mptime + "?&offset=" + mpoffset + "&api-key=" + mpapikey);
  println("Sending query to Most Popular API: " + mpquery);

  try {
    String[] responseLines = loadStrings(mpquery);//loads all data
    String response = join(responseLines, "");//makes one long string of data
    JSONObject nytData = new JSONObject(response);//turns that string into an object

    JSONArray results = nytData.getJSONArray("results");//makes an array outof everything that comes after "results"

    //goes through each article for parsing
    for (int i = 0; i < results.length(); i++) { 
      JSONObject obj = (JSONObject) results.get(i);




      String title = obj.getString("title"); // gets the article title
      /* String subHeadline = obj.getString("subheadline"); // gets the subheader for an article
       String byline = obj.getString("byline"); // gets the article byline*/
       String _abstract = obj.getString("abstract"); // gets the article abstract
       /*String publishedDate = obj.getString("published_date");
       String itemType = obj.getString("item_type"); // gets the type of an article, e.g. "Blog"
       String subSection = obj.getString("subsection"); // gets subsection, e.g. "Politics"*/
      String mainSection = obj.getString("section"); // gets main section, e.g. "U.S."
      /* String url = obj.getString("url"); // gets article URL
       String materialTypeFacet = obj.getString("material_type_facet"); // gets the type facet, e.g. "News"*/
      
      //looking for keywords in the section category
      String [] keywords;
      keywords = match(mainSection, "World");
      if (keywords != null) {
        worldcount += 1;
      }
      keywords = match(mainSection, "U.S.");
      if (keywords != null) {
        uscount += 1;
      }
      keywords = match(mainSection, "Education");
      if (keywords != null){                 
        educationcount += 1;
      }
      keywords = match(mainSection, "Sports");
      if (keywords != null) {
        sportscount += 1;
      }
      keywords = match(mainSection, "Science");
      if (keywords != null) {
        sciencecount += 1;
      }
      keywords = match(mainSection, "Health");
      if (keywords != null) {
        healthcount += 1;
      }
      keywords = match(mainSection, "Business");
      if (keywords != null) {
        businesscount += 1;
      }
      println("Title: " + title);
      println("Section: " + mainSection);
      println("Abstract: " + _abstract);
     
    }
     println("The amount of articles from the World section is: " + worldcount);
     println("The amount of articles from the U.S. section is: " + uscount);
     println("The amount of articles from the Education section is: " + educationcount);
     println("The amount of articles from the Sports section is: " + sportscount);
     println("The amount of articles from the Science section is: " + sciencecount);
     println("The amount of articles from the Health section is: " + healthcount);
     println("The amount of articles from the Businesss section is: " + businesscount);
  }
  //catching JSON errors
  catch (JSONException e) {  
    println (e.toString());
  }
  //making a string out of the section name and its total to prepare for sorting
  String a = (str(worldcount) + ":World");
  String b = (str(uscount) + ":US");
  String c = (str(educationcount) + ":Education");
  String d = (str(sportscount) + ":Sports");
  String e = (str(sciencecount) + ":Science");
  String f = (str(healthcount) + ":Health");
  String g = (str(businesscount) + ":Business");
  //a string array made of total:name for each section
  String [] trends = {a, b, c, d, e, f, g};
  String [] rank = sort(trends);//sorts strings in alphabetical order and thus reverse number order
  println(rank);
  return rank;
}



