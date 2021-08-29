class Engine {

  Player p;
  ArrayList<Building> b;
  ArrayList<blocks> block;
  ArrayList<Smoke> smoke;
  ArrayList<Item> item;
  float v, a, inv ;
  int minWidth, maxWidth, minHeight = 100, maxHeight = 150 ;
  float midLevel;

  int seen ;

  // chuang jian wanjia he jian zhu 
  Engine() {

    p = new Player();
    b = new ArrayList<Building>();
    block=new ArrayList<blocks>();
    item= new ArrayList<Item>();
    smoke=new ArrayList<Smoke>(5);

    minWidth = 30*p.size/4 ;
    maxWidth = 40*p.size/4 ;

    midLevel = height/2;

    seen = 0 ;

    inv = width/4;
  }


  void start() {

    v = inv;
    a = 3;

    p.onReady();

    addBlock(width, midLevel);
    addBlock();
    addBlock();
    addBlock();
    addBlock();
    addBlock();
    addBlock();
    addBlock();
    addBlock();
    addBlock();
    addBlock();
    addBlock();
    addBlock();
    //addBlock();
    //addBlock();
    //addBlock();

    addBuilding(-10, midLevel, 500);
    addBuilding();
    addBuilding();
    addBuilding();
    addBuilding();
    addBuilding();
    addBuilding();
    float a=random(0, 1);
    item.add(new Item(random(width), random(0, height/2), 40, v, 0.86));
  }

  void run() {

    //thread("AddTerrain");
    // thread("AddBlock");

    //add moutain

    int l =b.size();
    for (int i = 0; i < l; i++ ) {
      Building bl =b.get(i);

      bl.run();

      if (bl.pos.x + bl.w < -500) {
        addBuilding();
        b.remove(i);
      }
    }

    //add rocks
    int n= block.size();

    for (int j = 0; j< n; j++ ) {
      blocks bl1 = block.get(j);

      bl1.run();

      if (bl1.pos.x + bl1.w < -500) {
        addBlock();
        block.remove(j);
      }
    }

    //add items
    int m= item.size();

    for (int k = 0; k< m; k++ ) {

      Item it = item.get(k);

      it.run();

      if (it.pos.x + it.w < -500) {
        addItem();
        item.remove(k);
      }
    }

    //AddTerrain();

    if (mousePressed||keyPressed) {

      createsmoke();
      for (int i = 0; i < smoke.size(); i++ ) {
        Smoke sm = smoke.get(i);

        sm.run();
      }
    } else {
      for (int i = 0; i < smoke.size(); i++ ) {
        Smoke sm = smoke.get(i);
        sm.run();
        smoke.remove(i);
      }
    }
    collision();
    p.run();

    if (p.pos.y > height ) {
      seen = 2;
    }


    //acceralrate
    v += a/frameRate;
  }



  void clear() {
    b.clear();
    block.clear();
    smoke.clear();
    item.clear();
  }

  
  void collision() {
    boolean flag = true;
    int l = b.size();

    for (int i = 0; i < l; i++) {

      Building bl = b.get(i);

      float px = p.pos.x;
      float py = p.pos.y;
      float pw = p.size;

      float bx = bl.pos.x;
      float by = bl.pos.y;
      float bw = bl.w;

      if (isBetween( px, bx, bx + bw) || isBetween( px + pw, bx, bx + bw)  ) {
        //Building is in scop
        if (isBetween(py+pw, by, by+20 )) {
          p.grounded = true;
          p.pos.y = by - pw ;
          flag = false;
          break;
        }
      } else {
        //building is not in scop
        continue ;
      }
    }//end of collision loop

    if (flag) {
      p.grounded = false;
    }
  }


  void addBuilding() {

    float x = b.get(b.size() -1).pos.x + random( 5*p.size + sqrt(v), 9*p.size + sqrt(v)+10 )+30;
    // float x= width;
    float y = random(height/2, height - 80);
    float w = random( 30*p.size/4 + sqrt(v), 40*p.size/4 + sqrt(v)  );

    b.add(new Building(x, y, w, v));
  }

  void addBuilding(float x, float y, float w) {
    b.add(new Building(x, y, w, v));
  }

  void addBlock(float x, float y) {
    block.add(new blocks(x, y, 40, v, random(0, 1)));
  }
  void addBlock() {
    float a=random(0, 1);
    float w =40;
    float x =random(block.get(block.size()-1).pos.x +100, block.get(block.size()-1).pos.x +200)+100;
    // float x= width;
    float y1 = random(p.size+10, height*3/4);
    block.add(new blocks(x, y1, w, v, a));
  }

  void addItem() {
    float a=random(0, 1);
    float w =40;
    // float a =b.get(b.size() -1).pos.x + random( 5*p.size + sqrt(v) , 9*p.size + sqrt(v)+10);
    float x =random(block.get(block.size()-1).pos.x +width*3/4, block.get(block.size()-1).pos.x +width)+100;
    // float x= width;
    float y1 = random(p.size+10, height/2);
    item.add(new Item(x, y1, w, v, a));
  }

  void createsmoke() {

    smoke.add(new Smoke(p.pos.x+p.size/4, p.pos.y+p.size, random(-1, 1), random(3), v));
  }
}
