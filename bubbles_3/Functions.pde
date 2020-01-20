void resetButton() {
  if (needToHighlightReset()) {
    fill(0, 0, 93, 90);
  } else {
    fill(0, 0, 80, 50);
  }
  ellipse(50, 550, 60, 60);
  noFill();
  if (needToHighlightReset()) {
    stroke(0, 0, 15);
  } else {
    stroke(0, 0, 35);
  }
  strokeWeight(4);
  arc(50, 550, 30, 30, radians(-35), radians(270));
  triangle(56, 535, 50, 539, 50, 531);
  noStroke();
}

void checkMouseMovement() {
  if ((pmouseX != mouseX || pmouseY != mouseY) || (show && (x != mouseX || y != mouseY))) {
    x = mouseX;
    y = mouseY;
    show = true;
  }
}

boolean needToReset() {
  return dist(x, y, 0, 0) < diameter / 2.05 && dist(x, y, 800, 0) < diameter / 2.05 && dist(x, y, 800, 600) < diameter / 2.05 && dist(x, y, 0, 600) < diameter / 2.05 || (keyPressed && key == 'r' && buffer > bufferLimit);
}

boolean needToPlay() {
  return (mousePressed || keyPressed && key == ' ') && show && buffer > bufferLimit;
}

boolean needToHighlightReset() {
  return dist(mouseX, mouseY, 50, 550)<=30 || keyPressed && key == 'r';
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
