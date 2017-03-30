class WallGenerator{
  
  float wallSize;
  float wallCooltime;
  float wallDuration;
  
  float sx=0,sy=0;
  float ex=0,ey=0;
  float wallTime = -10000;
  
  public WallGenerator(){
    wallSize = 200;
    wallCooltime = 300;
    wallDuration = 500;
  }
  
  public void changeWallSize(float size){ wallSize += size; }
  public void changeWallCooltime(float time){ wallCooltime += time; }
  public void changeWallDuration(float duration) { wallDuration += duration; }
  
  void keyPressed(){
    if(isCooltime()){
      return;
    }
    
    wallTime = millis();
    wallSound.play();
    if(key == 'z' || key == 'Z'){
      walls.add(new Wall(1, mouseY, mouseX-wallSize/2, mouseX+wallSize/2, wallDuration)); 
    }
    else if(key == 'x' || key == 'X'){
      walls.add(new Wall(2, mouseX, mouseY-wallSize/2, mouseY+wallSize/2, wallDuration));
    }
  }
  
  public boolean isCooltime(){
    return (millis() - wallTime < wallCooltime);
  }
}