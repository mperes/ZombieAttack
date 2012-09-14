class DeadZombie{
  PVector pos;
  int stayCounter = 0;
  
  DeadZombie(PVector pos){
    this.pos = pos;
  }
  
  void update(){
    stayCounter++;
  }

}
