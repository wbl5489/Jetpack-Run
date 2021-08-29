Game g;

import ddf.minim.*; 
Minim minim;          
AudioPlayer audioPlayer; 
AudioPlayer running; 
AudioPlayer hit; 
AudioPlayer jetpack; 
AudioPlayer menu; 
public static PImage player;
public static PImage player2;
public static PImage Rock;
public static PImage Rock2;
public static PImage Terrain;
public static PImage Energy;
public static PImage Shield;

public static PImage[] Running;

Star[] stars = new Star[300];
int noshieldtime;
int totaltime;
float speed;

void setup(){

int count =0;
minim=new Minim(this);
audioPlayer = minim.loadFile("bgm.mp3");
running=minim.loadFile("running.mp3");
hit=minim.loadFile("hit.mp3");
menu=minim.loadFile("menu_select.mp3");
jetpack=minim.loadFile("jetpack1.mp3");
Running =new PImage[3];
player = loadImage("flying1.png");
player2 = loadImage("flying0.png");
Rock = loadImage("rock.png");
Rock2 = loadImage("rock2.png");
Terrain = loadImage("terrain2.png");
Energy=loadImage("energy.png");
Shield=loadImage("shield.png");
Running[0] = loadImage("running1.png");
Running[1] = loadImage("running2.png");
Running[2] = loadImage("running3.png");
//Running[3] = loadImage("running1.png");
  bid = 0;

  fullScreen();
  colorMode(RGB,255);
  strokeWeight(width/36);
  strokeJoin(ROUND);

  frameRate(1000);

  g = new Game();
  strokeWeight(height/32);
  textAlign(CENTER, CENTER);
  textSize(26); 
  
    for(int i = 0; i < stars.length; i++){
    stars[i] = new Star();
  }
}

void draw(){

  if(frameCount%50==0){
  count++;
  }
  if(count>Running.length-2){
    count =0;
}
    speed=1;
      background(0,0,0);
for(int i = 0; i < stars.length; i++){
    stars[i].update();
    stars[i].show();
  }



g.play();



  

}


boolean isBetween(float x , float l ,float r){
    return ( x>= l && x<=r);
}
