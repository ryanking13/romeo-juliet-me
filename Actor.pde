class Actor{
  
  private PVector pos;
  private float speed;
  private float resistSpeed;
  
  private PImage actorImage;
  private PImage heartEffect = loadImage("Heart.png");
  private PImage freezeEffect = loadImage("Bang.png");
  private final float SIZE = 50;
  
  final float FREEZE_COOLTIME = 2000;
  final float FREEZE_DURATION = 1000;
  float freezeTime = 0;
  boolean isFrozen = false;
  
  private Actor partner;
  
  public Actor(float x, float y){
    pos = new PVector(x, y);
    speed = 1.0;
  }
  public Actor(float x, float y, float speed){
    pos = new PVector(x,y);
    this.speed = speed;
  }
  
  public void generate(){
    image(actorImage, pos.x, pos.y, SIZE, SIZE);
  }
  
  public void showHeartEffect(){
    image(heartEffect, getX() + getSize()/2, getY()-20, 20,20);
  }
  public void showFreezeEffect(){
    image(freezeEffect, getX() + getSize()/2, getY()-20, 20,20);
  }
  
  public void followPartner(){
    float dx = partner.getX() - getX();
    float dy = partner.getY() - getY();
    float d = abs(dx) + abs(dy);
    
    if(d == 0) return;
    
    float speedX = speed * (dx / d );
    float speedY = speed * (dy / d );
    
    move(speedX, speedY);
  }
  
  public void move(float mx, float my){
    
    if(checkIfFrozen()){
      showFreezeEffect();
      return;
    }
    
    //BAD CODING... BETTER FIX
    for(Wall w : walls){
      if(w.isBlocking(getX(),mx,getY(),my, SIZE)){
        if(w.axis == w.HORIZONTAL) my = 0;
        else if(w.axis == w.VERTICAL) mx = 0;
      }
    }
    setPos(getX() + mx, getY() + my);
  }
  
  public void accelerate(float acc){
    speed += acc;
  }
  
  public float getPartnerDist(){
    return dist(getX(), getY(), partner.getX(), partner.getY());
  }
  
  public boolean isInside(float x, float y){
    if( abs((getX()+getSize()/2)-x) <= getSize()/2 && abs(getY() + getSize()/2)-y <= getSize()/2){
      return true;
    }
    return false;
  }
  
  public boolean checkIfFrozen(){
    if(isFrozen){
      if(millis() - freezeTime >= FREEZE_DURATION) isFrozen = false;
      return true;
    }
    return false;
  }
  
  
  
  public void setPos(float x, float y){
    pos.x = x;
    pos.y = y;
  }
  public void setSpeed(float speed){
    this.speed = speed;
  }
  public void setResistSpeed(float speed){
    this.resistSpeed = speed;
  }
  public void setActorImage(PImage image){ this.actorImage = image; }
  public void setPartner(Actor partner){ this.partner = partner; }
  
  public float getX(){ return pos.x; }
  public float getY(){ return pos.y; }
  public float getSize() { return SIZE; }
  public float getSpeed(){ return speed; }
  public float getResistSpeed() { return resistSpeed; }
  
  public void mousePressed(){
    if(mouseButton == LEFT){
      if(isCooltime()){
        //Beep!
        return;
      }
      
      freezeSound.play();
      freezeTime = millis();
      isFrozen = true;
    }
    else if(mouseButton == RIGHT){
      // NOT SET
    }
  }
  
  public boolean isCooltime(){
    return (millis() - freezeTime < FREEZE_COOLTIME);
  }
}