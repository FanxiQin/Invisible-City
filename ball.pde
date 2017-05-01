int Nmax = 1000 ; float M = 50 ; float H = 0.99 ; float HH = 0.01 ;

float X[] = new float[Nmax+1] ; float Y[] = new float[Nmax+1] ; float Z[] = new float[Nmax+1] ;
float V[] = new float[Nmax+1] ; float dV[] = new float[Nmax+1] ; 
float L ; float R = 2*sqrt((4*PI*(200*200)/Nmax)/(2*sqrt(3))) ;
float Lmin ; int N ; int NN ; 
float KX ; float KY ; float KZ ; 
float KV ; float KdV ; int K ;

int beat; int interval; int i = 165;

final static color[] cols = {
  #ff5500, #bf08ba, #5b9a00, #0089fd
};
Table table;
Point[] arPoints;            

void setup(){
  
  size(600,600) ;
  background(0,0,0) ;
  noSmooth() ;
  stroke(255,255,255) ;
  fill(50, 50, 50) ;
  frameRate(24);
  
  beat = 0;
  interval = 8;
  
  for ( N = 0 ; N <= Nmax ; N++ ){
    X[N] = random(-300,+300) ;
    Y[N] = random(-300,+300) ;
    Z[N] = random(-300,+300) ;
  }
  
  populateArrayFromTable();
  
} // setup()

void draw(){
  
  background(0,0,0) ;
  if(beat%interval == 0){      
    arPoints[i].drawR();
  }
  for ( N = 0 ; N <= Nmax ; N++ ){
     for ( NN = N+1 ; NN <= Nmax ; NN++ ){
        L = sqrt(((X[N]-X[NN])*(X[N]-X[NN]))+((Y[N]-Y[NN])*(Y[N]-Y[NN]))) ;
        L = sqrt(((Z[N]-Z[NN])*(Z[N]-Z[NN]))+(L*L)) ;
        if ( L < R ){
          X[N] = X[N] - ((X[NN]-X[N])*((R-L)/(2*L))) ;
          Y[N] = Y[N] - ((Y[NN]-Y[N])*((R-L)/(2*L))) ;
          Z[N] = Z[N] - ((Z[NN]-Z[N])*((R-L)/(2*L))) ;
          X[NN] = X[NN] + ((X[NN]-X[N])*((R-L)/(2*L))) ;
          Y[NN] = Y[NN] + ((Y[NN]-Y[N])*((R-L)/(2*L))) ;
          Z[NN] = Z[NN] + ((Z[NN]-Z[N])*((R-L)/(2*L))) ;
          dV[N] = dV[N] + ((V[NN]-V[N])/M) ;
          dV[NN] = dV[NN] - ((V[NN]-V[N])/M) ;         
          color c = cols[(int)random(cols.length)];
          stroke(c, 125+(Z[N]/2));
          line(X[N]*1.2*(200+V[N])/200+300,Y[N]*1.2*(200+V[N])/200+300,X[NN]*1.2*(200+V[NN])/200+300,Y[NN]*1.2*(200+V[NN])/200+300) ; 
          
      }
        if ( Z[N] > Z[NN] ){
          KX = X[N] ; KY = Y[N] ; KZ = Z[N] ; KV = V[N] ; KdV = dV[N] ; 
          X[N] = X[NN] ; Y[N] = Y[NN] ; Z[N] = Z[NN] ; V[N] = V[NN] ; dV[N] = dV[NN] ;  
          X[NN] = KX ; Y[NN] = KY ; Z[NN] = KZ ; V[NN] = KV ; dV[NN] = KdV ; 
        }
     }
     L = sqrt((X[N]*X[N])+(Y[N]*Y[N])) ;
     L = sqrt((Z[N]*Z[N])+(L*L)) ;
     X[N] = X[N] + (X[N]*(200-L)/(2*L)) ;
     Y[N] = Y[N] + (Y[N]*(200-L)/(2*L)) ;
     Z[N] = Z[N] + (Z[N]*(200-L)/(2*L)) ;
     KZ = Z[N] ; KX = X[N] ;
     
     KZ = Z[N] ; KY = Y[N] ;
     
     dV[N] = dV[N] - (V[N]*HH) ; 
     V[N] = V[N] + dV[N] ; dV[N] = dV[N] * H ;
  }
    if(beat%interval == 0){
       if(i < 227){              
        i++;          
       }
      if(i >=227) exit();
       
  } 
  beat++;
} // draw() 

void populateArrayFromTable(){
  table = loadTable("2017-3-12-11-41-21-Kat.csv","header");
  arPoints = new Point[table.getRowCount()];
  
  for(int i = 165; i < 228; i++){
    Float fr = table.getRow(i).getFloat("frustration");
    arPoints[i] = new Point(fr);

  }
  
     
} 