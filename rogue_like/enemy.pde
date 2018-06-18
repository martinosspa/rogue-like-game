class Enemy extends Entity {
  float health;
  float maxHealth;
  boolean canAttack = true;
  float attackDamage;
  Room parentRoom;
  Collision collision = new Collision();

  boolean inRange = false;
  int type = ENEMY_TYPE_MELEE;
  int visionRange = 0;

  Enemy(int xx, int yy, float _health, int temp_type, Room tempParentRoom) {
    super(xx, yy, temp_type);
    maxHealth = _health;
    health = maxHealth;
    x = 10;
    y = 5;
    parentRoom = tempParentRoom;
    type = temp_type;
    switch (type) {
    case ENEMY_TYPE_MELEE:
      visionRange = 2;
      break;
    case ENEMY_TYPE_RANGED:
      visionRange = 5;
    }
    update();
  }

  void update() {
    collision.update(parentRoom, x, y);
  }

  void render() {
    inRange = dist(p.x, p.y, x, y) < visionRange;
    if (!parentRoom.grid[x][y].occupied) {
      parentRoom.grid[x][y].occupied = true;
    }
    if (inRange) {
      attack();
      fill(0, 255, 0);
    } else {
      wonderAround();
      fill(255, 0, 0);
    }
    ellipseMode(CORNER);
    noStroke();
    ellipse(x * gridSizeX, y * gridSizeY, gridSizeX, gridSizeY);
    drawHPBar(x, y, health, maxHealth);
  }



  private void wonderAround() {
    float chanceToMove = random(0, 1);
    float chanceDirection = random(0, 1);
    float chancePosNeg = random(0, 1);
    int direction = 0;

    if (chanceToMove > 0.99 ) {
      if (chancePosNeg > 0.49) {
        direction = 1;
      } else {
        direction = -1;
      }
      if (chanceDirection > 0.49) {
        // MOVE X
        move(x + direction, y);
      } else {
        // MOVE Y
        move(x, y + direction);
      }
    }
  }

  private void attack() {
  }

  void move(int newX, int newY) {
    int changeX = 0;
    int changeY = 0;
    if (newX - x > 0) {
      changeX = int(!collision.right);
    } else if (newX - x < 0) {
      changeX = -int(!collision.left);
    }

    if (newY - y > 0) {
      changeY = int(!collision.below);
    } else if (newY - y < 0) {
      changeY = -int(!collision.above);
    }
    parentRoom.grid[x][y].occupied = false;
    x += changeX;
    y += changeY;

    update();
  }
}
