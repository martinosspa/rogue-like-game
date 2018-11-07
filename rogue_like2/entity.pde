class Entity {
  boolean has_collision = true;
  int x, y;
  Room current_room;
  Collision collision = new Collision(this);
}
