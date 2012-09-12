class Bullet {
  
  PVector position;
  float speed;
  float direction;
  boolean alive;
  
  Bullet(float x, float y, float direction) {
    this.position = new PVector(x, y, 0.0);
    this.direction = direction;
    this.alive = true;
    this.speed = 3;
  }
  
  void update() {
    float newX = cos(direction-PI) * speed + position.x;
    float newY = sin(direction-PI) * speed + position.y;
    position.set(newX, newY, 0.0);
    
    if(position.x < 0 || position.x > width || position.y < 0 || position.y > height)
      this.alive = false;
  }
  
}
