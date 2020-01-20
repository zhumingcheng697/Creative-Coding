//Created by McCoy Zhu on September 11, 2019

float sizee = random(50, 90);
float hue = random(360);
float sat = random(60, 90);
float bri = random(60, 90);
float num = random(50,150);
float[] sizes = new float[200];
color[] colors = new color[200];
float[] xCor = new float[200];
float[] yCor = new float[200];
float[] alpha = new float[200];
boolean show = false;

void setup() {
  size(800, 600);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  background(0, 0, 100);
  hue = random(360);
  for (int i = 0; i < num; i += 1) {
    sizes[i] = random(40, 60);
    colors[i] = color(hue + random(-20, 20), random(20, 100), random(40, 90));
    xCor[i] = random(0, 800);
    yCor[i] = random(0, 600);
    alpha[i] = random(20, 60);
  }
}

void mouseMoved() {
  show = true;
}

void mouseReleased() {
  if (sizee >= 1200) {
    sizee = random(50, 90);
    hue = random(360);
    sat = random(60, 90);
    bri = random(60, 90);
    background(0, 0, 100);
    num = random(50,150);
    for (int i = 0; i < num; i += 1) {
      sizes[i] = random(40, 60);
      colors[i] = color(hue + random(-20, 20), random(20, 100), random(40, 90));
      xCor[i] = random(0, 800);
      yCor[i] = random(0, 600);
      alpha[i] = random(20, 60);
    }
  }
}

void draw() {
  background(0, 0, 100);
  for (int i = 0; i < num; i += 1) {
    fill(colors[i], alpha[i]);
    xCor[i] += random(-0.2, 0.2);
    yCor[i] += random(-0.2, 0.2);
    alpha[i] /= random(0.96, 1.04);
    ellipse(xCor[i], yCor[i], sizes[i], sizes[i]);
  }

  if (mousePressed) {
    show = true;
    for (int i = 0; i < num; i += 1) {
      if (pow(xCor[i] - mouseX, 2) + pow(yCor[i] - mouseY, 2) <= pow(sizee / 2 * 1.5, 2)) {
        xCor[i] = xCor[i] * 0.9 + mouseX * 0.1;
        yCor[i] = yCor[i] * 0.9 + mouseY * 0.1;
      }
      if (pow(xCor[i] - mouseX, 2) + pow(yCor[i] - mouseY, 2) <= pow(sizee / 2, 2)) {
        sizes[i] = 0;
      }
    }
    sizee *= random(1.02, 1.03);
    bri = (bri * 40 + 100) / 41;
  }
  fill(hue, sat, bri, 100);
  if (show) {
    ellipse(mouseX, mouseY, sizee, sizee);
  }
}
