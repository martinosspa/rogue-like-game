class Transition {
  int timer = 0;
  int maxTimer;
  boolean drawing = false;
  Transition() {
    maxTimer = frames;
  }

  void update() {
    if (timer > 0) {
      timer--;
    }
    if (timer == 0) {
      drawing = false;
    }
  }
  void startRender() {
    timer = maxTimer;
    drawing = true;
  }
  void render() {
    fill(map(timer, 0, maxTimer, 255, 0));
    noStroke();
    rect(0, 0, width, height);
  }
}
