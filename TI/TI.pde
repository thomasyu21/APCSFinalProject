Calculator calc;
char bgState;
color defaultColor;
color currColor;
PFont font;
PImage sinful, cosmic, tanned;
String[][] caps;

void setup(){
  caps = new String[][]
  {{"Rad", "Deg", "x!", "(", ")", "%", "CE"},
   {"Inv", "sin", "ln", "7", "8", "9", "÷"},
   {"π", "cos", "log", "4", "5", "6", "×"},
   {"e", "tan", "√", "1", "2", "3", "-"},
   {"Ans", "EXP", "xⁿ", "0", ".", "=", "+"}};
  calc = new Calculator(caps);
  size(860, 740);
  defaultColor = color(21, 29, 47);
  currColor = defaultColor;
  background(currColor);
  font = createFont("OpenSans-Bold.ttf", 22);
  textFont(font);
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
        rect((120*i)+70, 415+(70*j), 100, 50, 10);
        fill(255);
        text(caps[j][i], (120*i)+70, 412+(70*j));
      }
    }
  }
  fill(255, 35);
  rect(55, 45, 70, 50, 10); // Name
  fill(255);
  text("TI-∞", 55, 43);
  rect(430, 230, 820, 280, 20); // Screen
  noLoop();
}

void draw(){
  display();
  updateButtons();
}

void updateButtons(){ // updates Rad | Deg and ANN | Try
  fill(defaultColor);
  noStroke();
  rect(130, 415, 220, 50, 10);
  rect(765, 45, 150, 50, 10);
  fill(255, 35);
  rect(130, 415, 220, 50, 10); // Rad | Deg
  rect(765, 45, 150, 50, 10); // ANN | TRY
  stroke(255, 90);
  strokeWeight(2);
  line(130, 397, 130, 433); // Rad | Deg
  line(765, 27, 765, 63); // ANN | Try
  fill((calc.rad)? 255 : 150);
  text("Rad", 70, 412);
  fill ((calc.rad)? 150 : 255);
  text("Deg", 190, 412);
  fill((calc.annoying)? 255 : 150);
  text("ANN", 727.5, 43);
  fill((calc.annoying)? 150 : 255);
  text("TRY", 802.5, 43);
}
  

void display(){
  textAlign(LEFT, CENTER);
  fill(255);
  rect(430, 230, 820, 280, 20);
  fill(defaultColor);
  text(calc.getExpression(), 40, 200);
  textAlign(CENTER, CENTER);
}

void mouseClicked(){
  calc.buttonClicked();
  redraw(); // executed at the end, might require some sort of tell before execution
}

void clickCheck(){
}
