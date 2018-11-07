class Level {
  int width_, height_;
  int current_room_x, current_room_y;
  float difficulty; //max is 1

  Room[][] rooms = new Room[30][30];
  Room current_room;


  Level(float dif) {
    difficulty = dif;
    rooms[0][0] = new Room(this, 0, 0);
    current_room = rooms[0][0];
  }

  void render() {
    current_room.render();
  }
  
  
}
