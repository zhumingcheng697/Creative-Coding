//Created by McCoy Zhu on September 19, 2019

float x = 400;
float y = 300;
float diameter = random(70, 90);
float hsbColor[] = new float[3];
float num;
float[] sizes = new float[121];
color[] colors = new color[121];
float[] xCor = new float[121];
float[] yCor = new float[121];
float[] alpha = new float[121];
boolean useMouse = false;

void setup() {
  size(800, 600);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  hsbColor[0] = random(360);
  hsbColor[1] = random(60, 90);
  hsbColor[2] = random(50, 80);
  num = random(80, 120);
  for (int i = 0; i < num; i += 1) {
    sizes[i] = random(40, 55);
    colors[i] = color(hsbColor[0] + random(-20, 20), random(20, 100), random(30, 80));
    xCor[i] = random(0, 800);
    yCor[i] = random(0, 600);
    alpha[i] = random(20, 60);
  }
}

void draw() {
  background(0, 0, 100);

  if (pmouseX != mouseX || pmouseY != mouseY) {
    x = mouseX;
    y = mouseY;
    useMouse = true;
  }

  if (mousePressed || keyPressed && key == ' ') {
    useMouse = true;
    for (int i = 0; i < num; i += 1) {
      if (dist(x, y, xCor[i], yCor[i]) < diameter) {
        float n = dist(x, y, xCor[i], yCor[i]) / (diameter);
        xCor[i] = xCor[i] * n + x * (1 - n);
        yCor[i] = yCor[i] * n + y * (1 - n);
      }
      if (dist(x, y, xCor[i], yCor[i]) + sizes[i] / 2 < diameter / 2) {
        sizes[i] = 0;
      }
    }
    if (diameter < 2000) {
      diameter *= 2 - pow(0.8, diameter / 2000);
    }
    hsbColor[2] = (hsbColor[2] * 50 + 100) / 51;
  } else if (dist(x, y, 0, 0) < diameter / 1.9 && dist(x, y, 800, 0) < diameter / 1.9 && dist(x, y, 800, 600) < diameter / 1.9 && dist(x, y, 0, 600) < diameter / 1.9 || keyPressed && key == 'r') {
    diameter = random(70, 90);
    hsbColor[0] = random(360);
    hsbColor[1] = random(60, 90);
    hsbColor[2] = random(50, 80);
    background(0, 0, 100);
    num = random(80, 120);
    for (int i = 0; i < num; i += 1) {
      sizes[i] = random(40, 55);
      colors[i] = color(hsbColor[0] + random(-20, 20), random(20, 100), random(30, 80));
      xCor[i] = random(0, 800);
      yCor[i] = random(0, 600);
      alpha[i] = random(20, 60);
    }
  }
  for (int i = 0; i < num; i += 1) {
    fill(colors[i], alpha[i]);
    xCor[i] += random(-0.5, 0.5);
    yCor[i] += random(-0.5, 0.5);
    if (alpha[i] > 60) {
      alpha[i] /= random(1, 1 / 0.95);
    } else if (alpha[i] < 20) {
      alpha[i] /= random(0.95, 1);
    } else {
      alpha[i] /= random(0.95, 1 / 0.95);
    }
    ellipse(xCor[i], yCor[i], sizes[i], sizes[i]);
  }

  if (useMouse) {
    fill(hsbColor[0], hsbColor[1], hsbColor[2], 100);
    ellipse(x, y, diameter, diameter);
  }
}
