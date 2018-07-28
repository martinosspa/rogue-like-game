class Player extends Entity {
  int x = 1;
  int y = 1;
  int changeX = 0;
  int changeY = 0;
  boolean up, right, down, left;
  Room currentRoom;
  int transferCooldownMax;
  int transferCooldown;
  Collision collision;
  PImage image;
  float base_damage = 100;
  float[] damage_distribution = {100, 0, 0, 0};
  Player(float _health) {
    super(0, 0, _health);
    image = entity_images[0];
    maxHealth = _health;
    health = maxHealth;
    collision = new Collision();
    transferCooldownMax = frames;
    transferCooldown = 0;
  }

  void move(int mGridX, int mGridY) {
    update();
    changeX = 0;
    changeY = 0;

    if (mGridX > x) {
      changeX = int(!collision.right);
    } else if (mGridX < x) {
      changeX = -int(!collision.left);
    }
    if (mGridY > y) {
      changeY = int(!collision.below);
    } else if (mGridY < y) {
      changeY = -int(!collision.above);
    }
    currentRoom.grid[x][y].leave();
    if (!currentRoom.grid[x + changeX][y + changeY].occupied) {
      x += changeX;
      y += changeY;
    }
    currentRoom.grid[x][y].occupy();
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

    //tint(255, 255, 255);
    image(image, x*gridSizeX, y*gridSizeY, gridSizeX, gridSizeY);
    //noTint();
  }



  void pickupItem(Item item) {
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

  void pickupHealthOrb(hp_blob blob) {
    health = constrain(health + blob.health, 0, maxHealth);
  }
  void enterRoom(int roomX, int roomY) {
    Room room = currentLevel.rooms[roomX][roomY];
    x = room.startingX;
    y = room.startingY;
    currentLevel.currentRoomX = room.x;
    currentLevel.currentRoomY = room.y;
    room.discover();
    currentLevel.rooms[room.x][room.y].enter();

    transferCooldown = transferCooldownMax;
    gui.transition.startRender();
    update();
  }
}
