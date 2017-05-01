// number of particles
final static int N = 500;
 
// colors (some of them taken from http://www.colourlovers.com/pattern/5526827/bleak
final static color[] cols = { 
  #ff5500, #bf08ba, #5b9a00, #0089fd
};
 
// collection of all particles
ArrayList<Particle> particles = new ArrayList<Particle>(N);
 
void setup() {
  size(800, 800);
  noFill();
  smooth(8);
  strokeWeight(0.7);
  background(0, 0, 0);
 
  // initialize particles
  for (int i=0; i<N; i++) {
    particles.add( new Particle(i) );
  }
}

float time = 0.0;
void draw() {
  for (Particle p : particles) {
 
    // love/hate vector
    float lovex = 0.0;
    float lovey = 0.0;
 
    for (Particle o : particles) {
      // do not compare with yourself
      if (p.id != o.id) {
        // calculate vector to get distance and direction
        PVector v = new PVector(o.x-p.x, o.y-p.y);
        float distance = v.mag();
        float angle = v.heading();
 
        // love!
        float love = 1.0 / distance;
        // or hate...
        if (distance<2.0) love = -love;
 
        // mood factor
        love *= p.moodSimilarity(o);
        // not too fast!
        love *= 1;
 
        // update love vector
        lovex += love * cos(angle);
        lovey += love * sin(angle);
      } 
      
      // calculated love vector will be our speed in resultant direction
      p.dx = lovex;
      p.dy = lovey;
    }
  }
 
  // update and draw
  for (Particle p : particles) {
    p.update();
    p.draw();
  }
  
  time += 0.001;
}