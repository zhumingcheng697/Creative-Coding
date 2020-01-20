//Created by McCoy Zhu on October 16, 2019
//Background music from the game Alto’s Adventure by Team Alto
//Sound effects from Final Cut Pro Sound Effects
//Font SF Compact licensed by Apple Inc. solely for creating mock-ups of user interfaces to be used in software products running on Apple’s operating systems

import processing.sound.*;

int num; //number of bubbles (randomly generated for each game)
int count = 0; //number of games played
int buffer = 0; //time after a key press or mouse press
int bufferLimit = 8; //time needed to register a long press
float darkMode = 0; //something to let dark mode transition smoothly
float vigor = 0.2; //how violently the bubbles move
float diameter, x, y; //parameter of the sphere
float hsbColor[] = new float[3]; //color of the sphere
boolean adjusting = false; //if vigor is being adjusted by space bar or mouse
boolean adjustingWithKey = false; //if vigor is being adjusted by up and down keys
boolean show = false; //if need to show the sphere (prevent it from poping up at 0,0)
boolean paused = false; //if game is paused
boolean sfxPlayed = false; //if sfx has been played (prevent sfx from playing continuously)
boolean enableSFX = false; //if sound effect is enabled
boolean enableBgm = false; //if bgm is enabled
boolean turningBright = false; //if is turning to bright mode
boolean turningDark = false; //if is turning to dark mode
boolean gonnaScreenShot = false; //if is going to take a screenshot at the next frame
String timePlayed = ""; //the string that shows how long the gamer has been playing
Bubble[] bubbles = new Bubble[150]; //an array of the bubbles in a bubble class
PFont font; //the font used
SoundFile bgm, sfx, ding, shutter; //sound files for sfx and bgm

void setup() {
  size(800, 600);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  strokeJoin(ROUND);
  strokeCap(ROUND);
  rectMode(CORNERS);
  reset();
  bgm = new SoundFile(this, "Zen_Mode.wav");
  sfx = new SoundFile(this, "sfx.wav");
  ding = new SoundFile(this, "ding.wav");
  shutter = new SoundFile(this, "shutter.wav");
  font = createFont("SFCompactText.ttf", 12);
  textFont(font, 12);
  pixelDensity(2);
}

void mouseReleased() {
  if (buffer > bufferLimit) {//prevent one mouse press from being registered as multiple ones
    if (dist(mouseX, mouseY, 50, 550) <= 30) {
      reset();
      playSFX();
    } else if ((dist(mouseX, mouseY, 498, 287) < 15 || dist(mouseX, mouseY, 517, 287) < 15 || (mouseX > 498 && mouseX < 517 && mouseY > 272 && mouseY < 302)) && paused) {
      if (darkMode == 0 || turningBright) {
        turningDark = true;
        turningBright = false;
      } else if (darkMode == 1 || turningDark) {
        turningBright = true;
        turningDark = false;
      }
      playSFX();
    } else if ((dist(mouseX, mouseY, 498, 327) < 15 || dist(mouseX, mouseY, 517, 327) < 15 || (mouseX > 498 && mouseX < 517 && mouseY > 312 && mouseY < 342)) && paused) {
      enableSFX = !enableSFX;
      playSFX();
    } else if ((dist(mouseX, mouseY, 498, 367) < 15 || dist(mouseX, mouseY, 517, 367) < 15 || (mouseX > 498 && mouseX < 517 && mouseY > 352 && mouseY < 382)) && paused) {
      enableBgm = !enableBgm;
      playSFX();
    } else if (mouseX > 288 && mouseX < 512 && mouseY > 402 && mouseY < 443 && paused) {
      gonnaScreenShot = true;
    } else if (dist(mouseX, mouseY, 750, 550) <= 30 || !(mouseX > 225 && mouseX < 575 && mouseY > 125 && mouseY < 470) && paused) {
      paused = !paused;
      playSFX();
    }
  }
  buffer = 0;//reset after a mouse press
}

void keyReleased() {
  if (buffer > bufferLimit) {//prevent one key press from being registered as multiple ones
    if (key == ' ' && dist(mouseX, mouseY, 50, 550) <= 30) {
      reset();
      playSFX();
    } else if (key == 'd' || key == ' ' && (dist(mouseX, mouseY, 498, 287) < 15 || dist(mouseX, mouseY, 517, 287) < 15 || (mouseX > 498 && mouseX < 517 && mouseY > 272 && mouseY < 302)) && paused) {
      if (darkMode == 0 || turningBright && !turningDark) {
        turningDark = true;
        turningBright = false;
      } else if (darkMode == 1 || !turningBright && turningDark) {
        turningBright = true;
        turningDark = false;
      }
      playSFX(paused);
    } else if (key == 'f' || key == ' ' && (dist(mouseX, mouseY, 498, 327) < 15 || dist(mouseX, mouseY, 517, 327) < 15 || (mouseX > 498 && mouseX < 517 && mouseY > 312 && mouseY < 342)) && paused) {
      enableSFX = !enableSFX;
      if (enableSFX && !paused) {
        ding.play();
      } else if (ding.isPlaying()) {
        ding.stop();
      }
      playSFX(paused);
    } else if (key == 'm' || key == ' ' && (dist(mouseX, mouseY, 498, 367) < 15 || dist(mouseX, mouseY, 517, 367) < 15 || (mouseX > 498 && mouseX < 517 && mouseY > 352 && mouseY < 382)) && paused) {
      enableBgm = !enableBgm;
      playSFX(paused);
    } else if (key == 's' || key == ' ' && mouseX > 288 && mouseX < 512 && mouseY > 402 && mouseY < 443 && paused) {
      gonnaScreenShot = true;
    } else if (key == 'p' || (key == ' ' && (dist(mouseX, mouseY, 750, 550) <= 30 || !(mouseX > 225 && mouseX < 575 && mouseY > 125 && mouseY < 470) && paused))) {
      paused = !paused;
      playSFX();
    }
  }
  buffer = 0;//reset after a key press
}

void draw() {
  background(0, 0, 100 - 100*darkMode);
  checkMouseMovement();//see Functions for detail
  playBgm();
  adjustVigor();//see Functions for detail
  darkModeTransition();//see Functions for detail
  if (needToPlay()) {
    //bubbles being pulled to the sphere
    for (int i = 0; i < num; i += 1) {
      bubbles[i].interactWithSphere(x, y, diameter);
    }
    //enlarge sphere
    if (diameter < 2000) {
      diameter *= pow(1.2+0.6*vigor, diameter / (5000-vigor*2000));
    }
    //turn up the brightness of the sphere
    hsbColor[2] = (hsbColor[2] * 50 + (100-18*darkMode)) /51;
  } else if (needToReset()) {
    //auoto reset
    count++;//increment the number of games played
    if (enableSFX) {
      ding.play();
    }
    reset();
  } else if (keyPressed && key == 'r' && buffer > bufferLimit) {
    //manually reset
    playSFX();
    reset();
  }
  for (int i = 0; i < num; i += 1) {
    //bubbles moving randomly
    if (!paused || adjusting || adjustingWithKey) {
      bubbles[i].twinkleAndWiggle();//see Bubbles for detail
    }
    bubbles[i].display();//see Bubbles for detail
  }
  if (show) {
    //displaying the sphere
    fill(hsbColor[0], hsbColor[1], hsbColor[2]-30*darkMode, 100);
    ellipse(x, y, diameter, diameter);
  }
  if (gonnaScreenShot) {
    saveFrame("Bubbles_##.jpg");//take a screenshot
    if (enableSFX || (enableBgm && !paused)) {
      shutter.play();
    }
    gonnaScreenShot = false;
  }
  if (paused) {
    pauseScreen();//see Views for detail
  }
  resetButton();//see Views for detail
  pauseButton();//see Views for detail
  buffer++;//increment after each frame
}
