class Room {
  int _width;
  int _height;
  int type;
  int startingX;
  int startingY;
  boolean connectionUp;
  boolean connectionRight;
  boolean connectionDown;
  boolean connectionLeft;
  Level parent_level;
  boolean discovered = false;
  boolean hasEntered = false;
  int x;
  int y;

  boolean spawnEnemies = false;
  int enemyCount = 0;
  int enemyCurrentCount = 0;

  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  ArrayList<hp_blob> hp_blobs = new ArrayList<hp_blob>();
  ArrayList<Item> items;
  Tile[][] grid;
  Room(Level tempParentLevel, float tempX, float tempY) {
    // empty debug room constructor
  }


  Room(JSONObject json, Level tempParentLevel, float tempX, float tempY, int tempType) {
    // normal room constructor
    type = tempType;
    x = int(tempX);
    y = int(tempY);

    _width = json.getJSONObject("dimensions").getInt("width");
    _height = json.getJSONObject("dimensions").getInt("height");
    grid = new Tile[_width][_height];
    startingX = _width/2;
    startingY = _height/2 - 1;
    connectionUp = json.getJSONObject("connections").getBoolean("up");
    connectionRight = json.getJSONObject("connections").getBoolean("right");
    connectionDown = json.getJSONObject("connections").getBoolean("down");
    connectionLeft = json.getJSONObject("connections").getBoolean("left");
    /*
    spawnEnemies = json.getJSONObject("enemies").getBoolean("spawn");
     if (spawnEnemies) {
     enemyCount = json.getJSONObject("enemies").getInt("enemy_count");
     }
     
     */

    parent_level = tempParentLevel;


    items = new ArrayList<Item>();
    for (int i = 0; i < _width; i++) {
      for (int j = 0; j < _height; j++) {
        grid[i][j] = getTile(i, j, json.getJSONObject("grid").getJSONObject(str(i)).getJSONObject(str(j)).getString("name"), json.getJSONObject("grid").getJSONObject(str(i)).getJSONObject(str(j)).getString("transfer_id"));
      }
    }

    if (type == ROOM_LOOT) {
      items.add(new Item(_width/2, _height/2, parent_level.difficulty));
    }
  }


  void render() {

    for (int i = 0; i < _width; i++) {
      for (int j = 0; j < _height; j++) {
        if (grid[i][j] != null) {
          grid[i][j].render();
        }
      }
    }
    for (int i = items.size() - 1; i >= 0; i--) {
      Item item = items.get(i);
      item.render();
      if (item.intersectsPlayer()) {
        p.pickupItem(item);
        items.remove(item);
      }
    }



    for (int i = hp_blobs.size() - 1; i >= 0; i--) {
      hp_blob blob = hp_blobs.get(i);
      blob.render();
      if (blob.intersectsPlayer() && blob.health + p.health <= p.maxHealth) {
        p.pickupHealthOrb(blob);
        println("picked up hp orb that restored " + blob.health + " health amount");
        hp_blobs.remove(blob);
      }
    }

    for (Enemy enemy : enemies) {
      enemy.render();
    }
  }


  void update() {
    parent_level = currentLevel;
    for (int i = 0; i < _width; i++) {
      for (int j = 0; j < _height; j++) {
        grid[i][j].update();
      }
    }
    for (Enemy enemy : enemies) {
      enemy.update();
    }
  }

  void enter() {
    discover();
    hasEntered = true;
  }

  void discover() {
    discovered = true;
  }

  void spawnEnemy(int enemyX, int enemyY) {
    enemies.add(new Enemy(enemyX, enemyY, 100 * parent_level.difficulty, ENEMY_TYPE_MELEE, this));
  }

  void addHealthOrb(float health_amount, int orbX, int orbY) {
    hp_blobs.add(new hp_blob(health_amount, orbX, orbY));
  }
}
