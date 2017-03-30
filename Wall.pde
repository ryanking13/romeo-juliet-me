class Wall{
  public final int HORIZONTAL = 1;
  public final int VERTICAL = 2;
  public final float WALL_BREADTH = 10;
  public int axis; // 1 == horizontal, 2 == vertical
  
  public float axisPos;
  public float start;
  public float end;
  
  public float generatedTime;
  public float duration;
  
  public boolean isDrawing;
  
  public Wall(int axis, float axisPos, float start, float end, float duration){
    this.axis = axis;
    this.axisPos = axisPos;
    this.start = start;
    this.end = end;
    this.duration = duration;
    //this.isDrawing = drawing;
    generatedTime = millis();
  }
  
  public void generate(){
    pushMatrix();
    strokeWeight(5);
    stroke(255);
    imageMode(CORNER);
    if(axis == HORIZONTAL) image(wallHor, start, axisPos - WALL_BREADTH/2, end-start, WALL_BREADTH);
    else if(axis == VERTICAL) image(wallVer, axisPos - WALL_BREADTH/2, start, WALL_BREADTH, end-start);
    popMatrix();
  }
  
  public boolean isBlocking(float x, float sx, float y, float sy, float size){
    //if(isDrawing) return false;
    
    if(axis == HORIZONTAL){
      if(sy > 0 && axisPos - (y+size*3/4)>= 0 && axisPos - (y+size) < WALL_BREADTH)
        return true;
      else if(sy < 0 && (y+size/4) - axisPos >= 0 && y - axisPos < WALL_BREADTH)
        return true;
    }
    else if(axis == VERTICAL){
      if(sx > 0 && axisPos - (x+size*3/4) >= 0 && axisPos - (x+size) < WALL_BREADTH)
        return true;
      else if(sx < 0 && (x+size/4) - axisPos >= 0 && x - axisPos < WALL_BREADTH)
        return true;
    }
    return false;
  }
  
  public boolean isOverDuration(){
    if(millis() - generatedTime > duration) return true;
    else return false;
  }
  
  public void changeDuration(float duration){
    this.duration += duration;
  }
}