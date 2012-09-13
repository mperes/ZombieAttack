class Horde {
  
  ArrayList<Enemy> enemies;
  Player player;
  AudioSample fx_die;
  AudioPlayer fx_damage;
  PImage[] enemySprites;
  int level;
  float lastWave;
  float lastSpawn;
  
  Horde(Player player) {
    enemies = new ArrayList<Enemy>();
    this.player = player;
    fx_die = minim.loadSample(SOUNDFXPATH+"enemy_die.wav", SOUNDBUFFERSIZE);
    fx_damage = minim.loadFile(SOUNDFXPATH+"enemy_damage.wav");
    enemySprites = new PImage[2];
    enemySprites[0] = loadImage(IMGPATH+"enemy_a.png");
    enemySprites[1] = loadImage(IMGPATH+"enemy_b.png");
    level = 0;
    lastWave = millis();
    lastSpawn = millis();
  }
  
  void spawn() {
    float angle = random(2*PI); //radians(90);
    float spawndist = random(40);
    float spawnX = sin(angle)*(RADARSIZE/2+2*ENEMYSIZE+spawndist)+width/2;
    float spawnY = cos(angle)*(RADARSIZE/2+2*ENEMYSIZE+spawndist)+height/2;
    
    //Enemy generation
    //int energy, float x, float y, float speed, float power, float awareness, int sprite
    int levelEnergy = 1 + round(random(level));
    float levelSpeed = 0.1 + random(level);
    float levelPower = 5 + random(level);
    float levelAwareness = random(4)+random(level)+1;
    enemies.add(new Enemy(levelEnergy, spawnX, spawnY, levelSpeed, levelPower, levelAwareness, round(random(enemySprites.length-1))));
  }
  
  void update() {
    //Advances level;
    if(millis()-lastWave > WAVEDURATION) {
      level++;
      lastWave = millis();
      //Regenerates energy on level up
      //player.currentEnergy = player.energy;
      //println("Advance to level "+level);
    }
    
    //Spawn enemies;
    if(millis()-lastSpawn > WAVESPAWN) {
      lastSpawn = millis();
      spawn();
      //println("Enemy spawned");
    }
    
    for(int b=0; b<player.weapon.bullets.size(); b++) {
      Bullet bullet = player.weapon.bullets.get(b);
      for(int e=0; e<enemies.size(); e++) {
        Enemy enemy = enemies.get(e);
        if( pow((bullet.position.x-enemy.position.x), 2) + pow((bullet.position.y - enemy.position.y), 2) < pow(15, 2)  ) {
          //Enemy hit;
          player.weapon.fx_hit.trigger();
          player.weapon.bullets.remove(b);
          enemy.energy--;
          
          //Enemy killed
          if(enemy.energy <= 0) {
            fx_die.trigger();
            player.kills++;
            player.score =+ enemy.getScore();
            enemy.die();
            enemies.remove(e);
          }
          break;
        }
      }
    }
    for(int e=0; e<enemies.size(); e++) {
      Enemy enemy = enemies.get(e);
      enemy.update(player);
      if( pow((enemy.position.x-player.position.x), 2) + pow((enemy.position.y - player.position.y), 2) < pow(PLAYERSIZE, 2)  ) {
        if(!fx_damage.isPlaying()) {
          fx_damage = minim.loadFile(SOUNDFXPATH+"enemy_damage.wav");
          fx_damage.play();
        }
        player.currentEnergy -= enemy.power;
        enemy.die();
        enemies.remove(e);
      }
    }
  }
  
  void evade(Player player) {
  }
  
}
