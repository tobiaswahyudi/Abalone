/* #################################
"Abalone" Board Game Minimax Algorithm
Coded by Benedict Tobias H. Wahyudi
in the cold canadian winter of 2019
github.com/tobiaswahyudi
################################# */

Menu M;
color tan = color(255,221,153);
color lightTan = color(255,231,163);
color gray = color(40);
color white = color(255,240,255);
color black = color(3,5,3);

void setup(){
  size(800,600);
  M = new Menu();
  M.setup();
  noStroke();
}

void draw(){
  background(tan);
  M.draw();
}
