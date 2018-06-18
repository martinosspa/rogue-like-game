class Enemy extends Entity {
  int type = ENEMY_TYPE_MELEE;
  
  Enemy(int xx, int yy, float _health, int temp_type) {
    super(xx, yy);
    x = 5;
    y = 5;
    type = temp_type;
    
    
  }


  void render() {
  }
}
