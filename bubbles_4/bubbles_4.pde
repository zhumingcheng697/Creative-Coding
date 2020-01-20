//Created by McCoy Zhu on September 24, 2019

float diameter, x, y, num, buffer;
float bufferLimit = 8;
float hsbColor[] = new float[3];
int darkMode = 0;
int vigorousMode = 0;
boolean show = false;
boolean paused = false;
boolean enableReset = true;
boolean gonnaScreenShot = false;
Bubble[] bubbles = new Bubble[150];

void setup() {
  size(800, 600);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  strokeJoin(ROUND);
  strokeCap(ROUND);
  reset();
  //pixelDensity(2);
}

void mouseReleased() {
  if (dist(mouseX, mouseY, 50, 550)<=30 && buffer > bufferLimit && enableReset) {
    reset();
  } else if ((dist(mouseX, mouseY, 498, 247)<15 || dist(mouseX, mouseY, 517, 247)<15 || (mouseX>498&&mouseX<517&&mouseY>232&&mouseY<262))&& paused) {
    darkMode = 1 - darkMode;
  } else if ((dist(mouseX, mouseY, 498, 287)<15 || dist(mouseX, mouseY, 517, 287)<15 || (mouseX>498&&mouseX<517&&mouseY>272&&mouseY<302))&& paused) {
    vigorousMode = 1 - vigorousMode;
  } else if ((dist(mouseX, mouseY, 498, 327)<15 || dist(mouseX, mouseY, 517, 327)<15 || (mouseX>498&&mouseX<517&&mouseY>312&&mouseY<342))&& paused) {
    enableReset = !enableReset;
  } else if (buffer > bufferLimit && mouseX>288 && mouseX<512 && mouseY>367 && mouseY<408 && paused) {
    gonnaScreenShot = true;
  } else if ((dist(mouseX, mouseY, 750, 550)<=30 || !(mouseX>225 && mouseX<575 && mouseY>125 && mouseY<445) && paused)&& buffer > bufferLimit ) {
    paused = !paused;
  }
  buffer = 0;
}

void keyReleased() {
  if (key == ' ' && dist(mouseX, mouseY, 50, 550)<=30 && buffer > bufferLimit && enableReset) {
    reset();
  } else if (buffer > bufferLimit && (key == 'd' || key == ' ' && (dist(mouseX, mouseY, 498, 247)<15 || dist(mouseX, mouseY, 517, 247)<15 || (mouseX>498&&mouseX<517&&mouseY>232&&mouseY<262))&& paused)) {
    darkMode = 1 - darkMode;
  } else if (buffer > bufferLimit && (key == 'v' || key == ' ' && (dist(mouseX, mouseY, 498, 287)<15 || dist(mouseX, mouseY, 517, 287)<15 || (mouseX>498&&mouseX<517&&mouseY>272&&mouseY<302))&& paused)) {
    vigorousMode = 1 - vigorousMode;
  } else if (buffer > bufferLimit && (key == 'm' || key == ' ' && (dist(mouseX, mouseY, 498, 327)<15 || dist(mouseX, mouseY, 517, 327)<15 || (mouseX>498&&mouseX<517&&mouseY>312&&mouseY<342))&& paused)) {
    enableReset = !enableReset;
  } else if (buffer > bufferLimit && (key == 's' || key == ' ' && mouseX>288 && mouseX<512 && mouseY>367 && mouseY<408 && paused)) {
    gonnaScreenShot = true;
  } else if (((key == ' ' && (dist(mouseX, mouseY, 750, 550)<=30 || !(mouseX>225 && mouseX<575 && mouseY>125 && mouseY<445) && paused)) || key == 'p' ) && buffer > bufferLimit) {
    paused = !paused;
  } 
  buffer = 0;
}

void draw() {
  background(0, 0, 100 - 100*darkMode);
  checkMouseMovement();
  if (needToPlay()) {
    for (int i = 0; i < num; i += 1) {
      bubbles[i].interactWithSphere(x, y, diameter);
    }
    if (diameter < 2000) {
      diameter *= pow(1.4+0.3*vigorousMode, diameter / (4500-vigorousMode*1000));
    }
    hsbColor[2] = (hsbColor[2] * 50 + (100-18*darkMode)) /51;
  } else if (needToReset()) {
    reset();
  }

  for (int i = 0; i < num; i += 1) {
    if (!paused || vigorousMode == 1) {
      bubbles[i].twinkleAndWiggle();
    }
    bubbles[i].display();
  }

  if (show) {
    fill(hsbColor[0], hsbColor[1], hsbColor[2]-30*darkMode, 100);
    ellipse(x, y, diameter, diameter);
  }
  if (gonnaScreenShot) {
    saveFrame("Bubbles_##.jpg");
    gonnaScreenShot = false;
  }
  if (paused) {
    pauseScreen();
  }
  if (enableReset) {
    resetButton();
  }
  pauseButton();
  buffer++;
}
