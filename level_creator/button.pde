class Button {
  int x;
  int y;
  int _width;
  int _height;
  color base_color;
  boolean mouseOver = false;
  String text;
  int id;
  int cooldown = 0;


  Button(int tempX, int tempY, int tempWidth, int tempHeight, color tempColor, String tempText) {
    x = tempX;
    y = tempY;
    _width = tempWidth;
    _height = tempHeight;
    base_color = tempColor;
    text = tempText;
    id = btnCount;
    btnCount += 1;
  }

  void render() {
    mouseOver = mouseX > x && mouseY > y && x+_width > mouseX && y+_height > mouseY && mousePressed;
    fill(base_color);
    rect(x, y, _width, _height);
    fill(0);
    if (cooldown > 0) {
      cooldown--;
    }
    if (text != null) {
      text(text, x+2, y+_height/2);
    }
    if (mouseOver && id==0 && cooldown == 0) {
      exportRoom(currentRoom);
      cooldown = frames * 2;
      println("exported room" + roomCount);
      roomCount ++;
    }
  }
}
