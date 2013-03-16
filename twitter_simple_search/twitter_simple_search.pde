//Build an ArrayList to hold all of the words that we get from the imported tweets
ArrayList<String> words = new ArrayList();
import java.util.*; //This is a java library that imports utilities required for the twitter api
int a;

String msg; // setting up a string
void setup() {
  //Set the size of the stage, and the background to black.
  size(550, 550);  //size of the browser
  background(0);   //color of the background
  smooth();
  a = 0;

  //Credentials
  ConfigurationBuilder cb = new ConfigurationBuilder();  //this is a new object that is instantiated for the twitter api
  // These next four authentification keys are specific to my twitter account and allow the api to collect information and function. 
  cb.setOAuthConsumerKey("8UJFwCBg7j0xVbwWU3IxuQ");  
  cb.setOAuthConsumerSecret("UDn23jYBD46OFwVW7dsbOO7rVeFzKLZHfmMU4FcfCQ0");
  cb.setOAuthAccessToken("334008120-RS9NOUly4qtpMujXO3KPXsKfWgTkRFuevulqJJ8p");
  cb.setOAuthAccessTokenSecret("baZTqiwJTd2BPSgfM5UmeF3dG6ygKI8ZB2MHRU99jg");

  //Make the twitter object and prepare the query
  Twitter twitter = new TwitterFactory(cb.build()).getInstance();
  //This instantiates a new query object that searches based on the hashtag for Obama. 
  Query query = new Query("#Obama"); //You can change the term and it would change the search.
  query.count(1); // This indicates how much the query should return. If you change this number to 100...the search will yield more results.

  //Try making the query request.
  try {
    QueryResult result = twitter.search(query); //This creates another object for the QueryResult
    ArrayList tweets = (ArrayList) result.getTweets(); //This creates an ArrayList based on the results of the search. Try printing out this list.
    
    for (int i = 0; i < tweets.size(); i++) {//continue counting through the tweets until you reach the end of the search results
      Status t = (Status) tweets.get(i); //creates anoter object call tweet which holds the tweet status
      User u = (User) t.getUser(); //creates an object which holds the user name that the tweet originates from
      String user = u.getName(); //get the name of the user (getName is from the twitter API)
      msg = t.getText(); //uses the string that we created above to get the text of the tweet.
      Date d = t.getCreatedAt(); //creates an object which grabs the date that the tweet originated from.
      println("Tweet by " + user + " at " + d + ": " + msg); //prints to the console

      //Break the tweet into words
      String[] input = msg.split(" "); //split based on the spacing between the words in the tweet.
      for (int j = 0;  j < input.length; j++) {//go through the tweet until there are no words left
        //Put each word into the words ArrayList
        words.add(input[j]); //add the words to the ArrayList
      }
    };
  }
  catch (TwitterException te) { //if the sketch doesnt have connection to the internet...or the correct password...this will lead to this exception.
    println("Couldn't connect: " + te);
  };
}

void draw() {
  //Draw a faint black rectangle over what is currently on the stage so it fades over time.
  if(a < words.size()){
    a = a+1;
  fill(0, 1);
  rect(0, 0, width, height);

  //Draw a word from the list of words that we've built
  int i = (frameCount % words.size()); //this is why the tweet's words show up randomly
  String word = words.get(i);

  //Put it somewhere random on the stage, with a random size and colour
  fill(random(255), random(255), random(255));
  textSize(random(10, 30));
  text(word, random(width), random(height));
  }
}

