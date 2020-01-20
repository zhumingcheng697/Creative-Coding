class Ball {
  float x, y, vX, vY, diameter, h, s, b;
  color hsbColor; 
  Ball(float ddiameter, float hh) {
    x = 240;
    y = 240;
    vX = 0;
    vY = 0;
    diameter = ddiameter;
    h = hh;
    s = 80;
    b = 70;
  }
  void reset() {
    diameter = 0;
    vX = 0;
    vY = 0;
    h = random(0, 360);
    s = 80;
    b = 70;
    n = 0;
    block = false;
  }
  void move() {
    x += vX;
    y += vY;
    if (x<40+diameter/2 || x>440-diameter/2) {
      vX = -vX;
      vY += random(-0.1, 0.1);
      b = (b*10 + 10)/11;
      n++;
      //block = pow(-1, int(random(0, 3)))>0;
      block = false;
    }
    if (y<40+diameter/2 || y>440-diameter/2) {
      vY = -vY;
      vX += random(-0.1, 0.1);
      b = (b*10 + 10)/11;
      n++;
      //block = pow(-1, int(random(0, 3)))>0;
      block = false;
    }
    if (block&&(((abs(x-y+280)/sqrt(2))<20 && x+y-420>=0 && x+y-540<=0)||((abs(x-y-280)/sqrt(2))< 20 && x+y-420>=0 && x+y-540<=0))) {
      float temp1 = vX;
      float temp2 = vY;
      vY = temp1;
      vX = temp2;
      vX += random(-1, 1);
      vY += random(-1, 1);
      b = (b*10 + 10)/11;
      n++;
      //block = pow(-1, int(random(0, 3)))>0;
      //block = !block;
    }
    if (block&&(((abs(x+y-760)/sqrt(2))< 20 && x-y+60>=0 && x-y-60<=0)||((abs(x+y-200)/sqrt(2))< 20 && x-y+60>=0 && x-y-60<=0))) {
      float temp1 = vX;
      float temp2 = vY;
      vY = -temp1;
      vX = -temp2;
      vX += random(-1, 1);
      vY += random(-1, 1);
      b = (b*10 + 10)/11;
      n++;
      //block = pow(-1, int(random(0, 3)))>0;
      //block = !block;
    }
    if (dist(x, y, 40, 40)<40 || dist(x, y, 440, 40)<40 || dist(x, y, 40, 440)<40 || dist(x, y, 440, 440)<40) {
      reset();
      showCircle = true;
    }
  }
  void display() {
    fill(h, s, b, 100);
    ellipse(x, y, diameter, diameter);
  }
}
