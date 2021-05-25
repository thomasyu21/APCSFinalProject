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
  background(21, 29, 47);
  textAlign(CENTER, CENTER);
  textSize(18);
  size(860, 720);
  noStroke();
  for (int i = 0; i < 7; i++){
    for (int j = 0; j < 5; j++){
      if (j != 0 || i > 1){
        if (i > 2 && i < 6 && j > 0)
          fill(255, 92);
        else
          fill(255, 35);
        rect((120*i)+20, 370+(70*j), 100, 50, 10);
        
      }
      fill(255);
      text(caps[j][i], (120*i)+70, 392+(70*j));
    }
  }
  fill(255, 35);
  rect(20, 20, 70, 30, 10);
  rect(20, 370, 220, 50, 10);
  rect(690, 20, 150, 30, 10);
  fill(225);
  stroke(255, 90);
  strokeWeight(2);
  line(130, 377, 130, 413);
  line(765, 26, 765, 44);
  rect(20, 70, 820, 280, 20);
}

void draw(){
}

void display(){
  // if rad, strong rad, else, strong deg
  // if inv, certain buttons, else, other buttons
}

void mouseClicked(){
}

void clickCheck(){
}
