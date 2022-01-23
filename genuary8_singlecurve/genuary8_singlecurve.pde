float check_path(float curr_x, float curr_y, float x_vel, float y_vel) {
  float initial_x = curr_x, initial_y = curr_y;
  
  loadPixels();
  // check forward in the direction a certain amount
  int check_forward;
  for (check_forward = 0; check_forward < 100; check_forward++) {
    curr_x += x_vel;
    curr_y += y_vel;
    
    curr_x = curr_x > width ? 0 : curr_x < 0 ? width : curr_x;
    curr_y = curr_y > height ? 0 : curr_y < 0 ? height : curr_y;
    
    if (brightness(get(floor(curr_x), floor(curr_y))) >= 95) {
      break;
    }
  }
  
  // calculate distance between initial_x, curr_x and initial_y, curr_y
  return dist(initial_x, initial_y, curr_x, curr_y);
}

float check_surroundings(float x, float y, float angle) {
  // depending on the current direction, look forward and calculate
  // a change of direction
  float start_angle_check = angle - (PI * 0.5);
  float end_angle_check = angle + (PI * 0.5);
  
  // look for furthest distance from line to travel towards
  float max_distance = check_path(x, y, cos(angle), sin(angle)), best_angle = angle;
  if (max_distance >= 90) // angle is already good
    return angle;
    
  for (float check_frontier = start_angle_check; check_frontier < end_angle_check; check_frontier += PI / 64) {
    float path_distance = check_path(x, y, cos(check_frontier), sin(check_frontier));
    
    if (path_distance > max_distance) {
      max_distance = path_distance;
      best_angle = check_frontier;
    }
  }
  
  return best_angle;
}

class Curve {
  float prev_x, prev_y;
  float x, y;
  float angle;
  
  color col;
  
  Curve(float start_x, float start_y, float start_angle) {
    x = start_x;
    y = start_y;
    
    angle = start_angle;
    
    col = color(x, 255, width);
  }
  
  void move() {
    x = x > width ? 0 : x < 0 ? width : x;
    y = y > height ? 0 : y < 0 ? height : y; 
    
    prev_x = x;
    prev_y = y;
    
    y += sin(angle);
    x += cos(angle);
    
    // update color
    col = color(x, 255, width);
    
    // randomize angle by a slight amount
    angle += random(-PI / 16, PI / 16);
    // change angle based on surrounding data
    float best_angle = check_surroundings(x, y, angle);
    
    // create weight between the current angle and best angle
    float curr_angle_dist = check_path(x, y, cos(angle), sin(angle));
    float new_angle_dist = check_path(x, y, cos(best_angle), sin(best_angle));
    
    // get weighted average
    float total_dist = curr_angle_dist + new_angle_dist + 40;
    
    angle = (angle * ((curr_angle_dist + 40) / total_dist)) + (best_angle * (new_angle_dist / total_dist));
  }
  
  void display() {
    stroke(col);
    
    line(prev_x, prev_y, x, y);
  }
}

Curve curve;

void setup() {
  size(800, 600);
  background(30);
  
  strokeWeight(3);
  colorMode(HSB, width);
  
  curve = new Curve(random(width), random(height), random(2 * PI));
}

void draw() {
  curve.move();
  curve.display();
}
