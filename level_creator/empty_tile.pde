class EmptyTile extends Tile {
  float x;
  float y;
  PImage image;

  EmptyTile(int xx, int yy) {
    super(xx, yy, "empty_tile");
    x = xx;
    y = yy;
    image = images[0];
  }

  void render() {
    image(image, x*gridSizeX, y*gridSizeY, gridSizeX, gridSizeY);
  }
}
