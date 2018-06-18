class Rock extends Tile {
  int x, y;
  PImage image;
  PImage background_image;
  Rock(int xx, int yy) {
    super(xx, yy);
    x = xx;
    y = yy;
    image = tile_images[1];
    background_image = tile_images[0];
  }

  void render() {
    if (!(currentLevel.rooms[currentLevel.currentRoomX][currentLevel.currentRoomY].grid[x][y].occupied)) {
      currentLevel.rooms[currentLevel.currentRoomX][currentLevel.currentRoomY].grid[x][y].occupied = true;
    }
    image(background_image, x*gridSizeX, y*gridSizeY, gridSizeX, gridSizeY);
    image(image, x*gridSizeX, y*gridSizeY, gridSizeX, gridSizeY);
  }
}
