Calculator calc;
char bgState;
color defaultColor;
color currColor;
PFont font;
PImage sinful, cosmic, tanned;
String[][] caps;

void setup(){
  caps = new String[][]
  {{"", "", "x!", "(", ")", "%", "CE"},
   {"Inv", "", "ln", "7", "8", "9", "÷"},
   {"π", "", "log", "4", "5", "6", "×"},
   {"e", "", "√", "1", "2", "3", "-"},
   {"", "EXP", "xⁿ", "0", ".", "=", "+"}};
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
      if (!(caps[j][i].equals(""))){
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
  rect(130, 415, 220, 50, 10); // Rad
  rect(765, 45, 150, 50, 10); // Mode
  rect(190, 485, 100, 50, 10); // sin(
  rect(190, 555, 100, 50, 10); // cos(
  rect(190, 625, 100, 50, 10); // tan(
  rect(70, 695, 100, 50, 10); // Ans
  fill(255, 35);
  rect(130, 415, 220, 50, 10); // Rad
  rect(765, 45, 150, 50, 10); // Mode
  rect(190, 485, 100, 50, 10); // sin(
  rect(190, 555, 100, 50, 10); // cos(
  rect(190, 625, 100, 50, 10); // tan(
  rect(70, 695, 100, 50, 10); // Ans
  stroke(255, 90);
  strokeWeight(2);
  line(130, 397, 130, 433); // Rad
  line(765, 27, 765, 63); // Mode
  fill((calc.rad)? 255 : 150);
  text("Rad", 70, 412);
  fill ((calc.rad)? 150 : 255);
  text("Deg", 190, 412);
  fill((calc.annoying)? 255 : 150);
  text("ANN", 727.5, 43);
  fill((calc.annoying)? 150 : 255);
  text("TRY", 802.5, 43);
  fill(255);
  text((calc.inv)? "arcsin" : "sin", 190, 483); 
  text((calc.inv)? "arccos" : "cos", 190, 553); 
  text((calc.inv)? "arctan" : "tan", 190, 623); 
  text((calc.inv)? "Rand" : "Ans", 70, 693); 
}
  

void display(){
  textAlign(LEFT, CENTER);
  fill(255);
  rect(430, 230, 820, 280, 20);
  fill(defaultColor);
  textSize(36);
  text(calc.getExpression(), 40, 200); // pow, percent and spacing demand this be elaborated on
  textAlign(CENTER, CENTER);
  textSize(22);
}

void mouseClicked(){
  for (Button b : calc.buttons){
    if (abs(b.x - mouseX) <= b.wid/2 && abs(b.y - mouseY) <= b.hei/2)
      calc.buttonClicked(b.getIdentity());
  }
  redraw(); // executed at the end, might require some sort of tell before execution
}
