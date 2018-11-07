class Door extends Tile {
  String id;
  PImage image;
  PImage background_image;
  Door(int tempX, int tempY, String _id) {
    super(tempX, tempY);
    occupied = true;
    id = _id;
    background_image = tile_images[0];
    image = tile_images[2];
  }

  void render() {
    image(background_image, x*gridSizeX, y*gridSizeY, gridSizeX, gridSizeY);
    image(image, x*gridSizeX, y*gridSizeY, gridSizeX, gridSizeY);

    if (p.x == x && p.y == y && p.transferCooldown == 0) {
      switch (id) {
      case "right": //transfer right
        p.enterRoom(currentLevel.currentRoomX+1,currentLevel.currentRoomY);
        break;
      case "down": //transfer down
        p.enterRoom(currentLevel.currentRoomX,currentLevel.currentRoomY+1);
        break;
      case "left": //transfer left
        p.enterRoom(currentLevel.currentRoomX-1,currentLevel.currentRoomY);
        break;
      case "up": //tranfer up
        p.enterRoom(currentLevel.currentRoomX,currentLevel.currentRoomY-1);
        break;
      }
    }
  }
}
