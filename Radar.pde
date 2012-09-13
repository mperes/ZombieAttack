class Radar {
  
  Horde horde;
  FogMachine fogMachine;
  PImage lifebar;
  PImage shellcase;
  PImage sightMask;
  
  Radar(Horde horde) {
    this.horde = horde;
    this.fogMachine = new FogMachine();
    lifebar = loadImage(IMGPATH+"lifebar.png");
    shellcase = loadImage(IMGPATH+"shellcase.png");
    sightMask = loadImage(IMGPATH+"sightmask.png");
  }
  
  void draw() {
    //Drawing radar
    stroke(200);
    strokeWeight(2);
    noFill();
    ellipseMode(CENTER);
    floorGenerator.draw();
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
    for(Enemy enemy : horde.enemies) {
      if( pow((enemy.position.x - width/2), 2) + pow((enemy.position.y - height/2), 2) < pow(RADARSIZE/2, 2)  ) {
        color colorWeak = color(140, 200, 60);
        color colorStrong = color(200, 60, 60);
        float mappedColor = map((float)enemy.energy, 1, 5, 0, 1);
        color colorCurrent = lerpColor(colorWeak, colorStrong, mappedColor);
        fill(colorCurrent);
        imageMode(CENTER);
        rectMode(CENTER);
        tint(255, 255);
        int posX = round(enemy.position.x);
        int posY = round(enemy.position.y);
        rect(posX, posY, 20, 20);
        image(horde.enemySprites[enemy.sprite], posX, posY);
        imageMode(CORNER);
        rectMode(CORNER);
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
    
    imageMode(CENTER);
    image(sightMask, width/2, height/2);
    fill(0);
    rect(0, 0, (width-sightMask.width)/2, height);
    rect(width/2+sightMask.width/2, 0, (width-sightMask.width)/2, height);
    rect(0, 0, width, (height-sightMask.height)/2);
    rect(0, height/2+sightMask.height/2, width, (height-sightMask.height)/2);
    imageMode(CORNER);
    
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
