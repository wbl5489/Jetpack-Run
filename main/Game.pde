class Game {

  Engine e;
  int seen ;
  int score ;
  int highScore;
  int time;
  Game() {
    e = new Engine();
    seen = 0;
    highScore = 0;
  }

  void play() {
    if (seen==0) {
      //strartscren
      startScreen();
    } else if (seen == 1) {
      //install
      score = 0;
      e.clear();
      e.start();

      seen = 2;
    } else if (seen == 2) {
      e.run();
      audioPlayer.play();
      //Score
      fill(255);
      textSize(42);
      text("Score: "+(int)score, 8*width/10, height / 10 );
      text("Frame: "+(int)frameRate, 8*width/10, height / 15 );
      //text("Time: "+(int)millis()/1000, 8*width/10, height / 7 );
      //  text("ShieldGetTime: "+(int)System.currentTimeMillis(),8*width/10, height / 30 );
      score ++;
      //Player fall game over
      if (e.p.pos.y > height) {
        seen = 3;
      }
      //display shield remain
      if (g.e.p.getSheild==false) {
        noshieldtime=millis();
      } else {
        totaltime=millis()-noshieldtime;
        text("Shield Remains: "+(8-((int)totaltime/1000)), 3*width/10, height / 30 );
        if(totaltime>=8000){
        g.e.p.getSheild=false;
        }
      }
      // mountain collision
      for (int i = 0; i < e.b.size(); i++) {
        Building bl = e.b.get(i);
        if (isBetween( e.p.pos.x, bl.pos.x, bl.pos.x + bl.w) || isBetween( e.p.pos.x + e.p.size, bl.pos.x, bl.pos.x + bl.w)  ) {
          if (e.p.pos.x+e.p.size>bl.pos.x+10 &&  e.p.pos.y+e.p.size>bl.pos.y+20) {
            hit.rewind();
            hit.play();
            seen=3;
            break;
          } else {
            continue;
          }
        }
      }
      // rock collision
      for (int j = 0; j < e.block.size(); j++) {
        blocks bl1 = e.block.get(j);
        if (isBetween( e.p.pos.x, bl1.pos.x-bl1.w, bl1.pos.x + bl1.w) || isBetween( e.p.pos.x + e.p.size, bl1.pos.x-bl1.w, bl1.pos.x + bl1.w)  ) {
          if ( e.p.pos.x+e.p.size>bl1.pos.x&&e.p.pos.y+e.p.size/2>bl1.pos.y-e.p.size/2&& e.p.pos.y+e.p.size/2<bl1.pos.y+bl1.w+e.p.size/2&&e.p.getSheild==false ) {
            hit.rewind();
            hit.play();
            seen=3;

          } else if (e.p.getSheild==true) {
            seen=2;
          }

        }
      }
       // item collision
      for (int k = 0; k < e.item.size(); k++) {
        Item it = e.item.get(k);
        if (isBetween( e.p.pos.x, it.pos.x-it.w, it.pos.x + it.w) || isBetween( e.p.pos.x + e.p.size, it.pos.x-it.w, it.pos.x + it.w)  ) {
          if ( e.p.pos.x+e.p.size>it.pos.x ) {
            if (e.p.pos.y+e.p.size/2>it.pos.y-e.p.size/2&& e.p.pos.y+e.p.size/2<it.pos.y+it.w+e.p.size/2) {
               menu.rewind();
               menu.play();
              if (it.a_>0.85) {
                time=millis()/1000;
                e.p.getSheild=true;
              }
              if (it.a_<0.85) {
                e.p.fuel=50;
              }
              // break;
            }
          }
        }
      }
    } else if (seen == 3) {
      //end screen;
      endScreen();
    }
  }

  void startScreen() {
    
    
    fill(255, 255, 0);
    stroke(0, 255, 0);
    ellipse(width/2, height/2, height/2.5, height/2.5);
    textSize(80); 
    fill(255, 255, 255);
    text("JetPack Run", width/2, 00 + 90 ); 
    textSize(30); 
    fill(255, 255, 255);
    text("How to play\nPress any key to make spaceman rise\nIf you hit the rocks or the left side of terrain,\nGame Over\n Pick up the items to get power!\nShield:Immuse the rock hit\nEnergy Pack:Charge your Jetpack\nFrameRate Recommendation:110\n", width/5, height/2 ); 
   
    stroke(0, 255, 0);
    fill(0, 255, 0);
    triangle(width/2 - 30, height/2 + 30, width/2 -30, height/2 -30, width/2 +30, height/2);

    if ( dist(mouseX, mouseY, width/2, height/2) < height/5 ) {
      stroke(0, 255, 0);
      fill(0, 0, 100);
      ellipse(width/2, height/2, height/2.5, height/2.5);

      stroke(0, 255, 0);
      fill(0, 255, 0);
      triangle(width/2 - 30, height/2 + 30, width/2 -30, height/2 -30, width/2 +30, height/2);

      if (mousePressed)
        seen = 1;
    }
  }

  void endScreen() {
    highScore = max(highScore, score);
    e.run();
    noStroke();
    pushStyle();
    textSize(60); 
    fill(255, 255, 255);
    text("Game Over", width/2, 00 + 90 ); 
    popStyle();
    fill(255, 255, 100, 80);    
    rect(0, 0, width, height);
    fill(255, 255, 255);
    text("Current Score "+score, width/2, height - 90 ); 
    text("High Score "+highScore, width/2, height - 50 ); 

    fill(255, 255, 0);
    stroke(0, 255, 0);
    ellipse(width/2, height/2 - 20, height/2.5, height/2.5);

    stroke(0, 255, 0);
    fill(0, 255, 0);
    triangle(width/2 - 30, height/2 + 30 -20, width/2 -30, height/2 -30 -20, width/2 +30, height/2-20);

    if ( dist(mouseX, mouseY, width/2, height/2-20) < height/5 ) {
      stroke(0, 255, 0);
      fill(0, 0, 100);
      ellipse(width/2, height/2-20, height/2.5, height/2.5);

      stroke(0, 255, 0);
      fill(0, 255, 0);
      triangle(width/2 - 30, height/2 + 30-20, width/2 -30, height/2 -30-20, width/2 +30, height/2-20);

      if (mousePressed)
        seen = 1;
      e.p.fuel=50;
      audioPlayer.rewind();
      e.p.getEnergy=false;
      e.p.getSheild=false;
    }
  }
}
