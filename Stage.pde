class Stage {

  int stageLevel;
  int score;
  int time;

  void setup(int level) {
    background(0);
    stageLevel = level;
    score = 0;
    //score = 5*(max(1, 10-level));
    time = 30;
    
    fill(255);
    textFont(loadFont("AmiR-HM-48.vlw"), 30);
    textAlign(LEFT, TOP);
    setObjects();
    setImages();
    //delay(1000);
  }

  void draw() {
    background(0);
    showUI();
    showWalls();
    showCooltimes();
    accelerateActors(); 
    moveAndShowActors();

    updateScore();
    if (updateTime() == true) {
      goInterStage();
    }
  }

  void moveAndShowActors() {
    if (romeoRival != null) { 
      romeoRival.generate();
      romeoRival.temptActor();
      if (romeoRival.isOverDuration()) romeoRival = null;
    } else {
      romeo.followPartner();
    }

    romeo.generate();

    if (julietRival != null) {
      julietRival.generate();
      julietRival.temptActor();
      if (julietRival.isOverDuration()) julietRival = null;
    } else {
      juliet.followPartner();
    }

    juliet.generate();
  }

  void accelerateActors() {
    if (frameCount % 300 == 0) {
      romeo.accelerate(0.2);
      juliet.accelerate(0.2);
    }
  }  

  void showWalls() {
    for (int i = walls.size() - 1; i >=0; i--) {
      Wall w = walls.get(i);
      w.generate();
      if (w.isOverDuration()) walls.remove(w);
    }
  }

  void showUI() {
    pushMatrix();
    textAlign(CENTER, TOP);
    text("Score : " + (int)score, 100, 20);
    text("Time : " + time, width - 100, 20);
    text("Level " + stageLevel, width/2, 20);
    popMatrix();
  }
  
  void showCooltimes(){
    if(!romeo.isCooltime()) image(romeo.actorImage, 100, height-50, 30, 30);
    if(!juliet.isCooltime()) image(juliet.actorImage, 200, height-50, 30, 30);
    if(!rivalGenerator.isCooltime(rivalGenerator.romeoRivalTime)) image(romeoRivalImage, 300, height-50, 30, 30);
    if(!rivalGenerator.isCooltime(rivalGenerator.julietRivalTime)) image(julietRivalImage, 400, height-50, 30, 30);
    if(!wallGenerator.isCooltime()) image(wallHor, 500, height-50, 30, 30);
  }

  void updateScore() {
    if (romeo.getPartnerDist() < romeo.getSize()/2) {
      romeo.showHeartEffect();
      juliet.showHeartEffect();
      return;
      /*
      if(frameCount % 60 == 0)
        score--;
      if (score < 0) {
        background(0);
        textAlign(CENTER,CENTER);
        text("GAMEOVER", width/2, height/2);
        frameRate(0);
      }
      */
    }
    if(frameCount % 60 == 0)
      score += romeo.getPartnerDist() * 1.2;
  }

  boolean updateTime() {
    if (frameCount % 60 == 0) time--;

    if (time < 0) return true;
    else return false;
  }

  void goInterStage() {
    delay(1000);
    setSceneNumber(INTER_STAGE_SCENE);
  }
  
  private void setImages() {
    romeo.setActorImage(loadImage("Romeo.png"));
    juliet.setActorImage(loadImage("Juliet.png"));
    romeoRivalImage = loadImage("RomeoRival.png");
    julietRivalImage = loadImage("JulietRival.png");

    wallHor = loadImage("WallHorizontal.png");
    wallVer = loadImage("WallVertical.png");
  }

  private void setObjects() {

    interStage = new InterStage();

    walls = new ArrayList<Wall>();
    wallGenerator = new WallGenerator();
    rivalGenerator = new RivalGenerator();

    romeo = new Actor(random(0, width), random(0+50, height/3), 1.0 + (stageLevel-1)*0.2);
    juliet = new Actor(random(0, width), random(height*2/3, height-50),1.0 + (stageLevel-1)*0.2);
    romeo.setResistSpeed(0.1 + (stageLevel-1)*0.10);
    juliet.setResistSpeed(0.1 +(stageLevel-1)*0.10);
    romeo.setPartner(juliet);
    juliet.setPartner(romeo);
  }

  void keyPressed() {
    wallGenerator.keyPressed();
  }

  void mousePressed() {
    if(romeo.isInside(mouseX,mouseY)){
      romeo.mousePressed();
    }
    else if(juliet.isInside(mouseX,mouseY)){
      juliet.mousePressed();
    }
    else
      rivalGenerator.mousePressed();
  }
}