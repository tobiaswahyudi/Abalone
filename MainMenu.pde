class Menu{
  float mouseAngleThreshold = 0.4;
  float YPos = 350;
  float BoardRad = 200;
  float HolesRad = 80;
  float HolesDist = 100;
  
  /* To preserve the 0.4 Threshold,
   the 0.8 radius-to-distance ratio must also be preserved. */
  
  ArrayList<Float> starts;
  
  void setup(){
    starts = generateStarts(0.4);
  }
  
  void draw(){
    int dir = hexDirection(400,YPos,0.4);
    float stAngle = starts.get(dir);
    float spAngle = stAngle;
    if(dir != 0) spAngle += 2*mouseAngleThreshold;
    textAlign(CENTER);
    gradientCircle(400,YPos,450,YPos,lightTan,tan,stAngle,spAngle);
    fill(0);
    textSize(60);
    text("Abalone Minimax",width/2, 150);
    textSize(20);
    text(dir,width/2, 200);
    fill(gray);
    ellipse(width/2,YPos,BoardRad,BoardRad);
    fill(white);
    ellipse(width/2,YPos,85,85);
    
    fill(tan);
    if(dir == 4) fill(lightTan);
    ellipse(width/2-HolesDist,YPos,HolesRad,HolesRad);
    
    fill(tan);
    if(dir == 1) fill(lightTan);
    ellipse(width/2+HolesDist,YPos,HolesRad,HolesRad);
    
    fill(tan);
    if(dir == 3) fill(lightTan);
    ellipse(width/2-50,YPos+(HolesDist*sin(PI/3)),HolesRad,HolesRad);
    
    fill(tan);
    if(dir == 2) fill(lightTan);
    ellipse(width/2+50,YPos+(HolesDist*sin(PI/3)),HolesRad,HolesRad);
    
    fill(tan);
    if(dir == 5) fill(lightTan);
    ellipse(width/2-50,YPos-(HolesDist*sin(PI/3)),HolesRad,HolesRad);
    
    fill(tan);
    if(dir == 6) fill(lightTan);
    ellipse(width/2+50,YPos-(HolesDist*sin(PI/3)),HolesRad,HolesRad);
  }
}
