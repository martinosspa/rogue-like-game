void exportRoom(Room room) {
  JSONObject jsonRoom = new JSONObject();
  JSONObject jsonConnections = new JSONObject();
  JSONObject jsonGrid = new JSONObject();
  JSONObject jsonStartingPositions = new JSONObject();
  JSONObject jsonDimensions = new JSONObject();
  JSONObject jsonEnemies = new JSONObject();

  jsonDimensions.setInt("width", room._width);
  jsonDimensions.setInt("height", room._height);

  jsonConnections.setBoolean("right", toolbar.btn_right.condition);
  jsonConnections.setBoolean("down", toolbar.btn_down.condition);
  jsonConnections.setBoolean("left", toolbar.btn_left.condition);
  jsonConnections.setBoolean("up", toolbar.btn_up.condition);

  jsonStartingPositions.setInt("x", room.startingX);
  jsonStartingPositions.setInt("y", room.startingY);
  
  

  for (int i = 0; i < room._width; i++) {
    JSONObject jsonLine = new JSONObject();
    for (int j = 0; j < room._height; j++) {
      JSONObject jsonTile = new JSONObject();
      jsonTile.setString("name", room.grid[i][j].base_id);
      if (room.grid[i][j].base_id == "transfer_tile") {
        jsonTile.setString("transfer_id", room.grid[i][j].id);
      }
      jsonLine.setJSONObject(str(j), jsonTile);
    }
    jsonGrid.setJSONObject(str(i), jsonLine);
  }

  jsonRoom.setJSONObject("dimensions", jsonDimensions);
  jsonRoom.setJSONObject("starting_positions", jsonStartingPositions);
  jsonRoom.setJSONObject("grid", jsonGrid);
  jsonRoom.setJSONObject("connections", jsonConnections);
  saveJSONObject(jsonRoom, "room" + roomCount +".json");
}


Tile getTile(int x, int y, String id, String transfer_id) {
  switch(id) {
  case "empty_tile":
    return new EmptyTile(x, y);
  case "rock":
    return new Rock(x, y);
  case "void_tile":
    return new WallTile(x, y);
  case "door":
    return new Door(x, y, transfer_id);
  }

  return null;
}
