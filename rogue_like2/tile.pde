class Tile {
  int x, y;
  Room parent_room;
  boolean occupied = false;

  Tile(Room parent_room, int x, int y) {
    this.parent_room = parent_room;
    this.x = x;
    this.y = y;
  }

  void render() {
    fill(0, 255, 0);
    rect(x * gridSizeX, y * gridSizeY, gridSizeX-1, gridSizeY-1);
  }
}
