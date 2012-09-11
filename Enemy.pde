class Enemy {
  
  int energy;
  PVector position;
  float speed;
  float power;
  
  Enemy(int energy, float x, float y, float speed, float power) {
    this.energy = energy;
    this.position = new PVector(x, y, 0.0);
    this.speed = speed;
    this.power = power;
  }
  
  void update(Player player) {
    float angle = atan2(position.y-player.position.y, position.x-player.position.x);
    float newX = cos(angle-PI) * speed + position.x;
    float newY = sin(angle-PI) * speed + position.y;
    position.set(newX, newY, 0.0);
  }
  
}
