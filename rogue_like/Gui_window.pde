class Gui_window {
  String text;
  float x;
  float y;
  float _width;
  float _height;
  color _color;

  Gui_window(float tempX, float tempY, float tempWidth, float tempHeight, String tempText, color tempColor) {
    x = tempX;
    y = tempY;
    _width = tempWidth;
    _height = tempHeight;
    text = tempText;
    _color = tempColor;
  }


  void render() {
    stroke(gui._color);
    fill(_color);
    rect(x, y, _width, _height);
    fill(0);
    //textSize(_height/10);
    textAlign(LEFT, TOP);
    text(text, x, y);
  }
  void updateText(String tempText) {
    text = tempText;
  }
}
