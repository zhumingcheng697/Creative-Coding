void setup() {
  size(600, 600);
  strokeWeight(2);
  stroke(0);
}

void draw() {
  background(255);
  stroke(0);
  for (int x = 100; x <= 500; x += 40) {
    line(x, 100, x, 500);
  }
  for (int y = 100; y <= 500; y += 40) {
    line(100, y, 500, y);
  }
  noStroke();

  for (int i = 0; i < 10; i += 1) {
    for (int j = 0; j < 10; j += 1) {
      if (i % 2 ==0 && j % 2 != 0 || i % 2 !=0 && j % 2 == 0) {
        fill(0);
        rect(100+i*40, 100+j*40, 40, 40);
      }
    }
  }

  for (int x = 100; x < 500; x += 40) {
    for (int y = 100; y < 500; y += 40) {
      if (mouseX > x && mouseX < (x+40) && mouseY > y && mouseY < (y+40)) {
        fill(#57068C);
        rect(x, y, 40, 40);
      }
    }
  }
}
