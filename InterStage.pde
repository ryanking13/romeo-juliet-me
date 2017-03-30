class InterStage{
  
  PImage upgradeButtonImage;
  PImage nextStageButtonImage;
  List<Button> buttons;
  int money = 0;
  int upgradeCost = 5000;
  
  void setup(){
    upgradeButtonImage = loadImage("Upgrade.png");
    nextStageButtonImage = loadImage("NextStageButton.png");
    setButtons();
    money += stage.score;
    delay(500);
  }
  
  void draw(){
    pushMatrix();
    background(255);
    fill(0,50);
    rect(width/10, height/10, width*4/5, height*4/5);
    
    fill(0);
    textAlign(CENTER, TOP);
    textFont(loadFont("AmiR-HM-48.vlw"),40);
    text("UPGRADE", width/2, height/8);
    textFont(loadFont("AmiR-HM-48.vlw"),20);
    text("MONEY : " + money, width*3/4, height/8);
    
    textAlign(LEFT, CENTER);
    textFont(loadFont("AmiR-HM-48.vlw"),30);
    text("Illusion Attraction(5000)", width/8, height/5); 
    text("Illusion Duration(5000)", width/8, height/5 + 40);
    text("Illusion Cooltime(5000)", width/8, height/5 + 80);
    text("Wall Duration(5000)", width/8, height/5 + 160);
    text("Wall Cooltime(5000)", width/8, height/5 + 200);
    text("Wall Size(5000)", width/8, height/5 + 240);

    for(Button b : buttons){
      b.generate();
    }
    popMatrix();
  }
  
  void setButtons(){
    buttons = new ArrayList<Button>();
    
    buttons.add(new Button(width*3/4, height/5, 100, 30, upgradeButtonImage, "rivalAttractionUpgrade"));
    buttons.add(new Button(width*3/4, height/5+40, 100, 30, upgradeButtonImage, "rivalDurationUpgrade"));
    buttons.add(new Button(width*3/4, height/5+80, 100, 30, upgradeButtonImage, "rivalCooltimeUpgrade"));
    buttons.add(new Button(width*3/4, height/5+160, 100, 30, upgradeButtonImage, "wallDurationUpgrade"));
    buttons.add(new Button(width*3/4, height/5+200, 100, 30, upgradeButtonImage, "wallCooltimeUpgrade"));
    buttons.add(new Button(width*3/4, height/5+240, 100, 30, upgradeButtonImage, "wallSizeUpgrade"));
    
    buttons.add(new Button(width/2-100, height*4/5, 200, 50, nextStageButtonImage, "endInterStage"));
    
    println(buttons.size());
  }
  
  void mousePressed(){
    //println("pressed" + mouseX + mouseY);
    for(Button b : buttons){
      if(b.isInside(mouseX,mouseY)){
        try{
          Method method = getClass().getDeclaredMethod(b.getFunction());
          method.invoke(this, new Object[]{});
          return;
        }
        catch(Exception e){
          print("Not Implemented Method Called!");
        }
      }
    }
  }
  
  void rivalAttractionUpgrade(){
    if(money < upgradeCost) return;
    money -= upgradeCost;
    upgradeSound.play();
    rivalGenerator.changeRivalTemptationSpeed(0.5);
  }
  void rivalDurationUpgrade(){
    if(money < upgradeCost) return;
    money -= upgradeCost;
    upgradeSound.play();    
    rivalGenerator.changeRivalDuration(200);
  }
  void rivalCooltimeUpgrade(){
    if(money < upgradeCost) return;
    money -= upgradeCost;
    upgradeSound.play();
    rivalGenerator.changeRivalCooltime(-200); //<>//
  
  }
  void wallDurationUpgrade(){
    if(money < upgradeCost) return;    
    money -= upgradeCost;
    upgradeSound.play();    
    wallGenerator.changeWallDuration(200);
  }
  void wallCooltimeUpgrade(){
    if(money < upgradeCost) return;
    money -= upgradeCost;
    upgradeSound.play();
    wallGenerator.changeWallCooltime(-100);
  }
  void wallSizeUpgrade(){
    if(money < upgradeCost) return;
    money -= upgradeCost;
    upgradeSound.play();    
    wallGenerator.changeWallSize(50);
  }
  void endInterStage(){
    stageLevel++;
    setSceneNumber(STAGE_SCENE);
    delay(1000);
  }
  
}