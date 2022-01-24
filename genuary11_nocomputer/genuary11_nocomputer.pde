int fibonacci[];

float x, y;
int direction = 3;
int counter;

void setup() {
  size(800, 600);
  background(40);
  
  x = random(width * 0.25, width * 0.75);
  y = random(height * 0.25, height * 0.75);
    
  fibonacci = new int[2];
  
  fibonacci[0] = 1;
  fibonacci[1] = 1;
  
  noStroke();
  colorMode(HSB, 100);
  
  frameRate(5);
}

void draw() {
  counter = counter >= 100 ? 0 : counter + 10;
  
  int curr = fibonacci[frameCount % 2];
  int next = fibonacci[(frameCount + 1) % 2];
    
  fill(counter, counter, 100);
  rect(x, y, curr, curr);
  
  int next_fibo = curr + next;
  
  if (direction == 0)
    y += curr;
  else if (direction == 1) {
    x += curr;
    y = y + curr - next;
  } else if (direction == 2) {
    x = x + curr - next;
    y -= next;
  } else
    x -= next;
  
  fibonacci[frameCount % 2] = next_fibo;
  direction = direction == 3 ? 0 : direction + 1;
}
