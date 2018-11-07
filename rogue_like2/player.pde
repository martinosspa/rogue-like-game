class Player extends Entity {
  int changeX, changeY = 0;
  Player() {
    x = 0;
    y = 0;
  }




  void render() {
    fill(255, 0, 0);
    rect(x * gridSizeX, y*gridSizeY, gridSizeX-1, gridSizeY-1);
    //collision.update();
  }


  void move(int newX, int newY) {
    changeX = newX - x;
    changeY = newY - y;
  }
  void tick() {
    
    x += changeX;
    y += changeY;
    changeX = 0;
    changeY = 0;
  }
}
