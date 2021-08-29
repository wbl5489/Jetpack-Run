int count ;

class blocks{
  
  PVector pos;
  float w,h;
  float a_;
  float velocity;
  
  color fill_ , stroke_;
  int id;
  
  blocks(float x , float y , float w_ ,float v ,float a  ){
    
    pos = new PVector(x,y);  
    w = w_;
    h = w_;
    velocity = v;
    a_=a;
  //  int c = (int)random(0,100);
    fill_ = color(255,100,100);
    stroke_ = color(255,60,100);
    id = ++count ;
  
  }
  
  void display(){

      if(a_>0.5){
       // fill(fill_);
       // stroke(stroke_);
       // rect(pos.x , pos.y ,w,h);
       image(Rock,pos.x-20,pos.y-20,80,80);
      }
          else  if(a_<0.5){
       // fill(fill_);
       // stroke(stroke_);
       // rect(pos.x , pos.y ,w,h);
       image(Rock2,pos.x-20,pos.y-20,80,80);
      }
  }
  
  void update(){
    
     pos.x -= velocity/frameRate ;
  }
  
  void run(){

    update();
    display();
  }

}
