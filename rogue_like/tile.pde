class Tile {
  int x = 0;
  int y = 0;
  boolean occupied = false;
  Tile(int xx, int yy) {
    x = xx;
    y = yy;
    println("created ", x , y);
  }

  void render() {
    fill(0, 255, 0);
    stroke(1);
    ellipse(x * gridSizeX, y * gridSizeY, gridSizeX, gridSizeY);
  }


  void update() {
  }

  void occupy() {
    occupied = true;
  }

  void leave() {
    occupied = false;
  }
}
