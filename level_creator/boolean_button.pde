class BooleanButton extends Button {
  boolean condition = false;
  int cooldown = 0;
  int maxCooldown = frames*2;
  String controlSide;

  BooleanButton(int tempX, int tempY, int tempWidth, int tempHeight, color tempColor, String tempControlSide) {
    super(tempX, tempY, tempWidth, tempHeight, tempColor, null);
    controlSide = tempControlSide;
  }


  void render() {
    mouseOver = mouseX > x && mouseY > y && x+_width > mouseX && y+_height > mouseY && mousePressed;

    if (mouseOver && cooldown == 0) {
      condition = !condition;
      cooldown = maxCooldown;
      if (condition) {
        switch (controlSide) {
        case "right":
          currentRoom.grid[currentRoom._width-1][currentRoom._height/2] = getTile(currentRoom._width-1, currentRoom._height/2, "door", controlSide);
          break;
        case "down":
          currentRoom.grid[currentRoom._width/2][currentRoom._height-1] = getTile(currentRoom._width/2, currentRoom._height-1, "door", controlSide);
          break;
        case "left":
          currentRoom.grid[0][currentRoom._height/2] = getTile(0, currentRoom._height/2, "door", controlSide);
          break;
        case "up":
          currentRoom.grid[currentRoom._width/2][0] = getTile(currentRoom._width/2, 0, "door", controlSide);
          break;
        }
      } else {
        switch (controlSide) {
        case "right":
          currentRoom.grid[currentRoom._width-1][currentRoom._height/2] = getTile(currentRoom._width-1, currentRoom._height/2, "void_tile", null);
          break;
        case "down":
          currentRoom.grid[currentRoom._width/2][currentRoom._height-1] = getTile(currentRoom._width/2, currentRoom._height-1, "void_tile", null );
          break;
        case "left":
          currentRoom.grid[0][currentRoom._height/2] = getTile(0, currentRoom._height/2, "void_tile", null);
          break;
        case "up":
          currentRoom.grid[currentRoom._width/2][0] = getTile(currentRoom._width/2, 0, "void_tile", null);
          break;
        }
      }
    }

    if (cooldown > 0) {
      cooldown--;
    }


    if (condition) {
      fill(255, 0, 0);
    } else {
      fill(base_color);
    }
    rect(x, y, gridSizeX, gridSizeY);
  }
}
