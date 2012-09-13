//Resolutions
final int MAPWIDTH = 800;
final int MAPHEIGHT = 480;

//Path to sound effect files. This path is relative to /Data
final String SOUNDFXPATH = "soundfx/";
final String SOUNDTRACKPATH = "soundtrack/Blood/";
final float SOUNDTRACKGAIN = -25;
final int SOUNDBUFFERSIZE = 256; 

final String IMGPATH = "images/";

//Player energy
final int INITIALENERGY = 5;

//Player energy
final int HEARINGDISTANCE = 200;

//Enemy size in the radar
final int ENEMYSIZE = 20;

//Size of the radar;
final int RADARSIZE = 450;

//Speed of the bullets
final int BULLETSPEED = 3;

//Shot delay in frames;
final int SHOOTDELAY = 50;

//This is used to calculate the player hit area;
final int PLAYERSIZE = 10;

//Duration of the wave in millis;
final int WAVEDURATION = 120 * 1000;

//Spawn interval of the wave in millis;
final int WAVESPAWN = 10 * 1000;

//Score board path;
final String SCOREBOARDFILE = "scoreboard/scoreboard.csv";
final int SCORESLINEHEIGHT = 50;
final int SCORESDISPLAYED = MAPHEIGHT / SCORESLINEHEIGHT - 1;
final int SCOREBOARDDISPLAYTIME = 10 * 1000; //In millis

