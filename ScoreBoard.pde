class ScoreBoard {
  
  String[] scoresFile;
  ArrayList<Score> scores;
  PFont scoreFont;
  
  ScoreBoard() {
    scoresFile = loadStrings(SCOREBOARDFILE);
    scores = new ArrayList<Score>();
    for(String scoreEntry : scoresFile) {
      String[] data = split(scoreEntry, ";");
      scores.add(new Score(
        Integer.parseInt(data[0]),
        Float.parseFloat(data[1]),
        Integer.parseInt(data[2])
      ));
    }
    Collections.sort(scores);
    scoreFont = loadFont("fonts/ProggyOptiS-36.vlw");
  }
  
  void draw() {
    pushMatrix();
    translate(width/2-350, SCORESLINEHEIGHT);
    textFont(scoreFont);
    shadowedText("SCORE", 0, 0, 255, 0, 0);
    shadowedText("KILLS", 300, 0, 255, 0, 0);
    shadowedText("LIVED", 600, 0, 255, 0, 0);
    for(int i=0; i<SCORESDISPLAYED; i++) {
      if(i < scores.size()) {
        Score scoreEntry = scores.get(i);
        shadowedText(Integer.toString(scoreEntry.score), 0, SCORESLINEHEIGHT + SCORESLINEHEIGHT*i, 200);
        shadowedText(Integer.toString(scoreEntry.kills), 300, SCORESLINEHEIGHT + SCORESLINEHEIGHT*i, 200);
        shadowedText(scoreEntry.getTime(), 600, SCORESLINEHEIGHT + SCORESLINEHEIGHT*i, 200);
      }
    }
    popMatrix();
  }
  
  void addScore(int score, float time, int kills) {
    scores.add(new Score(
      score,
      time,
      kills
    ));
    Collections.sort(scores);
    saveScores();
  }
  
  void saveScores() {
    String[] scoreEntries = new String[scores.size()]; 
    for(int i = 0; i<scores.size(); i++) {
      Score scoreEntry = scores.get(i);
      scoreEntries[i] = scoreEntry.asCSV();
    }
    saveStrings("data/"+SCOREBOARDFILE, scoreEntries);
  }
  
  void shadowedText(String shadowtext, int x, int y, int r, int g, int b) {
    noStroke();
    fill(r-100, g-100, b-100);
    text(shadowtext, x+2, y+2);
    fill(r, g, b);
    text(shadowtext, x, y);
  }
  
  void shadowedText(String shadowtext, int x, int y, int bw) {
    noStroke();
    fill(bw-100);
    text(shadowtext, x+2, y+2);
    fill(bw);
    text(shadowtext, x, y);
  }
  
}
