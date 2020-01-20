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
    //displacing randomly
    x = constrain(x+random(-0.3-1.7*vigor, 0.3+1.7*vigor), -100, 900);
    y = constrain(y+random(-0.3-1.7*vigor, 0.3+1.7*vigor), -100, 700);
    //scaling randomly
    if (diameter != 0){
      //only scale if the bubble hasn’t gotten into the sphere
      diameter = constrain(diameter*random(0.988-0.02*vigor, 1 / (0.988-0.02*vigor)), 40, 55);
    }
    //changing opacity randomly
    alpha = constrain(alpha*random((0.95-0.15*vigor*(0.6*darkMode+0.4)), 1 / (0.95-0.15*vigor*(0.6*darkMode+0.4))), 20, 60);
  }
  void interactWithSphere(float sphereX, float sphereY, float sphereD) {
    float distance = dist(x, y, sphereX, sphereY);
    //move bubbles to the sphere
    if (distance/1.2 < sphereD) {
      x = x * (distance / (1.2*sphereD)) + sphereX * (1 - (distance / (1.2*sphereD)));
      y = y * (distance / (1.2*sphereD)) + sphereY * (1 - (distance / (1.2*sphereD)));
    }
    //let the bubbles disappear after getting into the sphere
    if ((distance + diameter / 2) < sphereD / 2) {
      diameter = 0;
    }
  }
  void display() {
    fill(hsbColor, alpha+20*darkMode);
    ellipse(x, y, diameter, diameter);
  }
}
