class Room {
  int x, y;
  int width_, height_;
  Tile[][] tiles = new Tile[room_ratio_x][room_ratio_y];
  Level parent_level;


  Room(Level parent_level, int x, int y) {
    this.x = x;
    this.y = y;
    this.parent_level = parent_level;
    width_ = room_ratio_x;
    height_ = room_ratio_y;

    //initate tiles

    for (int i = 0; i < width_; i++) {
      for (int j = 0; j < height_; j++) {
        tiles[i][j] = new Tile(this, i, j);
      }
    }
  }


  void render() {
    for (int i = 0; i < width_; i++) {
      for (int j = 0; j < height_; j++) {
        tiles[i][j].render();
      }
    }
  }
}
