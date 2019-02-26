class Board{
  ArrayList<Ball> balls;
  ArrayList<Integer> selecteds;
  float holeRad,holeDist = 60,ballRad = 55,boardRad;
  
  int[][] field;  
  
  pair dirShift[] = {new pair(0,0), new pair(-1,0), new pair(0,1), new pair(1,1)};
  
  boolean isSelecting;
  boolean isWaiting;
  int selected;
  
  void setup(){
    isSelecting = false;
    field = new int[11][11];
    
    // memset everything with -2.
    for(int i = 0; i < 11; i++) for(int j = 0; j < 11; j++) field[i][j] = -2;
    // memset the playable field with -1.
    for(int i = 1; i < 10; i++) for(int j = 1; j < 10; j++) field[i][j] = -1;
    // now -2 represents an unplayable tile, while -1 represents an empty tile.
    
    balls = new ArrayList<Ball>();
    int cnt = 0;
    for(int i = 0; i < 5; i++){
      balls.add(new Ball(true,width/2 - 2*holeDist + i*holeDist, height/2 + 4*holeDist*sin(PI/3)));
      balls.get(cnt).fieldRow = 9;
      balls.get(cnt).fieldCol = 5+i;
      cnt++;
      field[9][5+i] = i;
    }
    for(int i = 0; i < 6; i++){
      balls.add(new Ball(true,width/2 - 2.5*holeDist + i*holeDist,height/2 + 3*holeDist*sin(PI/3)));
      balls.get(cnt).fieldRow = 8;
      balls.get(cnt).fieldCol = 4+i;
      cnt++;
      field[8][4+i] = 5+i;
    }
    for(int i = 0; i < 3; i++){
      balls.add(new Ball(true,width/2 - 1*holeDist + i*holeDist,height/2 + 2*holeDist*sin(PI/3)));
      balls.get(cnt).fieldRow = 7;
      balls.get(cnt).fieldCol = 5+i;
      cnt++;
      field[7][5+i] = 11+i;
    }
    for(int i = 0; i < 5; i++){
      balls.add(new Ball(false,width/2 - 2*holeDist + i*holeDist,height/2 - 4*holeDist*sin(PI/3)));
      balls.get(cnt).fieldRow = 1;
      balls.get(cnt).fieldCol = 1+i;
      cnt++;
      field[1][1+i] = 14+i;
    }
    for(int i = 0; i < 6; i++){
      balls.add(new Ball(false,width/2 - 2.5*holeDist + i*holeDist,height/2 - 3*holeDist*sin(PI/3)));
      balls.get(cnt).fieldRow = 2;
      balls.get(cnt).fieldCol = 1+i;
      cnt++;
      field[2][1+i] = 19+i;
    }
    for(int i = 0; i < 3; i++){
      balls.add(new Ball(false,width/2 - 1*holeDist + i*holeDist,height/2 - 2*holeDist*sin(PI/3)));
      balls.get(cnt).fieldRow = 3;
      balls.get(cnt).fieldCol = 3+i;
      cnt++;
      field[3][3+i] = 25+i;
    }
  }
  
  pair getDirShift(int dir){
    if(dir > 3) return getDirShift(7-dir).min();
    return dirShift[dir];
  }
  
  int findClosestBall(int posX, int posY){
    //isSelecting = !isSelecting;
    int now = 0;
    float min = width;
    for(int i = 0; i < balls.size(); i++){
      float dst = balls.get(i).getBallDist(posX,posY);
      if(dst < min){
        min = dst;
        now = i;
      }
    }
    return now;
  }
  
  int getNextBall(int ball, int dir){
    println("from ",ball, "dir ", dir);
    pair shift = getDirShift(dir);
    println("shift ",shift.x," ",shift.y);
    Ball B = balls.get(ball);
    return field[B.fieldRow+int(shift.x)][B.fieldCol+int(shift.y)];
  }
  
  boolean getStartBall(boolean whitesTurn){
    selected = findClosestBall(mouseX,mouseY);
    if(balls.get(selected).isWhite == whitesTurn){
      isSelecting = true;
      return true;
    } else {
      return false;
    }
  }
  
  int ballDistance(float posX, float posY){
    // the variable dist maps distances as below:
    // [0 - 0.5) x holeDist -> 0
    // [0.5 - 1.5] x holeDist -> 1
    // >1.5 x holeDist -> 2
    float dist = (mouseDist(posX,posY)) / holeDist;
    dist -= 0.5;
    dist = clamp(ceil(dist),0,2);
    return int(dist);
  }
  
  void getEndBalls(int dir, int dist){
    int now = selected;
    selecteds = new ArrayList<Integer>();
    selecteds.add(now);
    for(int i = 0; i < int(dist); i ++){
      int cur = getNextBall(now,dir);
      println(cur);
      selecteds.add(cur);
      now = cur;
      //sel.nudge(dir,holeDist);
    }
    //pair disp = dirDisplacement(dir).mult(dist*holeDist);
    //stroke(0);
    //line(sel.posX,sel.posY,sel.posX+disp.x,sel.posY+disp.y);
    //noStroke();
    isWaiting = true;
  }
  
  void playerGetEndBalls(){
    isSelecting = false;
    Ball sel = balls.get(selected);
    int dir = hexDirection(sel.posX,sel.posY,atan2(ballRad/2,2*holeDist));
    // the variable dist maps distances as below:
    // [0 - 0.5) x holeDist -> 0
    // [0.5 - 1.5] x holeDist -> 1
    // >1.5 x holeDist -> 2
    int dist = ballDistance(sel.posX,sel.posY);
    getEndBalls(dir,dist);
  }
  
  void drawArrow(pair origin, float len, int dir){
    float wide = 6;
    float arrowHead = 12;
    float bodyRatio = 0.8;
    fill(darkRed);
    float angle = hexAngle(dir);
    pair opposite = new pair(cos(angle)*len,-sin(angle)*len);
    pair head = new pair(-sin(angle),-cos(angle));
    triangle(origin.x,origin.y,
        origin.x+opposite.mult(bodyRatio+0.02).x+head.mult(wide).x,
        origin.y+opposite.mult(bodyRatio+0.02).y+head.mult(wide).y,
        origin.x+opposite.mult(bodyRatio+0.02).x-head.mult(wide).x,
        origin.y+opposite.mult(bodyRatio+0.02).y-head.mult(wide).y);
    triangle(origin.x+opposite.x,origin.y+opposite.y,
        origin.x+opposite.mult(bodyRatio).x+head.mult(arrowHead).x,
        origin.y+opposite.mult(bodyRatio).y+head.mult(arrowHead).y,
        origin.x+opposite.mult(bodyRatio).x-head.mult(arrowHead).x,
        origin.y+opposite.mult(bodyRatio).y-head.mult(arrowHead).y);
  }
  
  void moveBalls(boolean realMove){
    Ball sel = balls.get(selected);
    int dir = hexDirection(sel.posX,sel.posY,atan2(ballRad/2,holeDist));
    if(dir != 0){
      int leader = 0;
      boolean ok = true;
      for(int B : selecteds){
        int nxt = getNextBall(B,dir);
        boolean okeydokey = false;
        if(nxt == -1){
          okeydokey = true;
          leader = B;
        }
        for(int B_Again : selecteds) if(nxt == B_Again) okeydokey = true;
        ok = ok && okeydokey;
      }
      if(ok){
        //hooray we can move
        if(leader == selected){
          //we start from 0
          for(int i = 0; i < selecteds.size(); i++){
            Ball now = balls.get(selecteds.get(i));
            int row = now.fieldRow;
            int col = now.fieldCol;
            pair disp = getDirShift(dir);
            field[row+int(disp.x)][col+int(disp.y)] = selecteds.get(i);
            field[row][col] = -1;
            now.fieldRow += int(disp.x);
            now.fieldCol += int(disp.y);
            now.nudge(dir,holeDist);
          }
        } else {
          //we start from end
          for(int i = selecteds.size()-1; i >= 0; i--){
            Ball now = balls.get(selecteds.get(i));
            int row = now.fieldRow;
            int col = now.fieldCol;
            pair disp = getDirShift(dir);
            field[row+int(disp.x)][col+int(disp.y)] = selecteds.get(i);
            field[row][col] = -1;
            now.fieldRow += int(disp.x);
            now.fieldCol += int(disp.y);
            now.nudge(dir,holeDist);
          }
        }
        whitesMove ^= realMove;
      }
    }
    isWaiting = false;
    isSelecting = false;
  }
  
  void draw(){
    if(isSelecting){
      Ball sel = balls.get(selected);
      sel.outline();
    }
    for(Ball b : balls){
      b.draw();
    }
    if(isWaiting){
      for(int B : selecteds){
        Ball sel = balls.get(B);
        sel.outline();
        sel.draw();
      }
      Ball sel = balls.get(selected);
      int dir = hexDirection(sel.posX,sel.posY,atan2(ballRad/2,2*holeDist));
      if(dir != 0) drawArrow(new pair(sel.posX,sel.posY),holeDist,dir);
      sel.draw();
    }
    for(int i = 1; i <= 9; i++) for(int j = 1; j <= 9; j++){
      if(field[i][j] != -1){
        Ball b = balls.get(field[i][j]);
        fill(color(255,0,0));
        text(field[i][j],b.posX,b.posY);
        text(field[i][j],30*j - 30,12*i);
      }
    }
    
  }
}
