class WallTile extends Tile {

  PImage image;
  PImage image_background;

  WallTile(int tempX, int tempY) {
    super(tempX, tempY);
    occupied = true;
    image = tile_images[3];
    image_background = tile_images[1];
  }


  void render() {
    image(image_background, x*gridSizeX, y*gridSizeY, gridSizeX, gridSizeY);
    image(image, x*gridSizeX, y*gridSizeY, gridSizeX, gridSizeY);
  }
}
