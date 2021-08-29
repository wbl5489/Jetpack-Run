class Player {

  PVector pos;
  int size;
  float fuel=50;
  float gravity = 1000;
  float velocity ; // = 0;
  //  float acc;
  float jumpVel = 375;
  float onAirJump = 605;
  Boolean getSheild=false;
  Boolean getEnergy=false;
  boolean grounded = false ;
  int level;
  PImage player_;


  Player() {
    pos = new PVector(width/10, 0);
    size = min(width, height)/15;
    player_=player;
  }

  void onReady() {
    velocity = 0;
    pos.y = 0;
  }
  void display() {

    pushStyle();
    stroke(0);
    fill(0);
    if (getSheild==true) {
      image(Shield, pos.x-10, pos.y-10, 100, 100);
    }
    if (mousePressed||keyPressed) {
      jetpack.play();
      player_=player;
      image(player_, pos.x, pos.y, size+10, size+10);
    } else if ((!mousePressed||!keyPressed)&& grounded==true) {

      jetpack.pause();
      jetpack.rewind();
      running.play();
      image(Running[count], pos.x, pos.y, size+10, size+10);
    } else if ((!mousePressed||!keyPressed)&&!grounded) {
      jetpack.pause();
      jetpack.rewind();
      running.pause();
      running.rewind();
      player_=player2;
      image(player_, pos.x, pos.y, size+10, size+10);
    }

    popStyle();
  }

  //gravity
  void update() {
    velocity += gravity/frameRate ;
    pos.y += velocity/frameRate ;
    if (grounded) {
      velocity = 0;
      pos.y += 0;
    }
  }

  void run() {

    update();
    jump();
    display();
    showfuel();
  }
  void showfuel() {

    pushStyle();
    fill(255);
    textSize(30);
    text("FUEL:" + round(fuel), 70, 135);
    if ((!keyPressed || !mousePressed) && fuel < 50  ) {
      fuel += 0.35;
    }

    noFill();
    stroke(255);
    strokeWeight(3);

    rect( 89, 8, 30, 102);
    color c1 = color(0, 255, 0);
    color c2 = color(255, 0, 0);
    noStroke();
    fill(lerpColor(c2, c1, fuel / 60));
    rect( 90, 109, 28, -fuel * 2);
    popStyle();
  }


  void jump() {
    if (fuel>0 && pos.y>0 && grounded&&(mousePressed||keyPressed)) {
      fuel += -0.7;
      pos.y += 0;
      velocity =-250;
      //jetpack.rewind();
    } else if (fuel>0 && pos.y>0 && !grounded&&(mousePressed||keyPressed)) {
      fuel += -0.7;
      //pos.y += 0;
      velocity +=-16;
      // jetpack.rewind();
    } else if (pos.y<0&&(!mousePressed||!keyPressed)) {
      pos.y =0;
      velocity =-0;
    }
  }
}
