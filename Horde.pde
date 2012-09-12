class Horde {
  
  ArrayList<Enemy> enemies;
  Player player;
  AudioSample fx_die;
  
  Horde(Player player) {
    enemies = new ArrayList<Enemy>();
    this.player = player;
    fx_die = minim.loadSample(SOUNDFXPATH+"enemy_die.wav", 2048);
  }
  
  void spawn() {
    //(int energy, float x, float y, float speed, float power)
    float angle = radians(90);//random(2*PI);
    float spawndist = random(40);
    float spawnX = sin(angle)*(RADARSIZE/2+2*ENEMYSIZE+spawndist)+width/2;
    float spawnY = cos(angle)*(RADARSIZE/2+2*ENEMYSIZE+spawndist)+height/2;
    enemies.add(new Enemy(100, spawnX, spawnY, 0.1, 2, 20));
  }
  
  void update() {
    for(int b=0; b<player.weapon.bullets.size(); b++) {
      Bullet bullet = player.weapon.bullets.get(b);
      for(int e=0; e<enemies.size(); e++) {
        Enemy enemy = enemies.get(e);
        if( pow((bullet.position.x-enemy.position.x), 2) + pow((bullet.position.y - enemy.position.y), 2) < pow(15, 2)  ) {
          //Enemy hit;
          enemy.die();
          enemies.remove(e);
          player.weapon.bullets.remove(b);
          fx_die.trigger();
          break;
        }
      }
    }
    for(Enemy enemy : enemies ) {
      enemy.update(player);
    }
  }
  
  void evade(Player player) {
    //(x-center_x)^2 + (y - center_y)^2 < radius^2
  }
  
}
