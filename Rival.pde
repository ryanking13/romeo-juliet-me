class Rival{
  
  private PVector pos;
  private float temptationSpeed;
  private float generatedTime;
  private float duration;
  
  private PImage image;  
  private final float SIZE = 50;
  
  private Actor actor;
  
  public Rival(float x, float y, float temptationSpeed, float duration){
    pos = new PVector(x,y);
    generatedTime = millis();
    this.temptationSpeed = temptationSpeed;
    this.duration = duration;
  }
  
  public void generate(){
    image(image, getX()-SIZE/2, getY()-SIZE/2, SIZE, SIZE);
    actor.showHeartEffect();
  }

  public void temptActor(){
    float dx = getX() - actor.getX();
    float dy = getY() - actor.getY();
    float d = abs(dx) + abs(dy);
    float tempt = temptationSpeed - actor.getResistSpeed();
    if(d == 0) return;
    
    float speedX = max(0,tempt) * (dx / d );
    float speedY = max(0,tempt) * (dy / d );
    
    actor.move(speedX, speedY);
  }
  
  public boolean isOverDuration(){
    if(millis() - generatedTime > duration) return true;
    else return false;
  }
  
  public void setImage(PImage image){
    this.image = image;
  }
  
  public void setActor(Actor actor){
    this.actor = actor;
  }
  
  public float getX(){ return pos.x; }
  public float getY(){ return pos.y; }
}