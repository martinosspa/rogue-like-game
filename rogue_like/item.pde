class Item {
  int tier;
  PImage image;
  int damage_type;
  int damage_amount;
  int x;
  int y;
  float bobY = 0;
  float bob_speed = 0.3;

  Item(int tempX, int tempY, float difficulty) {
    damage_amount = int(100*map(random(10), 0, 10, difficulty * 0.3, difficulty * 0.7));
    float r = random(0, 3);
    x = tempX;
    y = tempY;
    damage_type = DAMAGE_TOXIN;
    image = weapon_images[0];
    /*
    if (r < 1) {
     //toxic damage
     damage_type = DAMAGE_TOXIN;
     image = weapon_images[0];
     } else if (r < 2) {
     //fire damage
     image = weapon_images[0];
     } else {
     //frost damage
     damage_type = DAMAGE_FROST;
     image = weapon_images[0];
     }
     
     */
  }


  void render() {
    pushMatrix();
    translate(0, -bobY);
    textAlign(CENTER, CENTER);
    switch (damage_type) {
    case DAMAGE_TOXIN:
      fill(0, 255, 0);
      text(str(damage_amount), (x+0.5)*gridSizeX, (y-0.25)*gridSizeY);
      break;
    case DAMAGE_FIRE:
      break;
    case DAMAGE_FROST:
      break;
    }

    image(image, x*gridSizeX, y*gridSizeY, gridSizeX, gridSizeY);
    popMatrix();
    if (abs(bobY) > gridSizeY/8) {
      bob_speed  *= -1;
    }
    bobY += bob_speed;
  }

  boolean intersectsPlayer() {
    return p.x == x && p.y == y;
  }
}
