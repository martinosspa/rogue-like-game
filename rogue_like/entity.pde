class Entity {
  int x;
  int y;
  int type;
  float maxHealth;
  float health;
  boolean dead = false;

  Entity(int xx, int yy, float tempMaxHealth) {
    x = xx;
    y = yy;
    maxHealth = tempMaxHealth;
    health = maxHealth;
  }

  void takeDamage(float damage) {
    health = constrain(health - damage, 0, maxHealth);
    if (health == 0) {
      dead = true;
    }
  }
}
