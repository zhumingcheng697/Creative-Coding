void resetButton() {
  //circle bg
  if (needToHighlightReset()) {
    fill(0, 0, 93-78*darkMode, 90+5*darkMode);
  } else if (!paused) {
    fill(0, 0, 80-60*darkMode, 50+20*darkMode);
  } else {
    fill(0, 0, 87-70*darkMode, 65+15*darkMode);
  }
  ellipse(50, 550, 60, 60);
  //curve
  noFill();
  if (needToHighlightReset()) {
    stroke(0, 0, 15+70*darkMode);
  } else {
    stroke(0, 0, 35+33*darkMode);
  }
  strokeWeight(4);
  arc(50, 550, 30, 30, radians(-30), radians(270));
  //triangle
  triangle(56, 535, 50, 539, 50, 531);
  noStroke();
}

void pauseButton() {
  //circle bg
  if (needToHighlightPause()) {
    fill(0, 0, 93-78*darkMode, 90+5*darkMode);
  } else if (!paused) {
    fill(0, 0, 80-60*darkMode, 50+20*darkMode);
  } else {
    fill(0, 0, 87-70*darkMode, 65+15*darkMode);
  }
  ellipse(750, 550, 60, 60);
  //play triangle or pause rectangles
  if (needToHighlightPause()) {
    fill(0, 0, 15+70*darkMode);
    stroke(0, 0, 15+70*darkMode);
  } else {
    fill(0, 0, 35+33*darkMode);
    stroke(0, 0, 35+33*darkMode);
  }
  if (paused) {//play triangle when paused
    strokeWeight(3);
    triangle(762, 550, 744, 539, 744, 561);
    noStroke();
  } else {//pause rectangles when playing
    noStroke();
    rect(741, 537, 746, 563, 8);
    rect(754, 537, 759, 563, 8);
  }
}

void vigorSlider() {
  //rotating stuff
  for (int i = 0; i<20; i++) {
    fill(0, 0, 65+5*darkMode, 80-80/20*i);
    ellipse(295+8*cos((millis()/150)-0.18*i), 234+8*sin((millis()/150)-0.18*i), 4, 4);
    ellipse(505-8*cos((millis()/50)-0.15*i), 234+8*sin((millis()/50)-0.15*i), 5*pow(0.97, i), 5*pow(0.97, i));
  }
  //full slider
  strokeWeight(4);
  stroke(0, 0, 80-50*darkMode);
  line(329, 245, 469, 245);
  //colored slider
  stroke(hsbColor[0], 80-10*darkMode, 80-20*darkMode);
  line(329, 245, map(vigor, 0, 1, 329, 469), 245);
  //indicator
  noStroke();
  fill(0, 0, 100);
  ellipse(map(vigor, 0, 1, 329, 469), 245, 20, 20);
}

void darkModeSwitch() {
  //base
  if (darkMode == 0 || turningBright) {
    fill(hsbColor[0], 0, 75-45*darkMode);
  } else {
    fill(hsbColor[0], 80-10*darkMode, 80-20*darkMode);
  }
  for (int i = 498; i<= 517; i++) {
    ellipse(i, 287, 28, 28);
  }
  //button
  fill(0, 0, 100);
  if (darkMode == 0 || turningBright) {
    ellipse(498, 287, 24, 24);
  } else {
    ellipse(498+19, 287, 24, 24);
  }
}

void sfxSwitch() {
  //base
  if (enableSFX) {
    fill(hsbColor[0], 80-10*darkMode, 80-20*darkMode);
  } else {
    fill(0, 0, 75-45*darkMode);
  }
  for (int i = 498; i<= 517; i++) {
    ellipse(i, 327, 28, 28);
  }
  //button
  fill(0, 0, 100);
  if (enableSFX) {
    ellipse(517, 327, 24, 24);
  } else {
    ellipse(498, 327, 24, 24);
  }
}

void bgmSwitch() {
  //base
  if (enableBgm) {
    fill(hsbColor[0], 80-10*darkMode, 80-20*darkMode);
  } else {
    fill(0, 0, 75-45*darkMode);
  }
  for (int i = 498; i<= 517; i++) {
    ellipse(i, 367, 28, 28);
  }
  //button
  fill(0, 0, 100);
  if (enableBgm) {
    ellipse(517, 367, 24, 24);
  } else {
    ellipse(498, 367, 24, 24);
  }
}

void screenshotButton() {
  //button
  if (needToHighlightScreenshot()) {
    fill(hsbColor[0], 60-10*darkMode, 70-20*darkMode);
  } else {
    fill(hsbColor[0], 80-10*darkMode, 80-20*darkMode);
  }
  rect(288, 402, 512, 443, 12);
  //text
  textAlign(CENTER, CENTER);
  if (needToHighlightScreenshot()) {
    fill(0, 0, 85-10*darkMode);
  } else {
    fill(0, 0, 100);
  }
  textSize(18.5);
  text("Capture Screenshot", 400, 420);
}

void pauseScreen() {
  //bg
  fill(0, 0, 40+10*darkMode, 70-10*darkMode);
  rect(0, 0, 800, 600);
  //window
  fill(0, 0, 95-90*darkMode, 78+2*darkMode);
  rect(225, 125, 575, 470, 30);
  //text and buttons
  fill(0, 0, 0+100*darkMode);
  if (!(!adjusting && paused && (mousePressed || keyPressed && key == ' ') && mouseX>280 && mouseX<520 && mouseY>155 && mouseY<215)) {
    //settings mode
    textAlign(CENTER, CENTER);
    textSize(38);
    text("Bubbles", 400, 168);
    textSize(15.5);
    text("Created with Love by McCoy Zhu", 400, 198);
    textAlign(LEFT, CENTER);
    textSize(22); 
    text("Dark Mode", 269, 285); 
    text("Sound Effects", 269, 325);
    text("Background Music", 269, 365);
    textAlign(CENTER, CENTER);
    textSize(12.5);
    fill(0, 0, 30+45*darkMode);
    text("Calm", 295, 251);
    text("Vigor", 505, 251); 
    darkModeSwitch();
    vigorSlider();
    sfxSwitch();
    bgmSwitch();
    screenshotButton();
    playSFX(sfxPlayed);
    sfxPlayed = false;
  } else {
    playSFX(!sfxPlayed);
    sfxPlayed = true;
    //stats mode
    if (int(int(int(int(millis())/1000)/60)/60) > 0) {
      //show the time played in hours and minutues if the time is longer than an hour
      timePlayed = int(int(int(int(millis())/1000)/60)/60)+"h "+int(int(int(int(millis())/1000)/60)%60)+"m";
    } else if (int(int(int(int(millis())/1000)/60)%60) > 0) {
      //show the time played in minutes and seconds if the time is longer than a minute but shorter than an hour
      timePlayed = int(int(int(int(millis())/1000)/60)%60)+"m "+ int(int(millis())/1000) % 60+"s";
    } else {
      //show the time played in seconds if the time is shorter than a minute
      timePlayed = int(int(millis())/1000) % 60+"s";
    }
    textAlign(CENTER, CENTER);
    textSize(28);
    text("You Have Played", 400, 255);
    textSize(27); 
    text(timePlayed, 400, 325); 
    textSize(22); 
    if (count == 1) {
      //special text for after the first game (GAME instead of GAMES)
      text(count + " Game", 400, 361);
    } else {
      text(count + " Games", 400, 361);
    }
  }
}
