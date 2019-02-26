/* #################################
"Abalone" Board Game Minimax Algorithm
Coded by Benedict Tobias H. Wahyudi
in the cold canadian winter of 2019
github.com/tobiaswahyudi
################################# */

Menu M;
Board B;
color tan = color(255,221,153);
color lightTan = color(255,231,163);
color gray = color(40);
color white = color(255,240,255);
color black = color(3,5,3);
color red = color(255,30,30);
color darkRed = color(120,10,10);

boolean whitesMove;

void setup(){
  whitesMove = true;
  size(800,600);
  M = new Menu();
  B = new Board();
  M.setup();
  B.setup();
  noStroke();
}

void draw(){
  background(tan);
  //M.draw();
  B.draw();
}

void mousePressed(){
  //B.selected = B.findClosestBall(mouseX,mouseY);
  if(B.isSelecting){
    B.playerGetEndBalls();
  } else if(B.isWaiting){
    B.moveBalls(false);
  } else {
    B.getStartBall(whitesMove);
  }
    //B.balls.get(B.selected).nudge(hexDirection(B.balls.get(B.selected).posX,B.balls.get(B.selected).posY,PI/6),60);
  //}
  //B.whites.get(6).nudge(1,60);
  //B.whites.get(0).nudge(1,60);
}
