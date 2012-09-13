class FloorGenerator {
  
  PImage floorImage;
  PImage[] floorTiles;
  color baseColor = color(0);
  int tileMargin = 1;
  int tileSize = 11;
  
  FloorGenerator(int floorWidth, int floorHeight) {
    floorTiles = new PImage[10];
    for(int i=0; i<floorTiles.length; i++) {
      floorTiles[i] = loadImage(IMGPATH+"floortiles/floortile_"+(i+1)+".png");
    }
    PGraphics pg = createGraphics(floorWidth, floorHeight, JAVA2D);
    pg.beginDraw();
    pg.background(baseColor);
    for(int r=0; r<ceil(floorHeight/(tileMargin+tileSize)); r++) {
      for(int c=0; c<ceil(floorWidth/(tileMargin+tileSize)); c++) {
        int floorImage = round(random(floorTiles.length-1));
        pg.image(floorTiles[floorImage], c*(tileMargin+tileSize), r*(tileMargin+tileSize));
      }
    }
    pg.endDraw();
    floorImage = pg.get(0, 0, pg.width, pg.height);
  }
  
  void draw() {
    set(0, 0, floorImage);
  }
  
}
