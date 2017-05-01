class Point{
  float r;
  
  Point(float tr){
    r = tr;
  }
  
  void drawR(){
  Lmin = 600 ; NN = 0 ;
  for ( N = 0 ; N <= Nmax ; N++ ){
     L = sqrt(((width/2-(300+X[N]))*(width/2-(300+X[N])))+((height/2-r-(300+Y[N]))*(height/2-r-(300+Y[N])))) ;
     if ( Z[N] > 0 && L < Lmin ){ NN = N ; Lmin = L ; }
  }
  if ( K == 0 ){ dV[NN] = -200 ; K = 1 ; }
           else{ dV[NN] = +200 ; K = 0 ; } 
}
  
}  