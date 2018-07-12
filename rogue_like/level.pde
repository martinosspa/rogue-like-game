class Level { 
  float seed;
  float difficulty = 1;
  float id;
  int _width;
  int _height;
  int currentRoomX;
  int currentRoomY;
  Room[][] rooms;

  int starting_limit = 10;
  int room_limit;
  int room_count = 0;
  int startX;
  int startY;
  int endX;
  int endY;
  ArrayList<PVector> taken_positions = new ArrayList<PVector>();


  Level(float _seed) {
    seed = _seed;
    randomSeed((long) seed);
    _width = 30;
    _height = 30;
    rooms = new Room[_width][_height];
    currentRoomX = _width/2;
    currentRoomY = _height/2;
    startX = _width/2;
    startY = _height/2;

    PVector startingPos = new PVector(_width/2, _height/2);
    rooms[startX][startY] = new Room(loadJSONObject("room8.json"), this, startingPos.x, startingPos.y, ROOM_NORMAL);
    rooms[startX][startY].discovered = true;
    taken_positions.add(startingPos);

    boolean stuck = false;
    room_limit = constrain(floor(random(starting_limit*difficulty*random(1), random(1, 2) * starting_limit * difficulty)), starting_limit, floor(_width * _height * 0.6));
    while (room_count < room_limit) {
      PVector room_positions = taken_positions.get(taken_positions.size()-1);
      if (stuck) {
        room_positions = taken_positions.get(floor(random(taken_positions.size()-1)));
        stuck = false;
      }
      float chanceToGenerate = neighbors(room_positions) * random(1.0);
      float chanceToBranch = (difficulty * random(1.0) * chanceToGenerate)/neighbors(room_positions);
      if (chanceToGenerate < 2) {
        generateRoom(room_positions);
      }
      if (neighbors(room_positions) < 3 && chanceToBranch > 0.5) {
        generateRoom(room_positions);
      }
      if (neighbors(room_positions) == 4) {
        stuck = true;
      }
    }

    for (int i = 0; i < taken_positions.size(); i++) {
      PVector positions = taken_positions.get(i);
      boolean[] sides = new boolean[4];
      int intX = int(positions.x);
      int intY = int(positions.y);
      PVector right_vector = new PVector(positions.x+1, positions.y);
      PVector left_vector = new PVector(positions.x-1, positions.y);
      PVector down_vector = new PVector(positions.x, positions.y-1);
      PVector up_vector = new PVector(positions.x, positions.y+1);
      sides[0] = false;
      sides[1] = false;
      sides[2] = false;
      sides[3] = false;
      if (taken_positions.contains(right_vector)) {
        sides[0] = true;
      }
      if (taken_positions.contains(left_vector)) {
        sides[2] = true;
      }
      if (taken_positions.contains(up_vector)) {
        sides[1] = true;
      }
      if (taken_positions.contains(down_vector)) {
        sides[3] = true;
      }
      rooms[intX][intY] = new Room(room_sender.request(sides), this, positions.x, positions.y, rooms[intX][intY].type);
      if (intX == int(taken_positions.get(0).x) && intY == int(taken_positions.get(0).y)) {
        if (debug_mode) {
          rooms[intX][intY] = new Room(loadJSONObject("debug_room.json"), this, positions.x, positions.y, ROOM_DEBUG);
          rooms[intX][intY].spawnEnemy(5, 5);
          for (int j = 1; j < 10; j++) {
            rooms[intX][intY].addHealthOrb(p.maxHealth/j, floor(random(1, rooms[intX][intY]._width - 1)), floor(random(1, rooms[intX][intY]._height - 1)));
          }
        }
        rooms[intX][intY].enter();
      }
    }
  }

  void render() {
    rooms[currentRoomX][currentRoomY].render();
    discoverRoom(rooms[currentRoomX+1][currentRoomY]);
    discoverRoom(rooms[currentRoomX-1][currentRoomY]);
    discoverRoom(rooms[currentRoomX][currentRoomY+1]);
    discoverRoom(rooms[currentRoomX][currentRoomY-1]);
  }

  int neighbors(PVector checkPos) {
    int count = 0;
    PVector right_vector = new PVector(checkPos.x+1, checkPos.y);
    PVector left_vector = new PVector(checkPos.x-1, checkPos.y);
    PVector down_vector = new PVector(checkPos.x, checkPos.y-1);
    PVector up_vector = new PVector(checkPos.x, checkPos.y+1);

    if (taken_positions.contains(right_vector)) {
      count++;
    }
    if (taken_positions.contains(left_vector)) {
      count++;
    }
    if (taken_positions.contains(up_vector)) {
      count++;
    }
    if (taken_positions.contains(down_vector)) {
      count++;
    }
    return count;
  }

  private void generateRoom(PVector coords) {
    PVector right_vector = new PVector(coords.x+1, coords.y);
    PVector left_vector = new PVector(coords.x-1, coords.y);
    PVector down_vector = new PVector(coords.x, coords.y-1);
    PVector up_vector = new PVector(coords.x, coords.y+1);

    boolean generated = false;
    int iterations = 0;
    while (!generated && iterations < 500) {
      iterations ++;
      boolean sides[] = new boolean[4];
      int side = floor(random(4));
      int newX = 0;
      int newY = 0;
      sides[0] = false;
      sides[1] = false;
      sides[2] = false;
      sides[3] = false;
      switch (side) {
      case 0:
        if (!taken_positions.contains(right_vector)) {
          newX = int(right_vector.x);
          newY = int(right_vector.y);
          sides[0] = true;
        }
        break;
      case 1:
        if (!taken_positions.contains(left_vector)) {
          newX = int(left_vector.x);
          newY = int(left_vector.y);
          sides[2] = true;
        }
        break;
      case 2:
        if (!taken_positions.contains(up_vector)) {
          newX = int(up_vector.x);
          newY = int(up_vector.y);
          sides[3] = true;
        }
        break;
      case 3:
        if (!taken_positions.contains(down_vector)) {
          newX = int(down_vector.x);
          newY = int(down_vector.y);
          sides[1] = true;
        }
        break;
      }
      if (newX != 0 && newY != 0 && newX != _width-1 && newY != _height-1) {
        PVector roomCoords = new PVector(newX, newY);
        taken_positions.add(roomCoords);
        float chanceToHaveLoot = random(0, neighbors(roomCoords));
        if (chanceToHaveLoot < 0.25) {
          rooms[newX][newY] = new Room(room_sender.request(sides), this, newX, newY, ROOM_LOOT);
        } else {
          rooms[newX][newY] = new Room(room_sender.request(sides), this, newX, newY, ROOM_NORMAL);
        }
        room_count++;
        generated = true;
      }
    }
  }


  void discoverRoom(Room room) {
    if (!(room == null) && !room.discovered) {
      room.discover();
    }
  }
}
