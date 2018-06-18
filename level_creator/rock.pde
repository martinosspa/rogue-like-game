class Rock extends Tile {
  int x, y;
  final String classID = "rock";
  PImage image;
  PImage background_image;
  Rock(int xx, int yy) {
    super(xx, yy, "rock");
    x = xx;
    y = yy;
    image = images[1];
    background_image = images[0];
  }

  void render() {
    image(background_image, x*gridSizeX, y*gridSizeY, gridSizeX, gridSizeY);
    image(image, x*gridSizeX, y*gridSizeY, gridSizeX, gridSizeY);
  }
}
