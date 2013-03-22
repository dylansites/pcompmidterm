int redPin = 11;
int greenPin = 10;
int bluePin = 9;

void setup(){
  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);
}

void loop ()
  {
    setColor(255, 0, 0); //red
    delay(1000);
    setColor(255, 30, 0); // orange
    delay(1000);
    setColor(255, 80, 0); //yellow
    delay(1000);
    setColor(0, 255, 0); //green
    delay(1000);
    setColor(0, 255, 150); // cyan
    delay(1000);
    setColor(0, 0, 255); //blue
    delay(1000);
    setColor(200, 0, 255); //purple
    delay(1000);
    setColor(255,100,100); //white
    delay(1000);
  }

void setColor(int red, int green, int blue)
{
  analogWrite(redPin, red);
  analogWrite(greenPin, green);
  analogWrite(bluePin, blue);
}
