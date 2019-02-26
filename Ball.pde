class Ball{
  boolean isWhite;
  float posX,posY;
  float assx,assy;
  float desX,desY;
  
  int fieldRow,fieldCol;
  
  float zoom = 0.1;
  float rad = 55;
  float outlineRad = 65;
  
  Ball(boolean w, float px, float py){
    isWhite = w;
    desX = posX = px;
    desY = posY = py;
  }
  
  void nudge(int dir, float dist){
    pair dis = dirDisplacement(dir).mult(dist);
    println(dis.x," ",dis.y);
    desX += dis.x;
    desY += dis.y;
  }
  
  float getBallDist(int x, int y){
    return dist(x,y,posX,posY);
  }
  
  void outline(){
    fill(red);
    ellipse(posX,posY,outlineRad,outlineRad);
  }
  
  void draw(){
    if(isWhite) fill(white);
    else fill(black);
    ellipse(posX,posY,rad,rad);
    posX += (desX - posX)*zoom;
    posY += (desY - posY)*zoom;
  }
}
