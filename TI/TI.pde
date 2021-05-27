Calculator calc;
char bgState;
color defaultColor;
color currColor;
PFont buttonFont;
PFont screenFont;
PImage sinful, cosmic, tanned;
String[][] caps;

void setup(){
  caps = new String[][]
  {{"", "", "x!", "(", ")", "%", ""},
   {"", "", "ln", "7", "8", "9", "÷"},
   {"π", "", "log", "4", "5", "6", "×"},
   {"e", "", "√", "1", "2", "3", "-"},
   {"", "EXP", "xⁿ", "0", ".", "=", "+"}};
  calc = new Calculator();
  size(860, 740);
  defaultColor = color(21, 29, 47);
  currColor = defaultColor;
  background(currColor);
  buttonFont = createFont("OpenSans-Bold.ttf", 22);
  screenFont = createFont("JetBrainsMono-VariableFont_wght.ttf", 36);
  textFont(buttonFont);
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

void updateButtons(){ // toggle and inv buttons
  textFont(buttonFont);
  fill(defaultColor);
  noStroke();
  rect(130, 415, 220, 50, 10); // Rad
  rect(765, 45, 150, 50, 10); // Mode
  rect(790, 415, 100, 50, 10); // del
  rect(70, 485, 100, 50, 10); // Inv
  rect(190, 485, 100, 50, 10); // sin(
  rect(190, 555, 100, 50, 10); // cos(
  rect(190, 625, 100, 50, 10); // tan(
  rect(70, 695, 100, 50, 10); // Ans
  fill(255, 35);
  rect(130, 415, 220, 50, 10); // Rad
  rect(765, 45, 150, 50, 10); // Mode
  rect(790, 415, 100, 50, 10); // del
  rect(70, 485, 100, 50, 10); // Inv
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
  fill((calc.inv)? 255 : 150);
  text("Inv", 70, 483);
  fill(255);
  text((calc.inv)? "CE" : "del", 790, 413); 
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
  textFont(screenFont);
  if (!screenExpression()) // expression limited to two screen
    calc.getExpression().remove(calc.getExpression().size()-1);
  textAlign(CENTER, CENTER);
  textSize(22);
}

boolean screenExpression(){
  int pos = 20;
  int level = 0; // curr level of power, [0, 4]
  boolean levelFirst = false; // first index of power level?
  int[] levelQuan = {1, 0, 0, 0, 0}; // how many unresolved left parentheses?
  for (int i = 0; i < calc.getExpression().size(); i ++){
    String str = calc.getExpression().get(i);
    if (str.equals("pow")){
      if (level < 4){
        if (level == 0)
          pos += 12;
        level ++;
        levelFirst = true;
        if (i == calc.getExpression().size() - 1){
          textSize(20);
          text("_", 13 + pos % 775, (150 - 10*level)+ 80 * ((pos+13) / 775));
        }
      }
    }else{
      if (level == 0){
        textSize(40);
        pos += 25;
      }else{
        if (calc.nums.indexOf(i) != -1 || str.equals(".")
           || levelQuan[level] > 0 || levelFirst){
          textSize(20);
          pos += 12;
          levelFirst = false;
          if (str.contains("("))
            levelQuan[level] ++;
        }else{
          while (levelQuan[level] == 0)
            level --;
          pos += 12;
          if (level == 0){
            pos += 13;
            textSize(40);
          }
        }
      }
      if (pos % 775 + str.length()*25 > 775)
        pos += 820 - pos % 775;
      if (pos > 1550) return false;
      text(str, pos % 775, (150 - 10*level)+ 80 * (pos / 775));
      if (level > 0 && str.equals(")"))
        levelQuan[level] --;
      if (level == 0)
        pos += 13*(str.length()-1);
      pos += 12*(str.length()-1);
    }
  }
  return true;
}

void mouseClicked(){
  for (Button b : calc.buttons){
    if (abs(b.x - mouseX) <= b.wid/2 && abs(b.y - mouseY) <= b.hei/2)
      calc.buttonClicked(b.getIdentity());
  }
  redraw();
}
