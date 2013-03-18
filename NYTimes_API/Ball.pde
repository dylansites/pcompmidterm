/*
class Dot {
  
  float x;
  float y;
  float r;
  float endX;
  float endY;
  float damping = 0.009;
  float spring = 0.05;
  boolean isHovered = false;

  
  Dot (float x_, float y_, float r_) {
    x = x_;
    y = y_;
    r = r_;
    
    // for gravitational pull towards the center, set endX and endY coordinates to center point
    endX = width/2;
    endY = height/2;
  }
  
  void display () {
    // increment end coordinates toward centerpoint
    endX = endX + (width/2 - endX) * damping;
    endY = endY + (height/2 - endY) * damping;
    
    //increment x and y coordinates
    x = x + (endX - x) * damping;
    y = y + (endY - y) * damping;
    
    if (!isHovered) {
      fill(255, 51, 51, 190);
    } else {
      fill(255, 0, 0);
    }
    noStroke();
    ellipse(x, y, r*2, r*2);
   }
  
  void position(float x, float y) {
    endX = x;
    endY = y;
  }
    
  void hitTest(Dot dot) {
    
    float minDistance = dot.r + r;
    
    //if a hit test is registered propel dops in the opposite direction
    if (dist(dot.x, dot.y, x, y) < minDistance) {
      
      //fist, get the difference between the two x, y coordinates
      float dx = dot.x - x;
      float dy = dot.y - y;
      
      /*
      next, calculate the angle in polar coordinates
      atan2 calculates the angle (in radians) from a specified point to the coordinate origin,
      as measured from the positive x-axis. more info here: http://processing.org/reference/atan2_.html
      */
      /*
      float angle = atan2(dy, dx);
      
      // now, calculate the target coordinate of the current dot by using the minimum distance
      float targetX = x + cos(angle) * minDistance;
      float targetY = y + sin(angle) * minDistance;
      
      // increment the x and y coordinates for both objects
      x = x - (targetX - dot.x) * spring;
      y = y - (targetY - dot.y) * spring;
      dot.x = dot.x + (targetX - dot.x) * spring;
      dot.y = dot.y + (targetY - dot.y) * spring;
    }
  }
   
  void propell() {
     
    // randomize angle relative to sketch center
    float angle = random(360);
     
    // increment endX and endY coordinates
    endX = x - cos(angle) * height/2;
    endY = y - sin(angle) * height/2;
  }
   
  void onMouseOver(float mx, float my) {
    if (dist(mx, my, x, y) < r) {
      isHovered = true;
    }
    else {
      isHovered = false;
    }
  }
   
}
*/
