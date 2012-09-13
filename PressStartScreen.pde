class SplashScreen {
  
  PImage splashScreenBackground;
  PImage splashScreenStart;

  SplashScreen() {
      splashScreenBackground = loadImage(IMGPATH+"splashscreen-background.png");
      splashScreenStart = loadImage(IMGPATH+"splashscreen-start.png");
  }
  
  void draw() {
    background(0);
    
    tint(255, 255);
    image(splashScreenBackground, 0, 0);
    
    int startX = width/2 - splashScreenStart.width/2;
    int startY = height - splashScreenStart.height*2;
    float startOpacity = abs(sin(radians(millis()/10))) * 255;
    tint(255, startOpacity);
    image(splashScreenStart, startX, startY);   
  }
  
}
