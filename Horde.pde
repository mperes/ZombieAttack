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
    enemies.add(new Enemy(100, round(random(1))*random(width), round(random(1))*random(height), 0.1, 2));
  }
  
  void update() {
    for(int b=0; b<player.weapon.bullets.size(); b++) {
      Bullet bullet = player.weapon.bullets.get(b);
      for(int e=0; e<enemies.size(); e++) {
        Enemy enemy = enemies.get(e);
        if( pow((bullet.position.x-enemy.position.x), 2) + pow((bullet.position.y - enemy.position.y), 2) < pow(15, 2)  ) {
          //Enemy hit;
          enemies.remove(e);
          player.weapon.bullets.remove(b);
          fx_die.trigger();
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
