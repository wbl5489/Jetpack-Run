

class Item {

  PVector pos;
  float w, h;
  float a_;
  float velocity;
  Boolean getShield=false;
  Boolean getEnergy=false;
  color fill_, stroke_;
  int id;

  Item(float x, float y, float w_, float v, float a  ) {

    pos = new PVector(x, y);  
    w = w_;
    h = w_;
    velocity = v;
    a_=a;
  }

  void display() {

    if (a_<0.85) {
      getEnergy=true;
      image(Energy, pos.x-20, pos.y-20, 80, 80);
    } else  if (a_>0.85) {
      getShield=true;
      image(Shield, pos.x-20, pos.y-20, 80, 80);
    }
  }

  void update() {

    pos.x -= velocity/frameRate ;
  }

  void run() {

    update();
    display();
  }
}
