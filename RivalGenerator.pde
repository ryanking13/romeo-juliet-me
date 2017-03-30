class RivalGenerator{
  
  float rivalCooltime;
  float rivalTemptationSpeed;
  float rivalDuration;
  float romeoRivalTime = -10000;
  float julietRivalTime = -10000;
  
  public RivalGenerator(){
    rivalCooltime = 2000;
    rivalTemptationSpeed = 2;
    rivalDuration = 800;
  }
  
  public void changeRivalCooltime(float time){
    rivalCooltime += time;
  }
  public void changeRivalTemptationSpeed(float speed){
    rivalTemptationSpeed += speed;
  }
  public void changeRivalDuration(float duration){
    rivalDuration += duration;
  }
  
  
  void mousePressed(){
    if(mouseButton == LEFT){
      if(isCooltime(romeoRivalTime)){
        //Beep!
        return;
      }
      //BAD CODING... BETTER FIX
      romeoRivalTime = millis();
      romeoRival = new Rival(mouseX, mouseY, rivalTemptationSpeed, rivalDuration);
      romeoRival.setImage(romeoRivalImage);
      romeoRival.setActor(romeo);
      rivalSound.play();
    }
    else if(mouseButton == RIGHT){
      if(isCooltime(julietRivalTime)){
      //Beep!
      return;
      }
    
      //BAD CODING... BETTER FIX
      julietRivalTime = millis();    
      julietRival = new Rival(mouseX, mouseY, rivalTemptationSpeed, rivalDuration);
      julietRival.setImage(julietRivalImage);
      julietRival.setActor(juliet);  
      rivalSound.play();
    }
  }
  
  boolean isCooltime(float rivalTime){
    return (millis() - rivalTime < rivalCooltime);
  }
}