PImage image;

void setup() {
  image = loadImage("free1.jpg");

  size(600, 315);

  image.loadPixels();
  for (int scanX = 0; scanX < width; scanX++) {
    for (int scanY = 0; scanY < height; scanY++) {
      int currPos = (scanY * width) + scanX;
      color col = image.pixels[currPos];
      
      float currBrightness = brightness(col) / 255;
            
      if (currBrightness > random(1))
        image.pixels[currPos] = color(255);
      else
        image.pixels[currPos] = color(0);
    }
  }
  
  image.updatePixels();

  image(image, 0, 0);
}
