int makeShape(float x, float y, color randColor) {
  point(x, y);

  int sideNumber = floor(random(3, 10));
  int size = floor(random(20, 40));

  float rotateAmount = 360 / sideNumber;
  float randomStartRotate = random(-PI, 0);

  stroke(randColor);

  pushMatrix();

  translate(x, y);
  rotate(randomStartRotate);

  for (int createSides = 0; createSides < sideNumber; createSides++) {
    line(0, 0, size, 0);

    translate(size, 0);
    rotate(radians(rotateAmount));
  }

  popMatrix();

  return 0;
}

int counter = 0;

void setup() {
  size(800, 600);
  background(30);

  strokeWeight(3);
  
  frameRate(20);
}

void draw() {
  if (counter < 100000) {
    makeShape(random(0, 800), random(0, 600), color(random(80, 200), random(50, 170), random(100, 235))); 

    counter++;
  }
}
