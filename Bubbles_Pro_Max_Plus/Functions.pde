void checkMouseMovement() {
  //working together with 'show' to prevent the sphere from showing up at 0,0
  if (((pmouseX != mouseX || pmouseY != mouseY) || (show && (x != mouseX || y != mouseY))) && !paused) {
    x = mouseX;
    y = mouseY;
    show = true;
  }
}

void playBgm() {
  //manage the playing and pausing of bgm
  if (enableBgm && !bgm.isPlaying()) {
    bgm.loop();
  } else if (!enableBgm && bgm.isPlaying()) {
    bgm.stop();
  }
}

void playSFX() {
  //play the sfx if needed
  if (enableSFX) {
    sfx.play();
  }
}

boolean playSFX(boolean condition) {
  //play the sfx if needed, and passed a boolean value of whether the sfx has been played
  if (enableSFX && condition) {
    sfx.play();
  }
  return enableSFX && condition;
}


void adjustVigor() {
  //adjust how violently the bubbles move
  if (keyPressed && key == CODED && (keyCode == LEFT || keyCode == RIGHT)) {
    adjustingWithKey = true;
  } else if (adjustingWithKey) {
    playSFX(paused);
    adjustingWithKey = false;
    sfxPlayed = false;
  }
  if (!adjusting && paused && ((mouseX >= 329 && mouseX <= 469 && mouseY >= 240 && mouseY <= 250 || dist(mouseX, mouseY, map(vigor, 0, 1, 329, 469), 245) < 15) && (mousePressed || keyPressed && key == ' '))) {
    adjusting = true;
  } else if (!mousePressed && !keyPressed && adjusting) {
    playSFX(paused);
    adjusting = false;
  }
  if (adjustingWithKey) {
    //adjusting with left and right keys
    if (keyCode == RIGHT) {
      vigor = constrain(vigor+0.01, 0, 1);
      if (playSFX(needToPlaySFX() && vigor >= 1)){
        sfxPlayed = true;
      }
    } else if (keyCode == LEFT) {
      vigor = constrain(vigor-0.01, 0, 1);
      if (playSFX(needToPlaySFX() && vigor <= 0)){
        sfxPlayed = true;
      }
    }
  }
  if (adjusting) {
    //adjusting with the mouse
    vigor = constrain(map(mouseX, 329, 469, 0, 1), 0, 1);
  }
}

void darkModeTransition() {
  //transition between bright mode and dark mode
  if (turningBright) {
    darkMode -= 0.05;
  } else if (turningDark) {
    darkMode += 0.05;
  }
  //check if the index goes out of bound
  if (darkMode <= 0) {
    turningBright = false;
    darkMode = 0;
  } else if (darkMode >= 1) {
    turningDark = false;
    darkMode = 1;
  }
}

boolean needToReset() {
  return (! paused && dist(x, y, 0, 0) < diameter / 2.05 && dist(x, y, 800, 0) < diameter / 2.05 && dist(x, y, 800, 600) < diameter / 2.05 && dist(x, y, 0, 600) < diameter / 2.05 );
}

boolean needToPlay() {
  return (mousePressed || keyPressed && key == ' ') && !paused && show;
}

boolean needToHighlightReset() {
  return dist(mouseX, mouseY, 50, 550)<=30 || keyPressed && key == 'r';
}

boolean needToHighlightPause() {
  return (!(mouseX>225 && mouseX<575 && mouseY>125 && mouseY<470) && dist(mouseX, mouseY, 50, 550)>30 && paused && (keyPressed && key == ' ' || mousePressed)) || dist(mouseX, mouseY, 750, 550)<=30 || keyPressed && key == 'p';
}

boolean needToHighlightScreenshot() {
  return keyPressed && key == 's' || (mousePressed || keyPressed && key == ' ' ) && mouseX>288 && mouseX<512 && mouseY>402 && mouseY<443;
}

boolean needToPlaySFX(){
 return enableSFX && !paused && !sfxPlayed && adjustingWithKey;
}

void reset() {
  //reset everything for the next game
  num = int(random(120, 150));
  diameter = random(70, 90);
  hsbColor[0] = random(360);
  hsbColor[1] = random(60, 90);
  hsbColor[2] = random(50, 80);
  for (int i = 0; i < num; i += 1) {
    bubbles[i] = new Bubble(random(40, 55), color(hsbColor[0] + random(-20, 20), random(20, 100), random(30, 80)), random(0, 800), random(0, 800), random(20, 60));
  }
  buffer = 0;
}
