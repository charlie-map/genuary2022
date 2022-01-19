final float START_SIZE = 160;
final int TIME_BOMB = 120;

int square_direction[][];

Square square_group[];

void setup() {
  size(600, 400);
  background(40);
  
  rectMode(CENTER);
  
  square_direction = new int[4][2];
  
  square_direction[0][0] = -1;
  square_direction[0][1] = -1;
  
  square_direction[1][0] = 1;
  square_direction[1][1] = -1;
  
  square_direction[2][0] = -1;
  square_direction[2][1] = 1;
  
  square_direction[3][0] = 1;
  square_direction[3][1] = 1;
  
  square_group = new Square[4];
  
  for (int set_squares = 0; set_squares < 4; set_squares++) {
    square_group[set_squares] = new Square(300, 0, 200, 0, color(random(180, 200), random(150, 180), random(200, 255)), START_SIZE, TIME_BOMB);
  }
}

int square_counter = 1;

void draw() {
  clear();
  
  for (int draw_squares = 0; draw_squares < square_counter; draw_squares++) {
    if (square_group[draw_squares].update() == 0) {
      println("make new square");
      square_group[draw_squares] = new Square(300, 0, 200, 0, color(random(100, 200), random(80, 120), random(50, 150)), START_SIZE, TIME_BOMB);
    }
    
    square_group[draw_squares].display();
  }
  
  //square_counter += square_counter == 4 ? 1 : frameCount % 120 == 0 ? 1 : 0;
}
