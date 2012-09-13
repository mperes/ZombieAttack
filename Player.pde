class Player {
  
  
  String name;
  int energy;
  int currentEnergy;
  PVector position;
  float facingDirection;
  int kills;
  int score;
  float survival;
  Weapon weapon;
  DirectionSolver directionSolver;
  
  Player(String name, float x, float y, float facingDirection, Weapon weapon) {
    this.name = name;
    this.position = new PVector(x, y, 0.0);
    this.facingDirection = facingDirection;
    kills = 0;
    score = 0;
    survival = 0.0;
    energy = INITIALENERGY;
    currentEnergy = INITIALENERGY;
    this.weapon = weapon;
    directionSolver = new DirectionSolver();
  }
  
  void fire() {
    weapon.fire(position.x, position.y, facingDirection-1.5*PI);
  }
  void reload() {
    weapon.reload();
  }
  void update() {
    directionSolver.update();
    facingDirection = directionSolver.getDirection();
    
    for(int x = 0;x<weapon.bullets.size();x++){
      Bullet bullet = weapon.bullets.get(x);
      bullet.update();
       
       if(!bullet.alive)
         weapon.bullets.remove(x);
    }
  }
  
}
