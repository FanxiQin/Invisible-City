// revised from https://www.openprocessing.org/sketch/91584

import java.util.Iterator;

ArrayList<Part> parts;
float w = 500;
float h = 500;
PVector g = new PVector(0, .2);

float noiseoff=0;
//GifMaker gifExport;
color bgc = #000000;
final static color[] cols = {
  #ff5500, #bf08ba, #5b9a00, #0089fd
};

int beat; int interval;
int i = 67;

Table table;
Point[] arPoints;

Float ex;

void setup() {
  size(1000,780);
  smooth();
  background(bgc);
  frameRate(24);
  parts = new ArrayList();
  //  gifExport = new GifMaker(this, "export.gif");
  //  gifExport.setRepeat(0);  
  //createParticles();
  
  beat = 0;
  interval = 5;
  
  populateArrayFromTable();
}
Part paint(float x, float y, float dx, float dy, float size, Part parent, boolean bymouse) {
  float tx = x;
  float ty = y;

  float t=15+random(20);
  
  color c = cols[(int)random(cols.length)]; 
  Part p = new Part(tx, ty, size, c);
  if (!bymouse) {
    p.c=parent.c;
  }

  p.velocity.x=0;
  p.velocity.y=0;
  
  if (dy == 0 && dx == 0) {
     dx=random(1)-.5; 
     dy=random(1)-.5;
  }
  p.acceleration.x=dx;
  p.acceleration.y=dy; 
  p.or_a.x = dx;
  p.or_a.y = dy;
  p.par=parent;
  //  p.acceleration.mult(-.5);
    
  parts.add(p);
  return p;
}
int fr = 0;
Part lastp=null;

void draw() {
  noStroke();
  fill(bgc, 125);
  rectMode(CORNER);
  rect(0, 0, width, height);
  //background(bgc);
  
  if(beat%interval == 0){    
    if(i < 134){
      arPoints[i].checkRecord();
      i++;
    }
    if(i >= 134){  
      lastp=null;      
    }
  }
  updateParticles();
  beat++;
}




void populateArrayFromTable(){
  table = loadTable("2017-3-12-11-41-21-Kat.csv","header");
  arPoints = new Point[table.getRowCount()];
  
  for(int i = 67; i < 134; i++){
    ex = table.getRow(i).getFloat("excitement");
    arPoints[i] = new Point(ex);

  }
}  

void rotate2D(PVector v, float theta) {
  float xTemp = v.x;
  v.x = v.x*cos(theta) - v.y*sin(theta);
  v.y = xTemp*sin(theta) + v.y*cos(theta);
}

void updateParticles() {
  if (parts.size()>0) {
    noiseoff+=.1;
    int s = parts.size()-1;
    //PVector prevpos = parts.get(parts.size()-1).position;
    for (int m = s; m >= 0; m--) {
      Part p = (Part) parts.get(m);      
      p.update();

      //      prevpos = p.position;
      //p.render();
      if (p.life<0) {
        parts.remove(p);
      }    
      if (p.life<.85 && p.spawned<25 && parts.size()<650 && p.life>.5) {
        p.spawned++;
        if (random(1)>.85) {
          //paint(p.position.x, p.position.y, random(10)-5, random(10)-5, random(5)-2, p);
          PVector dir = p.or_a;
          dir.normalize();
          rotate2D(dir, radians(random(45)-22.5));
          
          dir.mult(5);
          Part np = paint(p.position.x, p.position.y,dir.x, dir.y, p.size*.85, p, false);
          np.spawned=p.spawned;
        }
      }
      stroke(p.c, 5+p.life*255);
     // strokeWeight(noise(i+noiseoff)*3);
      //line(p.position.x, p.position.y, par.x, prevpos.y);
      if (p.par!=null) {
        line(p.position.x, p.position.y, p.par.position.x, p.par.position.y);
      }
      p.render();
    }
  
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("images/screen_#####.png");
  }

  if (key == 'a') {
    background(bgc);
    parts = new ArrayList();

    //createParticles();
  }
}