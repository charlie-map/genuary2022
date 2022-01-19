class Centroid {
  int centRed, centGreen, centBlue;
  color star;
  float x, y;
  
  float size;
  
  float centWeight;
  
  Centroid(int r, int g, int b) {
    centRed = r;
    centGreen = g;
    centBlue = b;
    
    x = random(width);
    y = random(height);
    
    size = random(10, 20);
    
    star = color(151, 144, 148);
  }
  
  void display() {
    fill(star);
    circle(x, y, size);
  }
}

int centroid = 3;
Centroid cent[];

void setup() {
  size(800, 600);
  background(40);
  
  noStroke();
  frameRate(30);
  
  cent = new Centroid[centroid];
  
  cent[0] = new Centroid(66, 57, 196);
  cent[1] = new Centroid(85, 209, 65);
  cent[2] = new Centroid(196, 81, 158);
}

float spinOffset;

float offsetX = 0;
float offsetY = 0;

void draw() {
  rotate(radians(spinOffset));
  
  loadPixels();
  for (int drawX = 0; drawX < width; drawX++) {
    for (int drawY = 0; drawY < height; drawY++) {
      float perlinValue = noise((drawX * 0.01) + offsetX, (drawY * 0.01) + offsetY) - 0.1;

      // create weighting towards closest centroid
      float totalWeight = 0;
      for (int checkCentWeight = 0; checkCentWeight < centroid; checkCentWeight++) {
        cent[checkCentWeight].centWeight = dist(cent[checkCentWeight].x, cent[checkCentWeight].y, drawX, drawY);
        
        totalWeight += cent[checkCentWeight].centWeight;
      }

      cent[0].centWeight /= totalWeight;
      cent[1].centWeight /= totalWeight;
      cent[2].centWeight /= totalWeight;
      
      // create weighted average for red green and blue
      float newRed = 0, newGreen = 0, newBlue = 0;
      for (int buildColors = 0; buildColors < centroid; buildColors++) {
        newRed += cent[buildColors].centWeight * cent[buildColors].centRed * perlinValue;
        newGreen += cent[buildColors].centWeight * cent[buildColors].centGreen * perlinValue;
        newBlue += cent[buildColors].centWeight * cent[buildColors].centBlue * perlinValue;
      }
      
      // set this pixel color to the closest centroid
      pixels[(drawY * width) + drawX] = color(newRed, newGreen, newBlue);
    }
  }
  updatePixels();
  
  offsetX += random(0.002, 0.004);
  offsetY += random(0.002, 0.004);
    
  spinOffset += 0.5;
  
  for (int displayCent = 0; displayCent < centroid; displayCent++) {
    cent[displayCent].display();
  }
}
