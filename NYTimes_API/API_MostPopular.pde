String mpapikey = "98814e026d926aa330b2b01db28d3376:14:67453798";
String mpapi = "http://api.nytimes.com/svc/mostpopular/v2";
String resourceType = "/mostshared";
String mpsection = "/all-sections";
String mptime = "/1";
int opinioncount = 0;
int uscount = 0;
int artscount = 0;



void getMPArticles(String mpapi, String resourceType, String mpsection, String mptime, String mpapiKey) {

  //String mpapi = "http://api.nytimes.com/svc/mostpopular/v2";
  String mpquery = (mpapi + resourceType + mpsection + mptime + "?&api-key=" + mpapikey);
  println("Sending query to Most Popular API: " + mpquery);

  try {
    String[] responseLines = loadStrings(mpquery);
    String response = join(responseLines, "");
    JSONObject nytData = new JSONObject(response);

    JSONArray results = nytData.getJSONArray("results");

    for (int i = 0; i < results.length(); i++) { 
      JSONObject obj = (JSONObject) results.get(i);




      String title = obj.getString("title"); // gets the article title
      /* String subHeadline = obj.getString("subheadline"); // gets the subheader for an article
       String byline = obj.getString("byline"); // gets the article byline
       String _abstract = obj.getString("abstract"); // gets the article abstract
       String publishedDate = obj.getString("published_date");
       String itemType = obj.getString("item_type"); // gets the type of an article, e.g. "Blog"
       String subSection = obj.getString("subsection"); // gets subsection, e.g. "Politics"*/
      String mainSection = obj.getString("section"); // gets main section, e.g. "U.S."
      /* String url = obj.getString("url"); // gets article URL
       String materialTypeFacet = obj.getString("material_type_facet"); // gets the type facet, e.g. "News"*/
      String [] keywords;
      keywords = match(mainSection, "Opinion");
      if (keywords != null) {
        opinioncount += 1;
      }
      keywords = match(mainSection, "U.S.");
      if (keywords != null) {
        uscount += 1;
      }
      keywords = match(mainSection, "Arts");
      if (keywords != null) {
        artscount += 1;
      }
      
      println("Title: " + title);
      println("Section: " + mainSection);
     
    }
     println("The amount of articles from the Opinion section is: " + opinioncount);
     println("The amount of articles from the U.S. section is: " + uscount);
     println("The amount of articles from the Arts section is: " + artscount);
  }
  catch (JSONException e) {  
    println (e.toString());
  }
}



