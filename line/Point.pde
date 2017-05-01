class Point{
  float l;
  Boolean record=false;
  
  Point(float tl){
    l = tl;
  }
  
  void checkRecord(){
    record = false;
    for(float n = 0; n < ex; n++){
      record = true;
    }
    if(record){
      lastp=paint(width/2, height/2, (0)*-.1, (0)*-.1, random(15), lastp, true);    
    }
    else {
      lastp=null;
    }
    
  }
  
}  