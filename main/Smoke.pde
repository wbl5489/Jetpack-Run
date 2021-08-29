


class Smoke{
  
  PVector pos;
  float w,h;
  float xs,ys;
  float velocity;
  float a=1;
  color fill_ , stroke_;
  int id;
  
  Smoke(float x , float y ,float xs,float ys, float v  ){
    
    pos = new PVector(x,y);  
    w = 10;
    h = 10;
    velocity = v;
    this.xs=xs;
    this.ys=ys;

  }
  
  void display(){
{
    pos.x += xs /2;
    pos.y += this.ys / 2;
    this.ys += 0.03;
    pos.x += -5;

    pushMatrix();
     noStroke();
    fill(random(200,255), random(0,130), random(0,71));
    ellipse(pos.x, pos.y, min(width,height)/15 / 3, min(width,height)/15 / 3);

    popMatrix();
    if (pos.x < 0 || pos.x > width) {
      this.xs *= -0.98;
    }
  }

  if (pos.y > height / 2) {
    this.ys = random(-0.5, 0);
    pos.y -= random(-10, -1);
  }
      //if(pos.x<width){
      //   pushMatrix();

      //  ellipse(pos.x , pos.y ,w,h);
      //  popMatrix();
        
      //}
  
  }
  void update(){
    
     pos.x -= velocity/frameRate ;
  }
  
  void run(){
    update();
    display();
  }

}
