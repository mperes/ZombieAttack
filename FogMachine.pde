class FogMachine{

  PImage fogImage;
  PImage fog;
  PVector pos;
  int vD = -1;
  int hD = -2;
  
  FogMachine(){
    fogImage = loadImage(IMGPATH+"fog.png");
    pos = new PVector(-5,-5);
  }
  
  void update(){
    if((pos.x + hD < 0) && (pos.x + hD) > (width - fogImage.width))
     pos.x += hD;
   else
     hD *= -1;
     
   if((pos.y + vD < 0) && (pos.y + vD) > (height - fogImage.height))
     pos.y += vD;
   else
     vD *= -1;
  }
  
  void draw(){
    image(fogImage, pos.x, pos.y);
  }
}
