class SplashScreen {
  
  PImage splashScreenTitle;
  PImage splashScreenStart;

  SplashScreen() {
      splashScreenTitle = loadImage(IMGPATH+"splashscreen-title.png");
      splashScreenStart = loadImage(IMGPATH+"splashscreen-start.png");
  }
  
  void draw() {
    background(0);
    pushMatrix();
    imageMode(CENTER);
    translate(width/2, height/2);
    tint(255, 255);
    image(splashScreenTitle, 0, splashScreenTitle.height/10);
    
    float startOpacity = abs(sin(radians(millis()/10))) * 255;
    tint(255, startOpacity);
    image(splashScreenStart, 0, splashScreenStart.height*2);   
    popMatrix();
  }
  
}
