/*
 >make better movement and animation
 >items
 >enemies
 >actual rooms
 >slime spits and loses hp based on attack 
 */

final int ROOM_DEBUG = -1;
final int ROOM_NORMAL = 0;
final int ROOM_LOOT = 1;

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

int frames = 60;
int currentLevelID = 0;
ArrayList<Level> levels;

boolean debug_mode = true;

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
  size(800, 600, P2D);
  room_sender = new RoomSender();
  frameRate(frames);
  weapon_images[0] = loadImage("toxin weapon.png");
  weapon_images[1] = loadImage("toxin weapon.png");
  weapon_images[2] = loadImage("toxin weapon.png");
  tile_images[0] = loadImage("ground1.png");
  tile_images[1] = loadImage("rock.png");
  tile_images[2] = loadImage("door.png");
  tile_images[3] = loadImage("wall.png");

  gridSizeX = width/roomRatioX;
  gridSizeY = height/roomRatioY;

  levels = new ArrayList<Level>();
  levels.add(new Level());

  currentLevel = levels.get(currentLevelID);

  p = new Player(100);
  p.x = currentLevel.rooms[currentLevel.currentRoomX][currentLevel.currentRoomY].startingX;
  p.y = currentLevel.rooms[currentLevel.currentRoomX][currentLevel.currentRoomY].startingY;
  gui = new GUI();
}

void draw() {
  gridSizeX = width/roomRatioX;
  gridSizeY = height/roomRatioY;
  mouseGridX = (mouseX - (mouseX%gridSizeX)) / gridSizeX;
  mouseGridY = (mouseY - (mouseY%gridSizeY)) / gridSizeY;

  if (mousePressed) {
    if (!gui.transition.drawing) {
      p.move(mouseGridX, mouseGridY);
    }
  }

  drawAll();

  //p.health = constrain(p.health - 1, 0, p.maxHealth);
  fill(255, 0, 0);
  text(int(frameRate) + "FPS", width-gridSizeX, 12);
}
