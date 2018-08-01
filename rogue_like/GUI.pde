class GUI {
  Map minimap;
  Transition transition;
  Gui_window damage_stats;
  color border_color = color(100, 100, 100);
  color background_color = color(150, 150, 150);
  int x = 0;
  int y = (height/4)*3;
  int _width = width/4-1;
  int _height = height/4-1;


  GUI() {
    minimap = new Map();
    transition = new Transition();
  }


  void render() {
    //minimap.render();
  }
}
