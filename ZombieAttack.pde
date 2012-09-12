import ddf.minim.*;
import oscP5.*;
import netP5.*;

OscP5 osc;

Minim minim; //Global sound object

Player player;
Weapon shotgun;
Horde horde;
Radar radar;

void setup() {
  size(600, 600, P3D);
  smooth();
  
  minim = new Minim(this);
  
  // Listen to port
  osc = new OscP5(this, 12000);
  // Osc plug      Function name      Plug name
  //  |                |                |
  osc.plug(this, "setGyroValue", "/device/4/component/GyroZ");
  osc.plug(this, "reload", "/device/4/component/Btn_MOVE");
  osc.plug(this, "resetGyroRotation", "/device/4/component/Btn_SELECT");
  osc.plug(this, "trigger", "/device/4/component/Btn_T");
  
  //Weapon creation:    Name,   Damage, Range, Max Ammo
  shotgun = new Weapon("shotgun", 1.0,   10,    15);
  
  //Player creation: Name, X Pos, Y Pos, Initial direction, Initial weapon.
  player = new Player("Miguel", width/2, height/2, 0.0, shotgun);
  
  horde = new Horde(player);
  for(int x=0; x<10; x++) {
    horde.spawn();
  }
  
  radar = new Radar(horde);
}

void draw() {
  background(255);
  player.update();
  horde.update();
  radar.draw();
}

void setGyroValue(float val){
  player.directionSolver.setValue(val);
}

void resetGyroRotation(float button){
  player.directionSolver.resetRotation(button);
}

void reload(float button){
  if(button == 1.0)
    player.reload();
}

void trigger(float trigger){
  if(trigger > 0.0)
    player.fire();
}

void keyPressed() {
  switch(keyCode) {
    case 32: //Fire
      player.fire();
      break;
      
    case 82: //Reload
      player.reload();
      break;      
  }
}

void stop()
{
  minim.stop();
  super.stop();
}