class ScoreBoard {
  
  String[] scoresFile;
  ArrayList<Score> scores;
  
  ScoreBoard() {
    scoresFile = loadStrings(SCOREBOARDFILE);
    scores = new ArrayList<Score>();
    for(String scoreEntry : scoresFile) {
      String[] data = split(scoreEntry, ";");
      scores.add(new Score(
        data[0],
        Integer.parseInt(data[1]),
        Float.parseFloat(data[2]),
        Integer.parseInt(data[3])
      ));
    }
    Collections.sort(scores);
  }
  
  void draw() {
    for(int i=0; i<SCORESDISPLAYED; i++) {
    }
  }
  
  void addScore(String team, int score, float time, int kills) {
    scores.add(new Score(
      team,
      score,
      time,
      kills
    ));
    Collections.sort(scores);
    saveScores();
  }
  
  void saveScores() {
    String[] scoreEntries = new String[scores.size()]; 
    for(int i = 0; i<scores.size()-1; i++) {
      Score scoreEntry = scores.get(i);
      scoreEntries[i] = scoreEntry.asCSV();
    }
    saveStrings(SCOREBOARDFILE, scoreEntries);
  }
  
}

class Score implements Comparable<Score> {
  
  String team;
  float time;
  int score;
  int kills; 
  
  Score(String team, int score, float time, int kills) {
    this.team = team;
    this.score = score;
    this.time = time;
    this.kills = kills;
  }
  
  String getScore() {
    String secs = Integer.toString((int)((time / 1000) % 60));
    String mins = Integer.toString((int)((time / 1000) / 60));
    secs = (secs.length() < 2) ? "0"+secs : secs;
    mins = (mins.length() < 2) ? "0"+mins : mins; 
    return mins+":"+secs;
  }
  
  int compareTo(Score anotherInstance) {
    return this.score - anotherInstance.score;
  }
  
  String asCSV() {
    return team + ";" + score + ";" + time + ";" + kills; 
  }
  
}
