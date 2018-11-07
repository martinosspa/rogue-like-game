final int frame_rate = 60;
final int room_ratio_x = 20;
final int room_ratio_y = 15;


int gridSizeX = 0;
int gridSizeY = 0;
int mouseGridX = 0;
int mouseGridY = 0;
//Room testRoom = new Room(0, 0);
Level current_level;
Player player;

void setup() {
  size(800, 600);
  current_level = new Level(1);
  player = new Player();
  frameRate(frame_rate);
}



void draw() {
  gridSizeX = width/room_ratio_x;
  gridSizeY = height/room_ratio_y;
  mouseGridX = (mouseX - (mouseX%gridSizeX)) / gridSizeX;
  mouseGridY = (mouseY - (mouseY%gridSizeY)) / gridSizeY;
  render_room();
}
