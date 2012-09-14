//Resolutions
final int MAPWIDTH = 1024;
final int MAPHEIGHT = 768;

//Path to sound effect files. This path is relative to /Data
final String SOUNDFXPATH = "soundfx/";
final String SOUNDTRACKPATH = "soundtracklow/Blood/";
final float SOUNDTRACKGAIN = -25.0;
final int SOUNDBUFFERSIZE = 256; 

final String IMGPATH = "images/";

//Player energy
final int INITIALENERGY = 100;

//Player energy
final int HEARINGDISTANCE = 200;

//Enemy size in the radar
final int ENEMYSIZE = 20;

//How long blood stays on the screen
final int ENEMYCORPSESTAY = 50;

//Size of the radar;
final int RADARSIZE = 450;

//Speed of the bullets
final int BULLETSPEED = 8;

//Shot delay in frames;
final int SHOOTDELAY = 30;

//This is used to calculate the player hit area;
final int PLAYERSIZE = 10;

//Duration of the wave in millis;
final int WAVEDURATION = 60 * 1000;

//Spawn interval of the wave in millis;
final int WAVESPAWN = 10 * 1000;

//Score board path;
final String SCOREBOARDFILE = "scoreboard/scoreboard.csv";
final int SCORESLINEHEIGHT = 50;
final int SCORESDISPLAYED = MAPHEIGHT / SCORESLINEHEIGHT - 1;
final int SCOREBOARDDISPLAYTIME = 20 * 1000; //In millis

