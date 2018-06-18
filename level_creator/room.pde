class Room {
  int _width;
  int _height;
  int type;
  Tile[][] grid;
  int id = 0;

  int startingX = 1;
  int startingY = 1;
  Room(int w, int h, int _type) {
    //enemies.add(new Enemy(5*gridSize, 5*gridSize, 100));
    _width = w * ratioX;
    _height = h * ratioY;
    type = _type;
    id = global_id;
    global_id += 1;
    grid = new Tile[_width][_height];

    for (int i = 0; i < _width; i++) {
      for (int j = 0; j < _height; j++) {
        if (i == 0 || i == _width - 1 || j == 0 || j == _height - 1 ) {
          grid[i][j] = new WallTile(i,j);
        } else {

          grid[i][j] = new EmptyTile(i, j);
        }
      }
    }
  }



  void render() {
    for (int i = 0; i < _width; i++) {
      for (int j = 0; j < _height; j++) {
        grid[i][j].render();
      }
    }
  }
}
