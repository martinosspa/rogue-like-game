class Toolbar {
  int _width = width;
  int _height = 200;
  Button btnExport = new Button(gridSizeX*10, 0, 80, 40-1, color(140), "Export Level");
  BooleanButton btn_right = new BooleanButton(gridSizeX*2, gridSizeY*2, 80, 40, color(150), "right");
  BooleanButton btn_down = new BooleanButton(gridSizeX, gridSizeY*3, 80, 40, color(150), "down");
  BooleanButton btn_left = new BooleanButton(0, gridSizeY*2, 80, 40, color(150), "left");
  BooleanButton btn_up = new BooleanButton(gridSizeX, gridSizeY, 80, 40, color(150), "up");


  void render() {
    fill(100);
    rect(0, 0, _width, _height);

    for (Tile tile : dummyTiles) {
      if (tile.clicked() && selectedTileID != tile.base_id) {
        selectedTileID = tile.base_id;
      }

      btn_right.render();
      btn_down.render();
      btn_left.render();
      btn_up.render();
      btnExport.render();
      tile.render();
    }
  }
}
