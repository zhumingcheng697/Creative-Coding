class Bubble {
  float diameter, x, y, alpha;
  color hsbColor;
  Bubble(float dia, color col, float xCor, float yCor, float alp) {
    diameter = dia;
    hsbColor = col;
    x = xCor;
    y = yCor;
    alpha = alp;
  }
  void twinkleAndWiggle() {
    if (x > 900) {
      x += random(-0.3-0.7*vigorousMode, 0);
    } else if (x < -100) {
      x += random(0, 0.3+0.7*vigorousMode);
    } else {
      x += random(-0.3-0.7*vigorousMode, 0.3+0.7*vigorousMode);
    }
    if (y > 700) {
      y += random(-0.3-0.7*vigorousMode, 0);
    } else if (x < -100) {
      y += random(0, 0.3+0.7*vigorousMode);
    } else {
      y += random(-0.3-0.7*vigorousMode, 0.3+0.7*vigorousMode);
    }
    if (diameter > 55) {
      diameter *= random(0.988-0.02*vigorousMode, 1);
    } else if (diameter < 40) {
      diameter *= random(1, 1 / (0.988-0.02*vigorousMode));
    } else {
      diameter *= random((0.988-0.02*vigorousMode), 1 / (0.988-0.02*vigorousMode));
    }
    if (alpha > 60) {
      alpha *= random(0.95-0.15*vigorousMode*(0.6*darkMode+0.4), 1);
    } else if (alpha < 20) {
      alpha *= random(1, 1 / (0.95-0.15*vigorousMode*(0.6*darkMode+0.4)));
    } else {
      alpha *= random((0.95-0.15*vigorousMode*(0.6*darkMode+0.4)), 1 / (0.95-0.15*vigorousMode*(0.6*darkMode+0.4)));
    }
  }
  void interactWithSphere(float sphereX, float sphereY, float sphereD) {
    float distance = dist(x, y, sphereX, sphereY);
    if (distance/1.2 < sphereD) {
      x = x * (distance / (1.2*sphereD)) + sphereX * (1 - (distance / (1.2*sphereD)));
      y = y * (distance / (1.2*sphereD)) + sphereY * (1 - (distance / (1.2*sphereD)));
    }
    if ((distance + diameter / 2) < sphereD / 2) {
      diameter = 0;
    }
  }
  void display() {
    fill(hsbColor, alpha+20*darkMode);
    ellipse(x, y, diameter, diameter);
  }
}
