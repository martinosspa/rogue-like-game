class Door extends Tile {
  PImage image;
  Door(int tempX, int tempY, String _id) {
    super(tempX, tempY, "door");
    id = _id;
    image = images[2];
  }

  void render() {
    image(image, x*gridSizeX, y*gridSizeY, gridSizeX, gridSizeY);
  }
}
