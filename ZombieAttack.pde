import ddf.minim.*;
import oscP5.*;
import netP5.*;

OscP5 osc;

Minim minim; //Global sound object

Player player;
Shotgun shotgun;
Horde horde;
Radar radar;

void setup() {
  size(800, 600, P2D);
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
  
  //Weapon creation
  shotgun = new Shotgun();
  
  //Player creation: Name, X Pos, Y Pos, Initial direction, Initial weapon.
  player = new Player("Miguel", width/2, height/2, 0.0, shotgun);
  
  horde = new Horde(player);
  for(int x=0; x<30; x++) {
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
      
    case 37:
      player.directionSolver.setValue(500);
      break;
    case 39:
      player.directionSolver.setValue(-500);
      break;
    default:
      println(keyCode);
      break;
  }
}

void keyReleased(){
  player.directionSolver.setValue(0);
}

void stop()
{
  minim.stop();
  super.stop();
}
