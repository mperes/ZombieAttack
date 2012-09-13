class Score implements Comparable<Score> {
  import java.util.UUID; 
  
  float time;
  int score;
  int kills;
  UUID playerID; 
  
  Score(int score, float time, int kills, UUID playerID) {
    this.score = score;
    this.time = time;
    this.kills = kills;
    this.playerID = playerID;
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
    return score + ";" + time + ";" + kills + ";" + playerID.toString(); 
  }
  
}
