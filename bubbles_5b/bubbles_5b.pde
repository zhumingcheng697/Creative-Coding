//Created by McCoy Zhu on October 1, 2019

//- Improved the key-press detection algorithm so the scene won’t reset more than once unless a long-press is detected.
import processing.sound.*;

int num;
int buffer = 0;
int bufferLimit = 8;
int count = 0;
float darkMode = 0;
float vigorousMode = 0.2;
float diameter, x, y;
float hsbColor[] = new float[3];
boolean adjusting;
boolean show = false;
boolean paused = false;
boolean enableBgm = true;
boolean turningBright = false;
boolean turningDark = false;
boolean gonnaScreenShot = false;
String timePlayed = "";
Bubble[] bubbles = new Bubble[150];
SoundFile bgm;

void setup() {
  size(800, 600);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  strokeJoin(ROUND);
  strokeCap(ROUND);
  reset();
  bgm = new SoundFile(this, "Zen_Mode.wav");
  //pixelDensity(2);
}

void mouseReleased() {
  if (buffer > bufferLimit) {
    if (dist(mouseX, mouseY, 50, 550) <= 30) {
      reset();
    } else if ((dist(mouseX, mouseY, 498, 287) < 15 || dist(mouseX, mouseY, 517, 287) < 15 || (mouseX > 498 && mouseX < 517 && mouseY > 272 && mouseY < 302)) && paused) {
      if (darkMode == 0 || turningBright) {
        turningDark = true;
        turningBright = false;
      } else if (darkMode == 1 || turningDark) {
        turningBright = true;
        turningDark = false;
      }
    } else if ((dist(mouseX, mouseY, 498, 327) < 15 || dist(mouseX, mouseY, 517, 327) < 15 || (mouseX > 498 && mouseX < 517 && mouseY > 312 && mouseY < 342)) && paused) {
      enableBgm = !enableBgm;
    } else if (mouseX > 288 && mouseX < 512 && mouseY > 367 && mouseY < 408 && paused) {
      gonnaScreenShot = true;
    } else if (dist(mouseX, mouseY, 750, 550) <= 30 || !(mouseX > 225 && mouseX < 575 && mouseY > 125 && mouseY < 445) && paused) {
      paused = !paused;
    }
  }
  buffer = 0;
}

void keyReleased() {
  if (buffer > bufferLimit) {
    if (key == ' ' && dist(mouseX, mouseY, 50, 550) <= 30) {
      reset();
    } else if (key == 'd' || key == ' ' && (dist(mouseX, mouseY, 498, 287) < 15 || dist(mouseX, mouseY, 517, 287) < 15 || (mouseX > 498 && mouseX < 517 && mouseY > 272 && mouseY < 302)) && paused) {
      if (darkMode == 0 || turningBright && !turningDark) {
        turningDark = true;
        turningBright = false;
      } else if (darkMode == 1 || !turningBright && turningDark) {
        turningBright = true;
        turningDark = false;
      }
    } else if (key == 'm' || key == ' ' && (dist(mouseX, mouseY, 498, 327) < 15 || dist(mouseX, mouseY, 517, 327) < 15 || (mouseX > 498 && mouseX < 517 && mouseY > 312 && mouseY < 342)) && paused) {
      enableBgm = !enableBgm;
    } else if (key == 's' || key == ' ' && mouseX > 288 && mouseX < 512 && mouseY > 367 && mouseY < 408 && paused) {
      gonnaScreenShot = true;
    } else if (key == 'p' || (key == ' ' && (dist(mouseX, mouseY, 750, 550) <= 30 || !(mouseX > 225 && mouseX < 575 && mouseY > 125 && mouseY < 445) && paused))) {
      paused = !paused;
    }
  }
  buffer = 0;
}

void draw() {
  background(0, 0, 100 - 100*darkMode);
  checkMouseMovement();
  playBgm();
  adjustVigor();
  darkModeTransition();
  if (needToPlay()) {
    for (int i = 0; i < num; i += 1) {
      bubbles[i].interactWithSphere(x, y, diameter);
    }
    if (diameter < 2000) {
      diameter *= pow(1.2+0.6*vigorousMode, diameter / (5000-vigorousMode*2000));
    }
    hsbColor[2] = (hsbColor[2] * 50 + (100-18*darkMode)) /51;
  } else if (needToReset() || (keyPressed && key == 'r' && buffer > bufferLimit)) {
    if (needToReset()) {
      count++;
    }
    reset();
  }
  for (int i = 0; i < num; i += 1) {
    if (!paused || adjusting) {
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
  resetButton();
  pauseButton();
  buffer++;
}
