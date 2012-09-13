class Horde {
  
  ArrayList<Enemy> enemies;
  Player player;
  ArrayList<AudioSample> fx_die;
  AudioSample fx_die1;
  AudioSample fx_die2;
  AudioSample fx_die3;
  AudioSample fx_damage;
  PImage[] enemySprites;
  int level;
  float lastWave;
  float lastSpawn;
  
  String[] enemy_deaths = {
    SOUNDFXPATH+"enemy_die1.mp3",
    SOUNDFXPATH+"enemy_die2.mp3",
    SOUNDFXPATH+"enemy_die3.mp3"
  };
  
  Horde(Player player) {
    enemies = new ArrayList<Enemy>();
    fx_die = new ArrayList<AudioSample>();
    this.player = player;
    
    for(int x = 0;x < enemy_deaths.length;x++){
      fx_die.add(minim.loadSample(enemy_deaths[x], SOUNDBUFFERSIZE));
    }
    fx_damage = minim.loadSample(SOUNDFXPATH+"player_hit1.mp3");
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
    enemies.add(new Enemy(levelEnergy, spawnX, spawnY, levelSpeed, levelPower, levelAwareness, round(random(enemySprites.length-1)), round(random(enemy_deaths.length-1))));
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
    if(millis()-lastSpawn > WAVESPAWN / (level+1)) {
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
            fx_die.get(enemy.death_sound).trigger();
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
        fx_damage.trigger();
        player.currentEnergy -= enemy.power;
        enemy.die();
        enemies.remove(e);
      }
    }
  }
  
  void evade(Player player) {
  }
  
}
