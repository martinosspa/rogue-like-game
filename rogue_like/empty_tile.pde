class EmptyTile extends Tile {
  float x;
  float y;
  PImage image;


  EmptyTile(int xx, int yy) {
    super(xx, yy);
    x = xx;
    y = yy;
    image = tile_images[0];
    occupied = false;
  }
  void render() {
    image(image, x*gridSizeX, y*gridSizeY, gridSizeX, gridSizeY);
  }
}
