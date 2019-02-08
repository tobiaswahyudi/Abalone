float gapSize(float thresh){
  return (PI/3) - 2*thresh;
}

/* Enumerates 6 directions: 0,60,120,180,240,300 degrees in order
    0 is x+, and positives are clockwise
    returns the index of the angle if within threshold, 0 otherwise
    !! thresh strictly less than PI/6 !!
*/

int hexDirection (float xpos, float ypos, float thresh){
    float a = thresh;
    float b = gapSize(a);
    float angle = atan2(mouseY-ypos, mouseX-xpos);
    
    if(-a < angle  && angle < a) return 1;
    if(a+b < angle  && angle < 3*a+b) return 2;
    if(3*a+2*b < angle  && angle < 5*a+2*b) return 3;
    if(-a-b > angle  && angle > -3*a-b) return 6;
    if(-3*a-2*b > angle  && angle > -5*a-2*b) return 5;
    if(-5*a-3*b > angle  || angle > 5*a+3*b) return 4;
    return 0;
}

ArrayList generateStarts(float thresh){
    float a = thresh;
    float b = gapSize(a);
    ArrayList<Float> ar = new ArrayList<Float>();
    ar.add(0.0);
    ar.add(-a);
    ar.add(a+b);
    ar.add(3*a+2*b);
    ar.add(5*a+3*b);
    ar.add(-5*a-2*b);
    ar.add(-3*a-b);
    return ar;
}

PGraphics gradientCircle (float xpos, float ypos, float rad, float thresh, color in, color out, float start, float stop){
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
