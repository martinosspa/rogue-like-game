void drawAll() {
  background(0);
  switch(state) {
  case 0: //menu
    fill(225, 0, 0);
    textSize(gridSizeX);
    textAlign(CENTER);
    text("GAME OVER", width/2, height/2);
    textSize(width/gridSizeX);
    break;
  case 1: //reset / loading
      
    break;
  case 2: //playing
    if (!p.dead) {
      if (!gui.transition.drawing) {
        currentLevel.render();
        p.render();
        gui.render();
      } else {
        gui.transition.render();
        gui.transition.update();
      }
    } else {
      state = 0;
    }
    break;
  }
}

void drawHPBar(int x, int y, float currentHP, float maxHP) {
  fill(255, 0, 0);
  stroke(1);
  rect(x * gridSizeX - gridSizeX/4, y * gridSizeY - gridSizeY/2, map(currentHP, 0, maxHP, 0, gridSizeX*1.5), gridSizeY/4);
  noFill();
  rect(x * gridSizeX - gridSizeX/4, y * gridSizeY - gridSizeY/2, gridSizeX*1.5, gridSizeY/4);
}

Tile getTile(int x, int y, String tile, String id) {
  switch(tile) {
  case "empty_tile":
    return new EmptyTile(x, y);
  case "rock":
    return new Rock(x, y);
  case "door":
    return new Door(x, y, id);
  case "wall_tile":
    return new WallTile(x, y);
  default:
    return null;
  }
}
