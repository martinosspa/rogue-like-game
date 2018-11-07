void render_room() {
  mouse_presses();
  current_level.render();
  player.render();
  tick();
}

void mouse_presses() {
  if (mousePressed) {
    player.move(mouseGridX, mouseGridY);
  }
}


void tick() {
  //println(player.changeX, player.changeY);
  player.tick();
}
