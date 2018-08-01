/*
 >make better movement and animation
 >items
 >enemies
 >actual rooms
 >slime spits and loses hp based on attack
 */
final int ROOM_EMPTY = -2;
final int ROOM_DEBUG = -1;
final int ROOM_NORMAL = 0;
final int ROOM_LOOT = 1;
final int ROOM_BOSS = 2;

final int ENEMY_TYPE_MELEE = 0;
final int ENEMY_TYPE_RANGED = 1;

final int DAMAGE_TOXIN = 0;
final int DAMAGE_FIRE = 1;
final int DAMAGE_FROST = 2;
final int DAMAGE_PURE = 3;

final int roomRatioX = 20;
final int roomRatioY = 15;

int gridSizeX = 0;
int gridSizeY = 0;
int mouseGridX = 0;
int mouseGridY = 0;

PImage[] weapon_images = new PImage[10];
PImage[] tile_images = new PImage[4];
PImage[] entity_images = new PImage[4];

int frames = 60;
int currentLevelID = 0;
ArrayList<Level> levels;

boolean debug_mode = true;
float debug_seed = 1;
int state = 2;

/*
 state = 0; menu
 state = 1; reset/loading game
 state = 2; playing
*/


RoomSender room_sender;
Level currentLevel;
Player p;
GUI gui;
void setup() {
  size(800, 600, P3D);
  //pre loading stuff
  room_sender = new RoomSender();
  frameRate(frames);
  weapon_images[0] = loadImage("toxin weapon.png");
  weapon_images[1] = loadImage("toxin weapon.png");
  weapon_images[2] = loadImage("toxin weapon.png");
  //tile_images[0] = loadImage("ground1.png");
  tile_images[0] = loadImage("background.png");
  tile_images[1] = loadImage("rock.png");
  tile_images[2] = loadImage("door.png");
  tile_images[3] = loadImage("wall.png");
  entity_images[0] = loadImage("slime.png");
  entity_images[1] = loadImage("enemy.png");
  gridSizeX = width/roomRatioX;
  gridSizeY = height/roomRatioY;
  p = new Player(100);
  levels = new ArrayList<Level>();
  
  //generate level and player
  if (debug_mode) {
    levels.add(new Level(debug_seed));
  } else {
    int r = int(random(10.0) * 1e10);
    println("seed: " + r);
    levels.add(new Level(r));
  }
  gui = new GUI();
  currentLevel = levels.get(currentLevelID);
  p.enterRoom(currentLevel.currentRoomX,currentLevel.currentRoomY);
  
}

void draw() {
  gridSizeX = width/roomRatioX;
  gridSizeY = height/roomRatioY;
  mouseGridX = (mouseX - (mouseX%gridSizeX)) / gridSizeX;
  mouseGridY = (mouseY - (mouseY%gridSizeY)) / gridSizeY;
  //println(currentLevel.currentRoomX, currentLevel.currentRoomY);
  if (mousePressed) {
    if (!gui.transition.drawing) {
      p.move(mouseGridX, mouseGridY);
    }
  }

  drawAll();
  fill(255, 0, 0);
  textSize(12);
  textAlign(RIGHT);
  text(int(frameRate) + "FPS", width, 12);
  textAlign(LEFT);
}
