class Radar {
  
  Horde horde;
  FogMachine fogMachine;
  PImage lifebar;
  PImage shellcase;
  PImage sightMask;
  PImage stage;
  
  Radar(Horde horde) {
    this.horde = horde;
    this.fogMachine = new FogMachine();
    lifebar = loadImage(IMGPATH+"lifebar.png");
    shellcase = loadImage(IMGPATH+"shellcase.png");
    sightMask = loadImage(IMGPATH+"sightmask.png");
    stage = loadImage(IMGPATH+"stage.png");
  }
  
  void draw() {
    //Drawing radar
    stroke(200);
    strokeWeight(2);
    noFill();
    ellipseMode(CENTER);
    image(stage, 0, 0);
    //ellipse(width/2, height/2, RADARSIZE, RADARSIZE);
   
    //Drawing hearing distance
    stroke(200);
    noFill();
    ellipseMode(CENTER);
    //ellipse(width/2, height/2, HEARINGDISTANCE*2, HEARINGDISTANCE*2); 
    
    //Drawing player
    noStroke();
    fill(0, 0, 255);
    //ellipse(horde.player.position.x, horde.player.position.y, 5, 5);
    drawPlayer();
    
    //Drawing enemies
    fill(255, 0, 0);
    for(Enemy enemy : horde.enemies) {
      if( pow((enemy.position.x - width/2), 2) + pow((enemy.position.y - height/2), 2) < pow(RADARSIZE/2, 2)  ) {
        //ellipse(enemy.position.x, enemy.position.y, ENEMYSIZE, ENEMYSIZE);
        imageMode(CENTER);
        tint(255, 255);
        image(horde.enemySprites[enemy.sprite], round(enemy.position.x), round(enemy.position.y));
        imageMode(CORNER);
      }
    }
    
    //Drawing bullets
    fill(255);
    for(Bullet bullet : horde.player.weapon.bullets) {
      if( pow((bullet.position.x - width/2), 2) + pow((bullet.position.y - height/2), 2) < pow(RADARSIZE/2, 2)  ) {
        ellipse(bullet.position.x, bullet.position.y, 5, 5);
      }
    }
    
    fogMachine.update();
    fogMachine.draw();
    image(sightMask, 0, 0);
    
    //Draw life bar
    drawPlayerStats();
  }
  
  void drawPlayer() {
    float playerSize = 20;
    float x = horde.player.position.x;
    float y = horde.player.position.y;
    pushMatrix();
    translate(x, y);
    scale(3);
    rotate(player.facingDirection);
    beginShape();
      vertex(0, -5);
      vertex(5, 5);
      vertex(-5, 5);
      //vertex( cos(0+horde.player.facingDirection)*playerSize+horde.player.position.x, sin(0+horde.player.facingDirection)*playerSize+horde.player.position.y);
      //vertex( cos(2*PI/3+horde.player.facingDirection)*playerSize+horde.player.position.x, sin(120+horde.player.facingDirection)*playerSize+horde.player.position.y);
      //vertex( cos(4*PI/3+horde.player.facingDirection)*-playerSize+horde.player.position.x, sin(240+horde.player.facingDirection)*playerSize+horde.player.position.y);
    endShape(CLOSE);
    popMatrix();
  }
  
  void drawPlayerStats() {
    int barWidth = 198;
    int barHeight = 18;
    float barCurrent = round((float)horde.player.currentEnergy / (float)horde.player.energy * (float)barWidth);
    color colorFull = color(140, 200, 60);
    color colorDying = color(200, 60, 60);
    color colorCurrent = lerpColor(colorDying, colorFull, (float)horde.player.currentEnergy / (float)horde.player.energy);
    tint(255, 255);
    pushMatrix();
      translate(10, 10);
      noStroke();
      fill(colorCurrent);
      rect(3, 3, barCurrent, barHeight);
      image(lifebar, 0, 0);
      for(int i=0; i<horde.player.weapon.currentAmmo; i++) {
        image(shellcase, (shellcase.width+5)*i, lifebar.height+10);
      }
    popMatrix(); 
    
  }
  
}
