import processing.sound.*;

import java.util.List;
import java.util.ArrayList;
import java.lang.reflect.Method;

final int TITLE_SCENE = 0;
final int STAGE_SCENE = 1;
final int INTER_STAGE_SCENE = 2;
int sceneNumber = 1;
int stageLevel = 1;

Actor romeo;
Actor juliet;

Rival romeoRival;
Rival julietRival;
PImage romeoRivalImage;
PImage julietRivalImage;
RivalGenerator rivalGenerator;

SoundFile bgm;
SoundFile freezeSound;
SoundFile rivalSound;
SoundFile upgradeSound;
SoundFile wallSound;
PFont font;

List<Wall> walls;
WallGenerator wallGenerator;

PImage wallHor;
PImage wallVer;

static InterStage interStage;
static Stage stage;
static Title title;

void setup(){
  size(800,800);
  frameRate(60);
  //smooth();
  noStroke();
  background(0);
  
  setSounds();
  setFont();
  bgm.loop();
  stage = new Stage();
  interStage = new InterStage();
  title = new Title();
  setSceneNumber(TITLE_SCENE);
}

void draw(){
  if(sceneNumber == TITLE_SCENE) title.draw();
  else if(sceneNumber == STAGE_SCENE) stage.draw();
  else if(sceneNumber == INTER_STAGE_SCENE) interStage.draw();
}

void setSceneNumber(int number){
  sceneNumber = number;
  
  if(sceneNumber == TITLE_SCENE){
    title.setup();
  }
  
  else if(sceneNumber == STAGE_SCENE){
    stage.setup(stageLevel);
  }
  else if(sceneNumber == INTER_STAGE_SCENE){
    interStage.setup();
  }
}

void mousePressed(){
  if(sceneNumber == TITLE_SCENE) title.mousePressed();
  else if(sceneNumber == STAGE_SCENE) stage.mousePressed();
  else if(sceneNumber == INTER_STAGE_SCENE) interStage.mousePressed();
}

void keyPressed(){
  if(sceneNumber == TITLE_SCENE){}// title.keyPressed();
  else if(sceneNumber == STAGE_SCENE) stage.keyPressed();
  else if(sceneNumber == INTER_STAGE_SCENE){}// interStage.mousePressed(); 
}
  