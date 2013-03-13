//new comment

//Build an ArrayList to hold all of the words that we get from the imported tweets
ArrayList<String> words = new ArrayList();
import java.util.*;
int a;

String msg;
void setup() {
  //Set the size of the stage, and the background to black.
  size(550, 550);
  background(0);
  smooth();
  a = 0;

  //Credentials
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("8UJFwCBg7j0xVbwWU3IxuQ");
  cb.setOAuthConsumerSecret("UDn23jYBD46OFwVW7dsbOO7rVeFzKLZHfmMU4FcfCQ0");
  cb.setOAuthAccessToken("334008120-RS9NOUly4qtpMujXO3KPXsKfWgTkRFuevulqJJ8p");
  cb.setOAuthAccessTokenSecret("baZTqiwJTd2BPSgfM5UmeF3dG6ygKI8ZB2MHRU99jg");

  //Make the twitter object and prepare the query
  Twitter twitter = new TwitterFactory(cb.build()).getInstance();
  Query query = new Query("#Obama");
  query.count(1);

  //Try making the query request.
  try {
    QueryResult result = twitter.search(query);
    ArrayList tweets = (ArrayList) result.getTweets();

    for (int i = 0; i < tweets.size(); i++) {
      Status t = (Status) tweets.get(i);
      User u = (User) t.getUser();
      String user = u.getName();
      msg = t.getText();
      Date d = t.getCreatedAt();
      println("Tweet by " + user + " at " + d + ": " + msg);

      //Break the tweet into words
      String[] input = msg.split(" ");
      for (int j = 0;  j < input.length; j++) {
        //Put each word into the words ArrayList
        words.add(input[j]);
      }
    };
  }
  catch (TwitterException te) {
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
  int i = (frameCount % words.size());
  String word = words.get(i);

  //Put it somewhere random on the stage, with a random size and colour
  fill(random(255), random(255), random(255));
  textSize(random(10, 30));
  text(word, random(width), random(height));
  }
}

