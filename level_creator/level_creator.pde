int gridSizeX = 0;
int gridSizeY = 0;
int frames = 60;
int global_id = 0;
int mouseGridX = 0;
int mouseGridY = 0;
int btnCount = 0;
int roomCount = 0;
int currentRoomID = 0;
String selectedTileID = "empty_tile";

final int ratioX = 20;
final int ratioY = 15;

final int ENEMY_TYPE_MELEE = 0;
final int ENEMY_TYPE_RANGED = 1;

ArrayList<Room> rooms = new ArrayList<Room>();
ArrayList<Tile> dummyTiles = new ArrayList<Tile>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
PImage images[] = new PImage[4];

Toolbar toolbar;
Room currentRoom;

void setup() {
  size(800, 800, P2D);

  frameRate(frames);
  gridSizeX = width/ratioX;
  gridSizeY = (height-200)/ratioY;
  images[0] = loadImage("ground1.png");
  images[1] = loadImage("rock.png");
  images[2] = loadImage("door.png");
  images[3] = loadImage("wall.png");
  rooms.add(new Room(1, 1, 0));
  toolbar = new Toolbar();
  dummyTiles.add(new EmptyTile(6, 2));
  dummyTiles.add(new Rock(8, 2));
  dummyTiles.add(new WallTile(10, 2));
}


void draw() {
  background(0);
  gridSizeX = width/ratioX;
  gridSizeY = (height-toolbar._height)/ratioY;
  mouseGridX = (mouseX - (mouseX%gridSizeX)) / gridSizeX;
  mouseGridY = (mouseY - (mouseY%gridSizeY)) / gridSizeY;

  currentRoom = rooms.get(currentRoomID);
  //saveRoom(currentRoom);
  toolbar.render();

  if (mousePressed && mouseY > toolbar._height + gridSizeY && mouseX > gridSizeX && mouseX < width-gridSizeX && mouseY < height-gridSizeY) {
    currentRoom.grid[mouseGridX][mouseGridY-(toolbar._height/gridSizeY)] = getTile(mouseGridX, mouseGridY-(toolbar._height/gridSizeY), selectedTileID, null);
  }
  pushMatrix();
  translate(0, toolbar._height);
  currentRoom.render();
  popMatrix();
  fill(255, 0, 0);
  text(int(frameRate) + "FPS", width-gridSizeX, 12);
}
