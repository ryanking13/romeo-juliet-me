class Button{
  
  float x;
  float y;
  float sizeX;
  float sizeY;
  
  PImage buttonImage;
  String buttonFunction;
  
  public Button(float x, float y, float sizeX, float sizeY, PImage image, String function){
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.buttonImage = image;
    this.buttonFunction = function;
  }
  
  public void generate(){
    pushMatrix();
    //imageMode(CENTER);
    image(buttonImage,x,y,sizeX,sizeY);
    popMatrix();
  }
  
  public boolean isInside(float mx, float my){
    if(abs(mx - x) <= sizeX && abs(my - y) <= sizeY) return true;
    else return false;
  }
  
  public String getFunction(){ return buttonFunction; }
}