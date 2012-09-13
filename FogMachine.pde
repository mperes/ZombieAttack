class FogMachine{

  PImage fogImage;
  PImage fog;
  PVector pos;
  int verticalDirection = -1;
  int horizontalDirection = -2;
  
  FogMachine(){
    fogImage = loadImage(IMGPATH+"fog.png");
    pos = new PVector(0,0);
  }
  
  void update(){
    if(abs(pos.x) < fogImage.width - width || pos.x < 0){
      pos.x += horizontalDirection;
    }else{
      horizontalDirection *= -1;
    }
    
    if(abs(pos.y) < fogImage.height - height || pos.y > 0 ){
      pos.y += verticalDirection;
    }else{
      verticalDirection *= -1;
    }
  }
  
  void draw(){
    image(fogImage, pos.x, pos.y);
  }
}
