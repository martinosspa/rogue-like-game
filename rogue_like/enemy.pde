class Enemy extends Entity {
  float health;
  float maxHealth;
  boolean canAttack = true;
  int maxAttackCooldown;
  int attackCooldown;
  float attackDamage;
  Room parentRoom;
  Collision collision;

  boolean inRange = false;
  int type = ENEMY_TYPE_MELEE;
  int visionRange = 0;

  Enemy(int xx, int yy, float _health, int temp_type, Room tempParentRoom) {
    super(xx, yy, _health);
    maxHealth = _health;
    health = maxHealth;
    maxAttackCooldown = frames;
    attackCooldown = 0;
    collision = new Collision();
    x = 10;
    y = 5;
    attackDamage = 5;
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
      attackPlayer();
      fill(0, 255, 0);
    } else {
      wonderAround();
      fill(255, 0, 0);
    }
    handleAttackCooldown();
    ellipseMode(CORNER);
    noStroke();
    ellipse(x * gridSizeX, y * gridSizeY, gridSizeX, gridSizeY);
    drawHPBar(x, y, health, maxHealth);
  }
  private void handleAttackCooldown() {
    if (attackCooldown > 0) {
      attackCooldown -= 1;
    }
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

  private void attackPlayer() {
    if (attackCooldown == 0) {
      p.takeDamage(attackDamage);
      println(p.health);
      attackCooldown = maxAttackCooldown;
    }
  }
  void move(int newX, int newY) {
    int changeX = 0;
    int changeY = 0;
    parentRoom.grid[x][y].leave();
    if (newX > x) {
      changeX = int(!collision.right);
    } else if (newX < x) {
      changeX = -int(!collision.left);
    }

    if (newY > y) {
      changeY = int(!collision.below);
    } else if (newY < y) {
      changeY = -int(!collision.above);
    }
    
    x += changeX;
    y += changeY;
    parentRoom.grid[x][y].occupy();
    update();
  }
}
