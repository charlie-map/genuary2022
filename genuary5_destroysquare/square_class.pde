class Square {
  float size;
  float x, y;
  
  float x_direction, y_direction;
    
  color col;
  int timebomb;
  
  int curr_child_len;
  Square new_square[];
  
  int is_alive;
  int is_showing;
  
  Square(float start_x, float x_dir, float start_y, float y_dir, color start_col, float start_size, int start_time) {
    size = start_size;
    timebomb = start_time;
    
    x = start_x;
    x_direction = x_dir;
    
    y = start_y;
    y_direction = y_dir;
    
    col = start_col;
        
    curr_child_len = 0;
    new_square = new Square[4];
    
    is_showing = 1;
    is_alive = 1;
  }
  
  // move the square forward and lower timebome
  int update() { 
    x += x_direction;
    y += y_direction;
    
    timebomb = timebomb < 0 ? 120 : timebomb - 1;
    
    if (timebomb <= 0 && is_showing != 0) { // explode!
      is_showing = 0; //<>//

      if (size * 0.5 < 5)
        return 0; // done

      curr_child_len = 4;
      for (int set_children_squares = 0; set_children_squares < curr_child_len; set_children_squares++) {
        new_square[set_children_squares] = new Square(x + size * 0.1 * square_direction[set_children_squares][0],
                                                      square_direction[set_children_squares][0] * random(0.2, 0.8),
                                                      y + size * 0.1 * square_direction[set_children_squares][1],
                                                      square_direction[set_children_squares][1] * random(0.2, 0.8),
                                                      col, size * 0.5, TIME_BOMB);
      }
      
      return 1;
    }
    
    int check_alive_children = timebomb > 0 ? 4 : 0;
    
    for (int set_children_squares = 0; set_children_squares < curr_child_len; set_children_squares++) {
      
      check_alive_children += new_square[set_children_squares].update();
    }
    
    if (check_alive_children == 0)
      is_alive = 0;
    
    return is_alive;
  }
  
  void display() {
     //<>//
    if (is_showing == 0) {
      for (int draw_children = 0; draw_children < curr_child_len; draw_children++)
        new_square[draw_children].display();
      
      return;
    }
    
    pushMatrix();
    translate(x, y);
    
    fill(col);
    square(0, 0, size); 
    popMatrix();
  }
}
