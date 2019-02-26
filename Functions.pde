class pair{
  float x,y;
  pair(float a, float b){
    x = a;
    y = b;
  }
  
  pair min(){
    return new pair(-x,-y);
  }
  
  pair mult(float val){
    return new pair(x*val,y*val);
  }
}

float gapSize(float thresh){
  return (PI/3) - 2*thresh;
}

/* Enumerates 6 directions: 60,0,300,120,180,240 degrees in order
    0 is x+, and positives are clockwise
    returns the index of the angle if within threshold, 0 otherwise
    !! thresh strictly less than PI/6 !!
*/

int hexDirection (float xpos, float ypos, float thresh){
    float a = thresh;
    float b = gapSize(a);
    float angle = atan2(mouseY-ypos, mouseX-xpos);
    
    if(-a < angle  && angle < a) return 2;
    if(a+b < angle  && angle < 3*a+b) return 3;
    if(3*a+2*b < angle  && angle < 5*a+2*b) return 6;
    if(-a-b > angle  && angle > -3*a-b) return 1;
    if(-3*a-2*b > angle  && angle > -5*a-2*b) return 4;
    if(-5*a-3*b > angle  || angle > 5*a+3*b) return 5;
    return 0;
}

float hexAngle(int dir){
  if(dir > 3) return PI+hexAngle(7-dir);
  if(dir == 1) return PI/3;
  if(dir == 2) return 0.0;
  if(dir == 3) return -PI/3;
  //shut up processing
  return 0.0;
}

ArrayList generateStarts(float thresh){
    float a = thresh;
    float b = gapSize(a);
    ArrayList<Float> ar = new ArrayList<Float>();
    ar.add(0.0);
    ar.add(-3*a-b); // 1
    ar.add(-a); // 2
    ar.add(a+b); // 3
    ar.add(-5*a-2*b); // 4
    ar.add(5*a+3*b); // 5
    ar.add(3*a+2*b); // 6
    return ar;
}

PGraphics gradientCircle (float xpos, float ypos, float rad, float thresh,
                          color in, color out, float start, float stop){
  PGraphics image = createGraphics(width,height);
  image.beginDraw();
  float now = rad;
  while(now > thresh){
    fill(lerpColor(in,out,(now-thresh)/(rad-thresh)));
    arc(xpos,ypos,now,now,start,stop,PIE);
    now -= 1;
  }
  image.endDraw();
  return image;
}

float sqr(float a){ return a*a; }

float mouseDist(float xpos, float ypos){
  return sqrt(sqr(xpos - mouseX) + sqr(ypos - mouseY));
}

pair dirDisplacement(int dir){
  //println("dir :",dir);
  float x,y;
  if(dir <= 0 || dir > 6) return new pair(0,0);
  if(dir > 3){
    return dirDisplacement(7-dir).min();
  } else {
    x = 1.0 - (dir%2)*0.5;
    //println(dir%2," ",x);
    y = (dir-2)*sin(PI/3);
    //println(dir-2," ",y);
  }
  return new pair(x,y);
}

float clamp(float val, float mn, float mx){
  return min(mx, max(val, mn));
}
