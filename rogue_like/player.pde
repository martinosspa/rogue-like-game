class Player extends Entity {
  int x = 1;
  int y = 1;
  int changeX = 0;
  int changeY = 0;
  boolean up, right, down, left;
  float health, maxHealth;
  boolean dead = false;
  Room currentRoom;
  int transferCooldownMax;
  int transferCooldown;
  Collision collision;
  PImage image;
  float base_damage = 100;
  float[] damage_distribution = {100, 0, 0, 0};

  Player(float _health) {
    super(0, 0, ENEMY_TYPE_MELEE);
    image = loadImage("player.png");
    maxHealth = _health;
    health = maxHealth;
    collision = new Collision();
    transferCooldownMax = frames;
    transferCooldown = 0;

    update();
  }

  void move(int mGridX, int mGridY) {
    update();
    changeX = 0;
    changeY = 0;
    if (mGridX - x > 0) {
      changeX = int(!collision.right);
    } else if (mGridX - x < 0) {
      changeX = -int(!collision.left);
    }

    if (mGridY - y > 0) {
      changeY = int(!collision.below);
    } else if (mGridY - y < 0) {
      changeY = -int(!collision.above);
    }
    
    x += changeX;
    y += changeY;
    update();
  }

  void update() {
    currentRoom = currentLevel.rooms[currentLevel.currentRoomX][currentLevel.currentRoomY];
    collision.update(currentRoom, x, y);
  }


  void render() {
    if (transferCooldown > 0) {
      transferCooldown--;
    }
    tint(255, 255, 255);
    image(image, x*gridSizeX, y*gridSizeY, gridSizeX, gridSizeY);
    noTint();
  }

  void transfer(int newRoomX, int newRoomY) {
    currentLevel.rooms[currentLevel.currentRoomX][currentLevel.currentRoomY].discovered = true;
    currentLevel.currentRoomX = newRoomX;
    currentLevel.currentRoomY = newRoomY;
    transferCooldown = transferCooldownMax;
    currentLevel.rooms[newRoomX][newRoomY].enter();
    x = currentLevel.rooms[newRoomX][newRoomY].startingX;
    y = currentLevel.rooms[newRoomX][newRoomY].startingY;
    gui.transition.startRender();
    update();
  }



  void pickup(Item item) {
    switch(item.damage_type) {
    case DAMAGE_TOXIN:
      damage_distribution[1] += item.damage_amount;
      break;
    case DAMAGE_FIRE:
      damage_distribution[2] += item.damage_amount;
      break;
    case DAMAGE_FROST:
      damage_distribution[3] += item.damage_amount;
      break;
    }
    for (int i = 0; i < damage_distribution.length; i++) {
      println(damage_distribution[i]);
    }
  }
}
