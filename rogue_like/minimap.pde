class Map {
  int _width = gridSizeX*6;
  int _height = gridSizeY*4;
  float alpha = 100;
  void render() {
    stroke(1);
    fill(255, 255, 255, alpha);
    rect(0, 0, _width, _height);

    for (int i = 0; i < currentLevel._width; i++) {
      for (int j = 0; j < currentLevel._height; j++) {
        float a = map(i, 0, currentLevel._width, 0, _width);
        float b = map(j, 0, currentLevel._height, 0, _height);
        Room room = currentLevel.rooms[i][j];
        if (room == null || !room.discovered) {
          fill(255, 255, 255, alpha);
        } else if (currentLevel.rooms[currentLevel.currentRoomX][currentLevel.currentRoomY].equals(room)) {
          fill(0, 255, 0, alpha);
        } else if (currentLevel.rooms[i][j].type == ROOM_BOSS) {
          fill(255, 0, 0, alpha);
        } else if (currentLevel.rooms[i][j].discovered && !currentLevel.rooms[i][j].hasEntered) {
          fill(150, 150, 150, alpha);
        } else {
          fill(0, 0, 255, alpha);
        }
        rect(a, b, _width/currentLevel._width, _height/currentLevel._height);
      }
    }
  }
}
