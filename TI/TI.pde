Calculator calc;
char bgState;
PImage sinful, cosmic, tanned;
color defaultColor;
String[][] caps;

void setup(){
  calc = new Calculator();
  caps = new String[][]
  {{"Rad", "Deg", "x!", "(", ")", "%", "CE"},
   {"Inv", "sin", "ln", "7", "8", "9", "÷"},
   {"π", "cos", "log", "4", "5", "6", "×"},
   {"e", "tan", "√", "1", "2", "3", "-"},
   {"Ans", "EXP", "xⁿ", "0", ".", "=", "+"}};
  size(860, 720);
  defaultColor = color(21, 29, 47);
  background(defaultColor);
  textSize(18);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  noStroke();
  for (int i = 0; i < 7; i++){
    for (int j = 0; j < 5; j++){
      if (j != 0 || i > 1){
        if (i > 2 && i < 6 && j > 0)
          fill(255, 92);
        else
          fill(255, 35);
        rect((120*i)+70, 395+(70*j), 100, 50, 10);
        fill(255);
        text(caps[j][i], (120*i)+70, 392+(70*j));
      }
    }
  }
  fill(255, 35);
  rect(55, 35, 70, 30, 10);
  rect(130, 395, 220, 50, 10);
  rect(765, 35, 150, 30, 10);
  fill(225);
  stroke(255, 90);
  strokeWeight(2);
  line(130, 377, 130, 413);
  line(765, 26, 765, 44);
  rect(430, 210, 820, 280, 20);
}

void draw(){
  noLoop();
  fill((calc.rad)? 255 : 150);
  text("Rad", 70, 392);
  fill ((calc.rad)? 150 : 255);
  text("Deg", 190, 392);
  fill((calc.annoying)? 255 : 150);
  text("ANN", 727.5, 33);
  fill((calc.annoying)? 150 : 255);
  text("TRY", 802.5, 33);
  // if rad, strong rad, else, strong deg
  // if inv, certain buttons, else, other buttons
}

void display(){
}

void mouseClicked(){
  redraw(); // executed at the end, might require some sort of tell before execution
}

void clickCheck(){
}
