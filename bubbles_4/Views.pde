void resetButton() {
  if (needToHighlightReset()) {
    fill(0, 0, 93-78*darkMode, 90+5*darkMode);
  } else if (!paused) {
    fill(0, 0, 80-60*darkMode, 50+20*darkMode);
  } else {
    fill(0, 0, 87-70*darkMode, 65+15*darkMode);
  }
  ellipse(50, 550, 60, 60);
  noFill();
  if (needToHighlightReset()) {
    stroke(0, 0, 15+70*darkMode);
  } else {
    stroke(0, 0, 35+33*darkMode);
  }
  strokeWeight(4);
  arc(50, 550, 30, 30, radians(-35), radians(270));
  triangle(56, 535, 50, 539, 50, 531);
  noStroke();
}

void pauseButton() {
  if (needToHighlightPause()) {
    fill(0, 0, 93-78*darkMode, 90+5*darkMode);
  } else if (!paused) {
    fill(0, 0, 80-60*darkMode, 50+20*darkMode);
  } else {
    fill(0, 0, 87-70*darkMode, 65+15*darkMode);
  }
  ellipse(750, 550, 60, 60);
  if (needToHighlightPause()) {
    fill(0, 0, 15+70*darkMode);
    stroke(0, 0, 15+70*darkMode);
  } else {
    fill(0, 0, 35+33*darkMode);
    stroke(0, 0, 35+33*darkMode);
  }
  if (paused) {
    strokeWeight(3);
    triangle(762, 550, 744, 539, 744, 561);
    noStroke();
  } else {
    noStroke();
    rectMode(CORNERS);
    rect(741, 537, 746, 563, 8);
    rect(754, 537, 759, 563, 8);
  }
}

void darkModeSwitch() {
  fill(hsbColor[0], 70*darkMode, 80-20*darkMode);
  for (int i = 498; i<= 517; i++) {
    ellipse(i, 247, 28, 28);
  }
  fill(0, 0, 100);
  ellipse(498+darkMode*19, 247, 24, 24);
}

void vigorousModeSwitch() {
  if (vigorousMode == 1) {
    fill(hsbColor[0], 80-10*darkMode, 80-20*darkMode);
  } else {
    fill(0, 0, 80-20*darkMode);
  }
  for (int i = 498; i<= 517; i++) {
    ellipse(i, 287, 28, 28);
  }
  fill(0, 0, 100);
  if (vigorousMode == 1) {
    ellipse(517, 287, 24, 24);
  } else {
    ellipse(498, 287, 24, 24);
  }
}

void manualResetSwitch() {
  if (enableReset) {
    fill(hsbColor[0], 80-10*darkMode, 80-20*darkMode);
  } else {
    fill(0, 0, 80-20*darkMode);
  }
  for (int i = 498; i<= 517; i++) {
    ellipse(i, 327, 28, 28);
  }
  fill(0, 0, 100);
  if (enableReset) {
    ellipse(517, 327, 24, 24);
  } else {
    ellipse(498, 327, 24, 24);
  }
}

void screenshotButton() {
  if (needToHighlightScreenshot()) {
    fill(hsbColor[0], 60-10*darkMode, 70-20*darkMode);
  } else {
    fill(hsbColor[0], 80-10*darkMode, 80-20*darkMode);
  }
  rect(288, 367, 512, 408, 12);
  textAlign(CENTER, CENTER);
  if (needToHighlightScreenshot()) {
    fill(0, 0, 85-10*darkMode);
  } else {
    fill(0, 0, 100);
  }
  textSize(18);
  text("Capture Screenshot", 400, 386);
}

void pauseScreen() {
  fill(0, 0, 40+10*darkMode, 70-10*darkMode);
  rect(0, 0, 800, 600);
  fill(0, 0, 100-100*darkMode, 90-10*darkMode);
  rect(225, 125, 575, 445, 30);
  fill(0, 0, 0+100*darkMode);
  textAlign(CENTER, CENTER);
  textSize(36);
  text("Bubbles", 400, 170);
  textSize(15);
  text("Created with Love by McCoy Zhu", 400, 200);
  textAlign(LEFT, CENTER);
  textSize(22);
  text("Dark Mode", 269, 245); 
  text("Vigorous Mode", 269, 285); 
  text("Manual Reset", 269, 325);
  darkModeSwitch();
  vigorousModeSwitch();
  manualResetSwitch();
  screenshotButton();
}
