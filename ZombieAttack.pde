import fullscreen.*; 
import ddf.minim.*;
import oscP5.*;
import netP5.*;

FullScreen fs;
OscP5 osc;

Minim minim; //Global sound object

Player player;
Shotgun shotgun;
Horde horde;
Radar radar;
SplashScreen splashScreen;
ScoreBoard scoreBoard;
FloorGenerator floorGenerator;

int shotDelayCount = 0;
float scoreBoardDisplayedFor;

/*
This is used to hold the state of the game:
 0 - Splash Screen
 1 - Playing
 2 - Game Over
 3 - Score Board
 */

int scene;

AudioPlayer backgroundMusic;
String[] soundtracks = {
  "1 - Pestis Cruento.mp3", 
  "2 - Unholy Voices.mp3", 
  "3 - Dark Carnival.mp3", 
  "4 - Infuscomus.mp3", 
  "5 - Father Time.mp3", 
  "6 - Waiting For The End.mp3", 
  "7 - Fate Of The Damned.mp3", 
  "8 - Double, Double, Toil and Trouble.mp3"
};

void setup() {
  size(MAPWIDTH, MAPHEIGHT);
  smooth();

  minim = new Minim(this);
  
  floorGenerator = new FloorGenerator(MAPWIDTH, MAPHEIGHT);

  resetGame();

  // Listen to port
  osc = new OscP5(this, 12000);
  String deviceNum = "6";
  // Osc plug      Function name      Plug name
  //  |                |                |
  osc.plug(this, "reload", "/device/"+deviceNum+"/component/Btn_MOVE");
  osc.plug(this, "resetGyroRotation", "/device/"+deviceNum+"/component/Btn_SELECT");
  osc.plug(this, "trigger", "/device/"+deviceNum+"/component/Btn_T");
  osc.plug(this, "setGyroValue", "/device/"+deviceNum+"/component/GyroZ");

  backgroundMusic = minim.loadFile( randTrack() );
  backgroundMusic.play();
  
  fs = new FullScreen(this); 
  fs.enter(); 
}

void draw() {
  switch(scene) {
  case 0:
    splashScreen.draw();
    break;
  case 1:
    if(player.currentEnergy <= 0) {
      //(int score, float time, int kills)
      scoreBoard.addScore();
      scene = 2;
      scoreBoardDisplayedFor = millis();
    } else {
      background(0);
      player.update();
      horde.update();
      radar.draw();
    }
    break;
  case 2:
    if(millis()-scoreBoardDisplayedFor >= SCOREBOARDDISPLAYTIME) {
      resetGame();
    } else {
      background(0);
      scoreBoard.draw();
    }
    break;
  }
  
  shotDelayCount++;
}

void setGyroValue(float val) {
  player.directionSolver.setValue(val);
}

void resetGyroRotation(float button) {
  player.directionSolver.resetRotation(button);
}

void reload(float button) {
  if (shotDelayCount >= SHOOTDELAY) {
    if (button == 1.0) {
      player.reload();
      shotDelayCount = 0;
    }
  }
}

void trigger(float trigger) {
  if (trigger > 0.0) {
    switch(scene) {
      case 0:
        scene = 1;
        //backgroundMusic.setGain(SOUNDTRACKGAIN);
        break;
      case 1:
        if(shotDelayCount >= SHOOTDELAY){
          player.fire();
          shotDelayCount = 0;
        }
        break;
    }
  }
}

void keyPressed() {
  switch(keyCode) {
  case 32: //Fire
    if (shotDelayCount >= SHOOTDELAY) {
      switch(scene) {
      case 0:
        scene = 1;
        //backgroundMusic.setGain(SOUNDTRACKGAIN);
        break;
      case 1:
        player.fire();
        shotDelayCount = 0;
        break;
      }
    }
    break;
  case 82: //Reload
    if (shotDelayCount >= SHOOTDELAY) {
      player.reload();
      shotDelayCount = 0;
    }
    break;  
  case 37:
    player.directionSolver.setValue(1000);
    break;
  case 39:
    player.directionSolver.setValue(-1000);
    break;
  default:
    break;
  }
}

void keyReleased() {
  player.directionSolver.setValue(0);
}

void stop()
{
  backgroundMusic.close();
  minim.stop();
  super.stop();
}

String randTrack() {
  int track = round(random(soundtracks.length-1));
  String trackpath = SOUNDTRACKPATH+soundtracks[track];
  return trackpath;
}

void updateTrack() {
  if (!backgroundMusic.isPlaying()) {
    backgroundMusic = minim.loadFile( randTrack() );
    backgroundMusic.play();
    //backgroundMusic.setGain(SOUNDTRACKGAIN);
  }
}

void resetGame() {
    //Weapon creation
  shotgun = new Shotgun();
  
  //Player creation: Name, X Pos, Y Pos, Initial direction, Initial weapon.
  player = new Player("Miguel", width/2, height/2, 0.0, shotgun);

  horde = new Horde(player);
  for (int x=0; x<5; x++) {
    horde.spawn();
  }

  radar = new Radar(horde);
  
  backgroundMusic = minim.loadFile( randTrack() );
  backgroundMusic.play();

  scene = 0;
  splashScreen = new SplashScreen();
  scoreBoard = new ScoreBoard(player);
}

