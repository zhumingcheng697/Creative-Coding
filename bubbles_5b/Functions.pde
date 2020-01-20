void checkMouseMovement() {
  if (((pmouseX != mouseX || pmouseY != mouseY) || (show && (x != mouseX || y != mouseY))) && !paused) {
    x = mouseX;
    y = mouseY;
    show = true;
  }
}

void playBgm() {
  if (enableBgm && !bgm.isPlaying()) {
    bgm.loop();
  } else if (!enableBgm && bgm.isPlaying()) {
    bgm.stop();
  }
}

void adjustVigor() {
  if (paused && ((mouseX >= 344 && mouseX <= 464 && mouseY >= 224 && mouseY <= 266 || dist(mouseX, mouseY, map(vigorousMode, 0, 1, 344, 464), 247) < 22) && (mousePressed || keyPressed && key == ' '))) {
    adjusting = true;
  } else if (!mousePressed && !keyPressed) {
    adjusting = false;
  }
  if (adjusting) {
    if (mouseX < 344) {
      vigorousMode = 0;
    } else if (mouseX > 464) {
      vigorousMode = 1;
    } else {
      vigorousMode = map(mouseX, 344, 464, 0, 1);
    }
  }
}

void darkModeTransition() {
  if (turningBright) {
    darkMode -= 0.04;
  } else if (turningDark) {
    darkMode += 0.04;
  }
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
  return (!(mouseX>225 && mouseX<575 && mouseY>125 && mouseY<445) && dist(mouseX, mouseY, 50, 550)>30 && paused && (keyPressed && key == ' ' || mousePressed)) || dist(mouseX, mouseY, 750, 550)<=30 || keyPressed && key == 'p';
}

boolean needToHighlightScreenshot() {
  return keyPressed && key == 's' || (mousePressed || keyPressed && key == ' ' ) && mouseX>288 && mouseX<512 && mouseY>367 && mouseY<408;
}

void reset() {
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
