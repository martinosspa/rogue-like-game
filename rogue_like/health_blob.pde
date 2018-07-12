class hp_blob {
  float health;
  private float randomDrawX;
  private float randomDrawY;
  int x;
  int y;
  private float bobY = 0;
  private float bob_speed = 0.3;

  hp_blob(float hp, int xx, int yy) {
    health = ceil(hp);
    println(health);
    x = xx;
    y = yy;
    bobY = random(gridSizeY/10);

    randomDrawX = random(gridSizeX);
    randomDrawY = random(gridSizeY);
  }

  void render() {
    pushMatrix();
    translate(0, bobY);
    fill(0, 255, 0);
    ellipseMode(CENTER);
    float sizeX = map(health, 0, p.maxHealth, gridSizeX*0.1, gridSizeY*0.5);
    float sizeY = map(health, 0, p.maxHealth, gridSizeX*0.1, gridSizeY*0.5);
    ellipse(gridSizeX * x + randomDrawX, gridSizeY * y + randomDrawY, sizeX, sizeY);
    if (abs(bobY) > gridSizeY/10) {
      bob_speed  *= -1;
    }
    bobY += bob_speed;
    popMatrix();
  }
  boolean intersectsPlayer() {
    return p.x == x && p.y == y;
  }
}
