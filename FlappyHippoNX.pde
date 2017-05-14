//A Social Lantern Media Creation 2014
//sociallantern.weebly.com

import ddf.minim.*;
import apwidgets.*; 
//the following are all pieces we need to pull in from the android sdk
import android.content.Context;
import android.media.SoundPool; //this is the audio player for short quick audio files
import android.content.res.AssetManager; //the asset manager helps us find specific files and can be used in the style of an array if needed
import android.media.AudioManager; //the audio manager controlls all the audio connected to it, enabeling overall volume and such


//Flappy Code
bird b = new bird();
pillar[] p = new pillar[3];
boolean end=false;
boolean intro=true;
int score=0;
int highscore=0;

int numFrames = 5;

int frame = 0;

PImage[] hippos = new PImage[numFrames];
PImage fbg;
PImage death;

float a; 
float d;
float c;
float e;

APMediaPlayer flap; 
APMediaPlayer deaths;
APMediaPlayer intros;
APMediaPlayer play;



void setup() {
  size(600, 800);
  orientation(PORTRAIT);
  frameRate(45);
  smooth();
  
  for (int i = 0;i<3;i++) {
    p[i]=new pillar(i);
  }
  fbg = loadImage("flappyground.png");
  
  
  intros = new APMediaPlayer(this);
  intros.setMediaFile("intro.mp3");
  play = new APMediaPlayer(this);
  play.setMediaFile("play.mp3");
 flap = new APMediaPlayer(this);
 flap.setMediaFile("flap.mp3");
 deaths = new APMediaPlayer(this);
 deaths.setMediaFile("death.mp3");
  
  death = loadImage("death.png"); 
  for (int h=0; h<numFrames; h++) {
    String imageName = "hippostart" + nf(h,4) + ".png";
    hippos[h] = loadImage(imageName);
    
  }
    

  a = -100;
  d= 400;
  c= 200;
  e = -50;
  
  
  
}

public void onResume() {
  super.onResume();
  
}

public void onPause() {
 
  super.onPause();
}

public void onDestroy() {





  super.onDestroy(); //call onDestroy on super class


 if (intros!=null) { //must be checked because or else crash when return from landscape mode

    intros.release(); //release the player
  }
  if (play!=null) { //must be checked because or else crash when return from landscape mode

    play.release(); //release the player
  }
  if (deaths!=null) { //must be checked because or else crash when return from landscape mode

    deaths.release(); //release the player
 }
  if (flap!=null) { //must be checked because or else crash when return from landscape mode

    flap.release(); //release the player
  }
}


void draw() {
 background(fbg);

  //Clouds//

  a = a+1.1;
  d = d+0.2;
  c = c+ 0.6;
  e = e+0.9;

  if (a > width+150) {
    a = -200;
  }

  if (d > width+100) {
    d = -100;
  }

  if (c > width+100) {
    c = -100;
  }

  if (e > width+250) {
    e = -250;
  }

  noStroke();

  //Cloud 1//
  strokeWeight(5);
  stroke(241, 250, 184);
  fill(254, 206, 168);
  rect(a+50, 30, 90, 50, 10);
  strokeWeight(5);
  stroke(241, 250, 184);
  fill(254, 206, 168);
  rect(a-10, 30, 130, 60, 10);
  strokeWeight(5);
  stroke(241, 250, 184);
  fill(254, 206, 168);
  rect(a+20, 70, 80, 80, 10); 

  //Cloud 2//
  strokeWeight(5);
  stroke(241, 250, 184);
  fill(254, 206, 168);
  rect(d-10, 410, 60, 70, 10); 
  strokeWeight(5);
  stroke(241, 250, 184);
  fill(254, 206, 168);
  rect(d+30, 360, 70, 30, 10); 
  strokeWeight(5);
  stroke(241, 250, 184);
  fill(254, 206, 168);
  rect(d-60, 390, 70, 60, 10); 


  //Cloud 3//
  strokeWeight(5);
  stroke(241, 250, 184);
  fill(254, 206, 168);
  strokeWeight(5);
  stroke(241, 250, 184);
  rect(c-20, 330, 80, 60, 10);
  strokeWeight(5);
  stroke(241, 250, 184);
  fill(254, 206, 168);
  rect(c+15, 270, 60, 30, 10);
  strokeWeight(5);
  stroke(241, 250, 184);
  fill(254, 206, 168);
  rect(c-20, 290, 40, 60, 10); 


  //Cloud 4//
  strokeWeight(5);
  stroke(241, 250, 184);
  fill(254, 206, 168);
  rect(e-10, 550, 110, 110, 10); 
  strokeWeight(5);
  stroke(241, 250, 184);
  fill(254, 206, 168);
  rect(e+140, 570, 90, 50, 10);
  strokeWeight(5);
  stroke(241, 250, 184);
  fill(254, 206, 168);
  rect(e+170, 580, 40, 60, 10); 
  strokeWeight(5);
  stroke(241, 250, 184);
  fill(254, 206, 168);
  rect(e+150, 550, 60, 40, 10);

  strokeWeight(5);
  stroke(241, 250, 184);
  fill(254, 206, 168);
  rect(e+50, 560, 70, 70, 10);
  strokeWeight(5);
  stroke(241, 250, 184);
  fill(254, 206, 168);
  rect(e-90, 490, 50, 30, 10); 

  frame = (frame+1)%numFrames;
   // Use % to cycle through frames

    if (end) {
    b.move();
  }
  b.drawBird();
  if (end) {
    b.drag();
  }
  b.checkCollisions();
  for (int i = 0;i<3;i++) {
    p[i].drawPillar();
    p[i].checkPosition();
  }
  fill(18, 122, 151);
  strokeWeight(2);
  stroke(191, 12, 67);
  textSize(32);
  if (end) {
    rect(20, 20, 100, 50);
    fill(255);
    text(score, 30, 58);
    
    //intros.setLooping(false); 
    //intros.seekTo(0);
    intros.setVolume(0.0, 0.0);
    
    play.setVolume(1.0, 1.0);
    play.setLooping(true); 
    play.start();
    
  }
  else {
    fill(142, 172, 0);
    rect(150, 200, 235, 50);
    rect(170, 300, 235, 50);
    rect(200, 400, 255, 50);

    fill(249, 186, 21);
    if (intro) {
      text("Flappy Hippo", 165, 240);
      text("Tap to Play", 185, 340);
      fill(176,17,188);
      text(" High Score: "+highscore, 215,440);
      
      textSize(24);
      fill(255,10,10);
       text("Made by - Social Lantern Media", 125, 610);
       fill(248,252,5);
       text("How to Play ?", 135, 550);
       fill(255);
       text("Tap and Avoid the Rainbow Spikes.", 135, 580);
       
       //play.setLooping(false); 
       //play.seekTo(0);
       play.setVolume(0.0,0.0);
        intros.setLooping(true);  
       intros.setVolume(1.0, 1.0);
      
       intros.start();
       
     
    }
    else {
      
      text(" Game Over ", 170, 240);
      text(" Score:  ", 180, 340);
      text("Highest: ", 220,440);
      fill(69, 43, 114);
      
      text(score+" pts", 302, 340);
      text(highscore+" pts", 352, 440);
    }
  }
  if (score >= highscore) highscore = score;
}
class bird {
  float xPos, yPos, ySpeed;
  bird() {
    xPos = 190;
    yPos = 70;
  }
  void drawBird() {
    stroke(255);
    noFill();
    strokeWeight(2);
    image(hippos[frame], xPos, yPos, 75, 75);
   
  }
  void jump() {
    flap.seekTo(0);
  flap.start();
    ySpeed=-9;
  }
  void drag() {
    ySpeed+=0.4;
  }
  void move() {
    yPos+=ySpeed;
    for (int i = 0;i<3;i++) {
      p[i].xPos-=3;
    }
  }
  void checkCollisions() {
    if (yPos>900) {
     // play.seekTo(0);
       //deaths.seekTo(0);
       deaths.start();
       noLoop();
      end=false;
    }
    for (int i = 0;i<3;i++) {
      if ((xPos<p[i].xPos+10&&xPos>p[i].xPos-10)&&(yPos<p[i].opening-220||yPos>p[i].opening+220)) {
      // play.seekTo(0);
       // deaths.seekTo(0);
       deaths.start(); 
       noLoop();
        image(death, xPos-10, yPos-10, 135, 135);
         end=false;
      }
    }
  }
}
class pillar {
  float xPos, opening;
  boolean cashed = false;
  pillar(int i) {
    xPos = 100+(i*200);
    opening = random(700)+100;
  }


  void drawPillar() {

   //  strokeWeight(1);
   // stroke(142,236,185);  
    //rect(xPos, 0, xPos, opening-100); 
    stroke(191, 12, 67);
    strokeWeight(9);
    line(xPos+5, 0, xPos, opening-200); 
    stroke(249, 186, 21);
    line(xPos+10, 0+5, xPos, opening-200); 
    stroke(142, 172, 0);
    line(xPos+15, 0+10, xPos, opening-200); 
    stroke(18, 122, 151);
    line(xPos+20, 0+15, xPos, opening-200); 
    stroke(69, 43, 114);
    line(xPos+25, 0+20, xPos, opening-200); 


    // strokeWeight(1);
   // stroke(142,236,185);    
   // rect(xPos, opening+100, xPos, 600);
    strokeWeight(9);
    stroke(69, 43, 114);
    line(xPos+5, opening+200, xPos, 700);
    stroke(18, 122, 151);
    line(xPos+10, opening+200, xPos, 700);
    stroke(142, 172, 0);
    line(xPos+15, opening+200, xPos, 700);
    stroke(249, 186, 21);
    line(xPos+20, opening+200, xPos, 700);
    stroke(191, 12, 67);
    line(xPos+25, opening+200, xPos, 700);
  }
  void checkPosition() {
    if (xPos<0) {
      xPos+=(200*3);
      opening = random(700)+100;
      cashed=false;
     
    }
    if (xPos<300&&cashed==false) {
      cashed=true;
      score++;
    }
  }
}
void reset() {
  //intro = true;
  end=true;
  score= 0;
  b.yPos=512;
  for (int i = 0;i<3;i++) {
    p[i].xPos+=300;
    p[i].cashed = false;
  }
}
void mousePressed() {
  
  b.jump();
  
  intro=false;
  if (end==false) {
    //deaths.start();
    loop(); 
    reset();
  }
}
void keyPressed() {
 
  b.jump();
   
  intro=false;
  if (end==false) {
    loop(); 
    reset();
  }
}



