class Point {
  float x, y;
  float x_vel, y_vel;
  
  color c;
  
  Point(float start_x, float start_y, float start_x_vel, float start_y_vel, color start_color) {
    x = start_x;
    y = start_y;
    
    x_vel = start_x_vel;
    y_vel = start_y_vel;
    
    c = start_color;
  }
  
  void update() {
    x += x_vel;
    y += y_vel;
    
    x_vel *= x >= width || x <= 0 ? -1 : 1;
    y_vel *= y >= height || y <= 0 ? -1 : 1;
  }
  
  void display() {
    stroke(c);
    
    point(x, y);
  }
}

final int MAX_DIST = 90;
Point point[];

void setup() {
  size(800, 600);
  background(40);
  
  point = new Point[250];
  
  for (int set_point = 0; set_point < point.length; set_point++) {
    point[set_point] = new Point(random(width), random(height), random(-2, 2), random(-2, 2),
    color(random(100, 255), random(100, 255), random(100, 255)));
  }
}

void draw() {
  clear();
  
  for (int draw_point = 0; draw_point < point.length; draw_point++) {
    point[draw_point].update();
    point[draw_point].display();
  }
  
  // for each point look at all other points near it
  for (int check_point_len = 0; check_point_len < point.length; check_point_len++) {
    float check_x = point[check_point_len].x, check_y = point[check_point_len].y;
    
    for (int find_match = 0; find_match < point.length; find_match++) {
      float match_x = point[find_match].x, match_y = point[find_match].y;
      
      float alpha_dist = dist(check_x, check_y, match_x, match_y); 
      if (alpha_dist <= MAX_DIST) {
        alpha_dist = (alpha_dist / 50) * 255; 
        
        color curr_point_col = point[check_point_len].c;
        color alpha_calc = color(red(curr_point_col), green(curr_point_col), blue(curr_point_col), alpha_dist);
        // draw a line
        stroke(alpha_calc);
        line(check_x, check_y, match_x, match_y);
      }
    }
  }
}
