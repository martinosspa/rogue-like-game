class Tile {
  int x = 0;
  int y = 0;
  float d = 0;
  String base_id = "";
  String id;
  Tile(int xx, int yy, String tempID) {
    x = xx;
    y = yy;
    base_id = tempID;
    d = gridSizeX;
  }

  void render() {
    fill(0, 255, 0);
    stroke(1);
    ellipse(x * gridSizeX, y * gridSizeY, d, d);
  }

  boolean clicked() {
    return mouseGridX == x 
      && mouseGridY == y
      && mousePressed;
  }
}
