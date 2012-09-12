class Bullet {
  
  PVector position;
  float speed;
  float direction;
  float range;
  float ticksFromOrigin = 0;
  boolean alive;
  
  Bullet(float x, float y, float direction, float range) {
    this.position = new PVector(x, y, 0.0);
    this.direction = direction;
    this.alive = true;
    this.range = range;
    this.speed = BULLETSPEED;
  }
  
  void update() {
    float newX = cos(direction-PI) * speed + position.x;
    float newY = sin(direction-PI) * speed + position.y;
    position.set(newX, newY, 0.0);
    ticksFromOrigin++;
    
    if(position.x < 0 || position.x > width || position.y < 0 || position.y > height || ticksFromOrigin >= range)
      this.alive = false;
  }
  
}
