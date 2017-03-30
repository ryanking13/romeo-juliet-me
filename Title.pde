class Title{
  String gameTitle;
  Button startButton;
  PImage startButtonImage;
  
  public Title(){
    gameTitle = "Romeo & Juliet & Me";
    startButtonImage = loadImage("StartButton.png");
    startButton = new Button(width/2-100, height/2, 200,100, startButtonImage, "startGame");  
  }
  
  public void setup(){
    fill(0);  
    textFont(loadFont("FelixTitlingMT-48.vlw"), 50);
    textAlign(CENTER, TOP);
  }
  
  public void draw(){
    background(255);
    text(gameTitle, width/2, 100);
    startButton.generate();
  }
  
  public void startGame(){
    setSceneNumber(STAGE_SCENE);
  }
  
  public void mousePressed(){
    if(startButton.isInside(mouseX,mouseY)){      
        try{
          Method method = getClass().getDeclaredMethod(startButton.getFunction());
          method.invoke(this, new Object[]{});
          return;
        }
        catch(Exception e){
          print("Not Implemented Method Called!");
        }
    }
  }
}