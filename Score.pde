class Score implements Comparable<Score> {
  
  float time;
  int score;
  int kills; 
  
  Score(int score, float time, int kills) {
    this.score = score;
    this.time = time;
    this.kills = kills;
  }
  
  String getTime() {
    String secs = Integer.toString((int)((time / 1000) % 60));
    String mins = Integer.toString((int)((time / 1000) / 60));
    secs = (secs.length() < 2) ? "0"+secs : secs;
    mins = (mins.length() < 2) ? "0"+mins : mins;
      
    return mins+":"+secs;
  }
  
  int compareTo(Score anotherInstance) {
    return anotherInstance.score - this.score;
  }
  
  String asCSV() {
    return score + ";" + time + ";" + kills; 
  }
  
}
