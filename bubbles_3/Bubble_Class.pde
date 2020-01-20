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
    x += random(-0.3, 0.3);
    y += random(-0.3, 0.3);
    if (alpha > 60) {
      alpha *= random(0.95, 1);
    } else if (alpha < 20) {
      alpha *= random(1, 1 / 0.95);
    } else {
      alpha *= random(0.95, 1 / 0.95);
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
    fill(hsbColor, alpha);
    ellipse(x, y, diameter, diameter);
  }
}
