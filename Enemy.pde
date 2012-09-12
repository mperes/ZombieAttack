class Enemy {
  
  int energy;
  PVector position;
  float speed;
  float power;
  float awareness;
  AudioPlayer fx_move;
  
  Enemy(int energy, float x, float y, float speed, float power, float awareness) {
    this.energy = energy;
    this.position = new PVector(x, y, 0.0);
    this.speed = speed;
    this.power = power;
    this.awareness = awareness;
    //fx_move = minim.loadSample(SOUNDFXPATH+"enemy_move.wav", 2048);
    //fx_move.trigger();
    fx_move = minim.loadFile(SOUNDFXPATH+"enemy_move.wav");
    //fx_move.loop();
  }
  
  void update(Player player) {
    float roll = random(20);
            println(roll+" "+awareness);
      if(roll <= awareness) {
        float angle = atan2(position.y-player.position.y, position.x-player.position.x);
        float newX = cos(angle-PI) * speed + position.x;
        float newY = sin(angle-PI) * speed + position.y;
        position.set(newX, newY, 0.0);
        updateAudio(player);
      }
  }
  
  void updateAudio(Player player) {
    float distance = position.dist(player.position);
      if(distance <= HEARINGDISTANCE) {
        if(!fx_move.isPlaying()) {
          fx_move.loop();  
        }
      } else {
        fx_move.pause();
      }
  }
  
}
