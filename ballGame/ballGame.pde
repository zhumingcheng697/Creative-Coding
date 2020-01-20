Ball theBall;
float x, y;
float theta = 0;
int n = 0;
boolean showCircle = true;
boolean isDragging = false;
boolean block = false;

void setup() {
  size(480, 480);
  colorMode(HSB, 360, 100, 100, 100);
  x = 240;
  y = 240;
  theBall = new Ball(40, random(0, 360));
}

void mouseReleased() {
  if ((x != 240 || y != 240 ) && showCircle && isDragging) {
    showCircle = false;
    isDragging = false;
    theBall.vX = (240-x + random(-1, 1))/8;
    theBall.vY = (240-y + random(-1, 1))/8;
    x = 240;
    y = 240;
    block = true;
  }
}

void keyReleased() {
  if (key == 'r') {
    showCircle = true;
    theBall.reset();
  }
}

void draw() {
  if (dist(mouseX, mouseY, 240, 240)<30 && mousePressed) {
    isDragging = true;
    theBall.x = mouseX;
    theBall.y = mouseY;
    theBall.diameter = 40;
  }
  noStroke();
  fill(125, 50, 10);
  rect(10, 10, 460, 460);
  fill(125, 30, 100);
  rect(40, 40, 400, 400);
  fill(0, 0, 0);
  arc(40, 40, 100, 100, 0, radians(90));
  arc(40, 440, 100, 100, radians(270), radians(360));
  arc(440, 40, 100, 100, radians(90), radians(180));
  arc(440, 440, 100, 100, radians(180), radians(270));  
  if (isDragging) {
    stroke(0);
    strokeWeight(5);
    if (dist(240, 240, mouseX, mouseY)<100) {
      x = mouseX;
      y = mouseY;
    } else {
      x = (mouseX - 240)/dist(240, 240, mouseX, mouseY)*100 + 240;
      y = (mouseY - 240)/dist(240, 240, mouseX, mouseY)*100 + 240;
    }
    theBall.x = x;
    theBall.y = y;
    line(x, y, 240, 240);
    noStroke();
  }
  if (showCircle) {
    fill(0, 0, 100, 70);
    ellipse(x, y, 60, 60);
    
    theta += (sq(240-x)+sq(240-y))/50000;
    
    pushMatrix();
    translate(x,y);
    fill(theBall.h,theBall.s,theBall.b);
    rotate(millis()/300 + theta);
    ellipse(0, 40, 10, 10);
    rotate(TWO_PI/4);
    ellipse(0, 40, 10, 10);
    rotate(TWO_PI/4);
    ellipse(0, 40, 10, 10);
    rotate(TWO_PI/4);
    ellipse(0, 40, 10, 10);
    popMatrix();
    
    stroke(0, 0, 0);
    strokeWeight(5);
    line(x-10, y, x+10, y);
    line(x, y-10, x, y+10);
  } else {
    if (n<=2){
      block = true;
    }
    theBall.move();
    theBall.display();
    
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(36);
    if (n<=10) {
      text(str(n), 240, 238);
    } else {
      text(str(n)+"\nPress R to restart", 240, 238);
    }
  }
  if (block) {
    stroke(0);
    strokeWeight(12);
    line(70, 130, 130, 70);
    line(350, 410, 410, 350);
    line(70, 350, 130, 410);
    line(350, 70, 410, 130);
    noStroke();
  }
}
