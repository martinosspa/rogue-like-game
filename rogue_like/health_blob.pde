class hp_blob {
  float health;
  float randomDrawX;
  float randomDrawY;
  int x;
  int y;

  hp_blob(float hp, int xx, int yy) {
    health = hp;
    x = xx;
    y = yy;

    randomDrawX = random(gridSizeX);
    randomDrawY = random(gridSizeY);
  }
  void render() {
    fill(0, 255, 0);
    ellipseMode(CENTER);
    float sizeX = map(health, 0, p.maxHealth, gridSizeX*0.1, gridSizeY*0.5);
    float sizeY = map(health, 0, p.maxHealth, gridSizeX*0.1, gridSizeY*0.5);
    ellipse(gridSizeX * x + randomDrawX, gridSizeY * y + randomDrawY, sizeX, sizeY);
  }
}
