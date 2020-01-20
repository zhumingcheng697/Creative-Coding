//Created by McCoy Zhu on September 24, 2019

float diameter, x, y, num, buffer;
float bufferLimit = 8;
float hsbColor[] = new float[3];
boolean show = false;
Bubble[] bubbles = new Bubble[150];

void setup() {
  size(800, 600);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  strokeJoin(ROUND);
  strokeCap(ROUND);
  reset();
}

void mouseReleased() {
  if (dist(mouseX, mouseY, 50, 550)<=30 && buffer > bufferLimit) {
    reset();
  }
  buffer = 0;
}

void keyReleased() {
  if (key == ' ' && dist(mouseX, mouseY, 50, 550)<=30 && buffer > bufferLimit) {
    reset();
  }
  buffer = 0;
}

void draw() {
  background(0, 0, 100);
  checkMouseMovement();
  if (needToPlay()) {
    for (int i = 0; i < num; i += 1) {
      bubbles[i].interactWithSphere(x, y, diameter);
    }
    if (diameter < 2000) {
      diameter *= pow(1.4, diameter / 4000);
    }
    hsbColor[2] = (hsbColor[2] * 50 + 100) / 51;
  } else if (needToReset()) {
    reset();
  }
  for (int i = 0; i < num; i += 1) {
    bubbles[i].twinkleAndWiggle();
    bubbles[i].display();
  }
  if (show) {
    fill(hsbColor[0], hsbColor[1], hsbColor[2], 100);
    ellipse(x, y, diameter, diameter);
  }
  resetButton();
  buffer++;
}
