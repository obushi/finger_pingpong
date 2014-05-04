import com.onformative.leap.*;
import com.leapmotion.leap.Finger;
final int SIZE = 20; // Size of each blocks in pixel

LeapMotionP5 leap;
Ball ball;

public void setup() {
  size(600, 600);
  leap = new LeapMotionP5(this);
  ball = new Ball();
  noStroke();
}

public void draw() {
  fill(0, 0, 0, 60);
  rect(0, 0, width, height);
  fill(255); 
  for (Finger finger : leap.getFingerList()) {
    PVector fingerPos = leap.getTip(finger);
    for (float i=0; i<width; i++) {
      for (float j=0; j<height; j++) {
        if (fingerPos.x > i-SIZE && fingerPos.x < i+SIZE) {
          if (fingerPos.y > j-SIZE && fingerPos.y < j+SIZE) { 
            PVector box = new PVector(((int(fingerPos.x)/SIZE)-1)*SIZE, ((int(fingerPos.y)/SIZE)-1)*SIZE); // Coordinate of the finger blocks
            rect(box.x, box.y, SIZE, SIZE);
            
            // If there's any collisions, this will change the direction of the velocity vector.
            if (ball.pos.x+ball.r > box.x+SIZE && ball.pos.x-ball.r < box.x) {
              if (ball.pos.y+ball.r > box.y+SIZE && ball.pos.y-ball.r < box.y) {
                ball.v.x *= -1;
                ball.v.y *= -1;
                ball.update();
              }
            }
          }
        }
      }
    }
  }
  ball.show();
  ball.update();
}

class Ball {
  int r; 
  PVector v, a, pos;
  Ball() {
    r = 50;
    v = new PVector(10, 8);
    a = new PVector(1, 1);
    pos = new PVector(width/2, height/2);
  }
  void show() {
    if (this.pos.x >= width || this.pos.x <= 0) {
      this.v.x *= -1;
    } 
    else if (this.pos.y >= height || this.pos.y <= 0) {
      this.v.y *= -1;
    }
    ellipse(this.pos.x, this.pos.y, this.r, this.r);
    println("pos.x:"+this.pos.x+" pos.y:"+this.pos.y);
  }
  void update() {
    this.pos.x += this.v.x;
    this.pos.y += this.v.y;
    this.v.x *= this.a.x;
    this.v.y *= this.a.y;
  }
}

