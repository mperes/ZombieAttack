class Radar {
  
  Horde horde;
  
  Radar(Horde horde) {
    this.horde = horde;
  }
  
  void draw() {
    //Drawing radar
    stroke(100);
    strokeWeight(2);
    noFill();
    ellipseMode(CENTER);
    ellipse(width/2, height/2, RADARSIZE, RADARSIZE);
   
    //Drawing hearing distance
    stroke(200);
    noFill();
    ellipseMode(CENTER);
    ellipse(width/2, height/2, HEARINGDISTANCE*2, HEARINGDISTANCE*2); 
    
    //Drawing player
    noStroke();
    fill(0, 0, 255);
    //ellipse(horde.player.position.x, horde.player.position.y, 5, 5);
    drawPlayer();
    
    //Drawing enemies
    fill(255, 0, 0);
    for(Enemy enemy : horde.enemies) {
      if( pow((enemy.position.x - width/2), 2) + pow((enemy.position.y - height/2), 2) < pow(RADARSIZE/2, 2)  ) {
        ellipse(enemy.position.x, enemy.position.y, ENEMYSIZE, ENEMYSIZE);
      }
    }
    
    //Drawing bullets
    fill(0);
    for(Bullet bullet : horde.player.weapon.bullets) {
      if( pow((bullet.position.x - width/2), 2) + pow((bullet.position.y - height/2), 2) < pow(RADARSIZE/2, 2)  ) {
        ellipse(bullet.position.x, bullet.position.y, 5, 5);
      }
    }
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
  
}
