class Collision {
  boolean above = false;
  boolean left = false;
  boolean below = false;
  boolean right = false;
  void update(Room entityCurrentRoom, int x, int y) {
    above = (y-1 >= 0) && entityCurrentRoom.grid[x][y-1].occupied;
    left = (x-1 >= 0) && entityCurrentRoom.grid[x-1][y].occupied;
    below = (y+1 <= entityCurrentRoom._height-1) && entityCurrentRoom.grid[x][y+1].occupied;
    right = (x+1 <= entityCurrentRoom._width-1) && entityCurrentRoom.grid[x+1][y].occupied;
  }
}
