class Collision {
  boolean above = false;
  boolean left = false;
  boolean below = false;
  boolean right = false;

  Entity parent_entity;

  Collision(Entity parent_entity) {
    this.parent_entity = parent_entity;
  }

  void update() {
    int x = parent_entity.x;
    int y = parent_entity.y;
    above = (y-1 >= 0) && parent_entity.current_room.tiles[x][y-1].occupied;
    below = (y+1 <= parent_entity.current_room.height_-1)&& parent_entity.current_room.tiles[x][y+1].occupied;
    left = (x-1 >= 0) && parent_entity.current_room.tiles[x-1][y].occupied;
    right = (x+1 <= parent_entity.current_room.width_-1) && parent_entity.current_room.tiles[x-1][y].occupied;
  }
}
