class Enemy {
  
  int energy;
  PVector position;
  float speed;
  float power;
  float awareness;
  int sprite;
  AudioPlayer fx_move;
  
  Enemy(int energy, float x, float y, float speed, float power, float awareness, int sprite) {
    this.energy = energy;
    this.position = new PVector(x, y, 0.0);
    this.speed = speed;
    this.power = power;
    this.awareness = awareness;
    this.sprite = sprite;
    fx_move = minim.loadFile(SOUNDFXPATH+"enemy_move.wav");
  }
  
  void update(Player player) {
    float roll = random(20);
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
        float gain = map(distance, 0, HEARINGDISTANCE, 13.97, -35.00);
        float playerAngle = degrees(player.facingDirection) % 360;
        float enemyAngle = (degrees(atan2(player.position.y-position.y, player.position.x-position.x))-90) % 360;
        float audioAngle = ((playerAngle + enemyAngle) % 360);
        if(audioAngle < 0) { audioAngle = 360 - abs(audioAngle); }
        float pan = sin(radians(audioAngle));

        fx_move.setGain(gain);
        fx_move.setPan(pan);

      } else {
        fx_move.pause();
      }
  }
  
  void die() {
    fx_move.close();
  }
  
  int getScore() {
    return round(speed * power * awareness);
  }
  
}
