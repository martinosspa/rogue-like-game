class VoidTile extends Tile {

  VoidTile(int tempX, int tempY) {
    super(tempX, tempY);
    occupied = true;
  }
  void render() {
    fill(255);
    rect(x * gridSizeX, y * gridSizeY, gridSizeX - 1, gridSizeY - 1);
  }
}
