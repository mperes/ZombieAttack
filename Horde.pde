class Horde {
  
  ArrayList<Enemy> enemies;
  ArrayList<DeadZombie> deadZombies;
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
  float goreCount;
  Boolean gore;
  
  String[] enemy_deaths = {
    SOUNDFXPATH+"enemy_die1.mp3",
    SOUNDFXPATH+"enemy_die2.mp3",
    SOUNDFXPATH+"enemy_die3.mp3"
  };
  
  Horde(Player player) {
    enemies = new ArrayList<Enemy>();
    deadZombies = new ArrayList<DeadZombie>();
    fx_die = new ArrayList<AudioSample>();
    this.player = player;
    
    for(int x = 0;x < enemy_deaths.length;x++){
      fx_die.add(minim.loadSample(enemy_deaths[x], SOUNDBUFFERSIZE));
    }
    fx_damage = minim.loadSample(SOUNDFXPATH+"player_hit1.mp3");
    enemySprites = new PImage[3];
    enemySprites[0] = loadImage(IMGPATH+"enemy_sprite_1.png");
    enemySprites[1] = loadImage(IMGPATH+"enemy_sprite_2.png");
    enemySprites[2] = loadImage(IMGPATH+"enemy_sprite_3.png");
    level = 0;
    lastWave = millis();
    lastSpawn = millis();
    goreCount = 0;
    gore = false;
  }
  
  void spawn() {
    float angle = random(2*PI); //radians(90);
    float spawndist = random(40);
    float spawnX = sin(angle)*(RADARSIZE/2+2*ENEMYSIZE+spawndist)+width/2;
    float spawnY = cos(angle)*(RADARSIZE/2+2*ENEMYSIZE+spawndist)+height/2;
    
    //Enemy generation
    //int energy, float x, float y, float speed, float power, float awareness, int sprite
    int levelEnergy = min( levelEnergy = 1 + round(random(level)),  5);
    float levelSpeed = 20;//0.25 + random(level);
    float levelPower = 5 + random(level);
    float levelAwareness = 100;//random(4)+random(level)+1;
    enemies.add(new Enemy(levelEnergy, spawnX, spawnY, levelSpeed, levelPower, levelAwareness, round(random(enemySprites.length-1)), round(random(enemy_deaths.length-1))));
  }
  
  void update() {
    
    //Check gore effect
    checkGore();
    
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
            
            deadZombies.add(new DeadZombie(new PVector(enemy.position.x, enemy.position.y)));
            
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
        doGore();
        player.currentEnergy -= enemy.power;
        enemy.die();
        enemies.remove(e);
      }
    }
    
    for(int d=0; d<deadZombies.size(); d++) {
      DeadZombie dz = deadZombies.get(d);
      dz.update();
      if(dz.stayCounter > CORPSESTAY){
        deadZombies.remove(dz);
      }
    }
  }
  
  void evade(Player player) {
  }
  
  void checkGore() {
    if(gore) {
      goreCount -= 1;
      if(goreCount <= 0) {
        gore = false;
        goreCount = 0;
      }
    }
  }
  void doGore() {
    if(goreCount > 0) {
    } else {
      gore = true;
      goreCount = 100;
    }
  }
}
