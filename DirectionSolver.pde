class DirectionSolver{
  float value;
  float totalV;
  int numReadings = 8;
  float runningTotal = 0;
  int thresh = 50;
  float[] readings = new float[numReadings];
  int index = 0;
  float average = 0;

  float currentRot = 0;
  
  DirectionSolver(){
    // initialize all the readings to 0:
    for (int thisReading = 0; thisReading < numReadings; thisReading++)
      readings[thisReading] = 0; 
  }
  
  void setValue(float theValue) {
    value = theValue;
  }

  void resetRotation(float moveButton){
    if(moveButton == 1.0)
      currentRot = 0;
  }
  
  void update(){
    runningTotal = runningTotal - readings[index];//subtract the last reading
    readings[index] = value;//read from OSC
  
    runningTotal = runningTotal+readings[index];//add the next position to the total
    index ++;
  
    if(index >= numReadings)
      index = 0;
    
    average = runningTotal / numReadings;
  
    currentRot += average;
  }
  
  float getDirection(){
    return currentRot * -0.000042;
  }
}
