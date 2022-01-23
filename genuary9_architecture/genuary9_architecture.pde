void setup() {
  size(800, 600);
  background(40);
    
  rectMode(CENTER);
  noStroke();
}

void draw() {
  make_tower(random(width), 600, random(50, 120), random(2, 12),
             frameCount % 10 == 0 ? color(40) : color(random(180, 255), random(180, 255), random(180, 255)));
}

void make_tower(float x, float y, float tower_width, float tower_height, color c) {
  if (tower_width < 2)
    return;
  
  fill(c);
  rect(x, y, tower_width, tower_height);
  
  make_tower(x, y - tower_height * 0.9, tower_width * 0.94, tower_height, c);
}
