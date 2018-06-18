class WallTile extends Tile {
  PImage image;
  WallTile(int tempX, int tempY) {
    super(tempX, tempY, "void_tile");
    image = images[3];
  }


  void render() {
    image(image, x*gridSizeX, y*gridSizeY, gridSizeX, gridSizeY);
  }
}
