void checkMouseMovement() {
  if (((pmouseX != mouseX || pmouseY != mouseY) || (show && (x != mouseX || y != mouseY))) && !paused) {
    x = mouseX;
    y = mouseY;
    show = true;
  }
}

boolean needToReset() {
  return (! paused && dist(x, y, 0, 0) < diameter / 2.05 && dist(x, y, 800, 0) < diameter / 2.05 && dist(x, y, 800, 600) < diameter / 2.05 && dist(x, y, 0, 600) < diameter / 2.05 ) || (keyPressed && key == 'r' && buffer > bufferLimit && enableReset);
}

boolean needToPlay() {
  return (mousePressed || keyPressed && key == ' ') && !paused && show && buffer > bufferLimit;
}

boolean needToHighlightReset() {
  return dist(mouseX, mouseY, 50, 550)<=30 || keyPressed && key == 'r';
}

boolean needToHighlightPause() {
  return (!(mouseX>225 && mouseX<575 && mouseY>125 && mouseY<445) && (dist(mouseX, mouseY, 50, 550)>30 || !enableReset) && paused && (keyPressed && key == ' ' || mousePressed)) || dist(mouseX, mouseY, 750, 550)<=30 || keyPressed && key == 'p';
}

boolean needToHighlightScreenshot() {
  return keyPressed && key == 's' || (mousePressed || keyPressed && key == ' ' ) && mouseX>288 && mouseX<512 && mouseY>367 && mouseY<408;
}

void reset() {
  buffer = 0;
  num = random(120, 150);
  diameter = random(70, 90);
  hsbColor[0] = random(360);
  hsbColor[1] = random(60, 90);
  hsbColor[2] = random(50, 80);
  for (int i = 0; i < num; i += 1) {
    bubbles[i] = new Bubble(random(40, 55), color(hsbColor[0] + random(-20, 20), random(20, 100), random(30, 80)), random(0, 800), random(0, 800), random(20, 60));
  }
}
