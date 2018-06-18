class GUI {
  Map minimap;
  Transition transition;
  Gui_window damage_stats;
  color _color = color(90, 255, 255);
  int x = 0;
  int y = (height/4)*3;
  int _width = width/4-1;
  int _height = height/4-1;


  GUI() {
    minimap = new Map();
    transition = new Transition();
    damage_stats = new Gui_window(x, y, _width, _height, "", color(150, 150, 150, 150));
  }


  void render() {
    minimap.render();
    // REMOVE AFTER DEBUG damage_stats.render();
    // REMOVE AFTER DEBUG drawPlayerHealth();
  }

  void drawPlayerHealth() {
    fill(255, 0, 0);
    stroke(_color);
    rect(x + _width/4, y + _height/6, map(p.health, 0, p.maxHealth, 0, _width/2), _height/6);
    noFill();
    rect(x + _width/4, y + _height/6, _width/2, _height/6);
  }
}
