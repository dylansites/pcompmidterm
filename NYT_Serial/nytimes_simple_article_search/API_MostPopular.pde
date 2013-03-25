
String [] getMPArticles(String mpapi, String resourceType, String mpsection, String mptime, int mpoffset, String mpapikey) {
  //counters for each of the 7 sections were watching
  int militarycount = 0;
  int politicscount = 0;
  int moneycount = 0;
  int crimecount = 0;
  int sciencecount = 0;
  int healthcount = 0;
  int humanrightscount = 0;
  int mourningcount = 0;
  
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
      String desFacets = obj.getString("des_facet"); // made into a String so it can be searched with match()
      String geoFacets = obj.getString("geo_facet"); // made into a String so it can be searched with match()
      
      //looking for keywords in the section category
      String [] keywords;
      keywords = match(mainSection, "Science");
      if(keywords != null){
        sciencecount += 1;
      }
      keywords = match(mainSection, "Technology");
     if(keywords != null){
        sciencecount += 1;
      }
      keywords = match(desFacets, "POLITICS AND GOVERNMENT");
      if (keywords != null) {
        politicscount += 1;
      }
      keywords = match(desFacets, "TAX SHELTER");
      if (keywords != null){                 
        moneycount += 1;
      }
      keywords = match(desFacets, "BANKING");
      if (keywords != null) {
        moneycount += 1;
      }
      keywords = match(desFacets, "FEDRERAL BUDGET");
      if (keywords != null) {
        moneycount += 1;
      }
      keywords = match(desFacets, "MURDERS");
      if (keywords != null) {
        crimecount += 1;
      }
      keywords = match(desFacets, "CRIME AND CRIMINALS");
      if (keywords != null) {
        crimecount += 1;
      }
      keywords = match(desFacets, "SHOOTING");
      if (keywords != null) {
        crimecount += 1;
      }
      keywords = match(desFacets, "OBITUARIES");
      if (keywords != null) {
        mourningcount += 1;
      }
      keywords = match(desFacets, "FUNERALS");
      if (keywords != null) {
        mourningcount += 1;
      }
      keywords = match(desFacets, "MILITARY");
      if (keywords != null) {
        militarycount += 1;
      }
      keywords = match(geoFacets, "MIDDLE EAST");
      if (keywords != null) {
        militarycount += 1;
      }
      keywords = match(geoFacets, "ISRAEL");
      if (keywords != null) {
        militarycount += 1;
      }
      keywords = match(geoFacets, "PALESTINE");
      if (keywords != null) {
        militarycount += 1;
      }
      keywords = match(geoFacets, "NORTH KOREA");
      if (keywords != null) {
        militarycount += 1;
      }
      keywords = match(desFacets, "HUMAN RIGHTS");
      if (keywords != null) {
        humanrightscount += 1;
      }
      keywords = match(desFacets, "HOMOSEXUALITY");
      if (keywords != null) {
        humanrightscount += 1;
      }
      keywords = match(desFacets, "SAME-SEX MARRIAGE");
      if (keywords != null) {
        humanrightscount += 1;
      }
      keywords = match(mainSection, "Health");
      if (keywords != null) {
        healthcount += 1;
      }
      keywords = match(desFacets, "HEALTH INSURANCE");
      if (keywords != null) {
        healthcount += 1;
      }
      
      println("Title: " + title);
      println("Section: " + mainSection);
      println("Abstract: " + _abstract);
      println("Subjects: " + desFacets);
     
    }
     println("The amount of articles about the Military concerns is: " + militarycount);
     println("The amount of articles from the Politics section is: " + politicscount);
     println("The amount of articles about Financial Concerns is: " + moneycount);
     println("The amount of articles about Crime is: " + crimecount);
     println("The amount of articles about Science and Technology is: " + sciencecount);
     println("The amount of articles about Health is: " + healthcount);
     println("The amount of articles about Social Equality is: " + humanrightscount);
  }
  //catching JSON errors
  catch (JSONException e) {  
    println (e.toString());
  }
  //making a string out of the section name and its total to prepare for sorting
  String a = (str(militarycount) + ":Military");
  String b = (str(politicscount) + ":Politics");
  String c = (str(moneycount) + ":Money");
  String d = (str(crimecount) + ":Crime");
  String e = (str(sciencecount) + ":Science");
  String f = (str(healthcount) + ":Health");
  String g = (str(humanrightscount) + ":Human Rights");
  String h = (str(mourningcount) + ":Mourning");
  //a string array made of total:name for each section
  String [] trends = {a, b, c, d, e, f, g, h};
  String [] rank = sort(trends);//sorts strings in alphabetical order and thus reverse number order
  println(rank);
  return rank;
}



