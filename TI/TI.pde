Calculator calc;
char bgState;
PFont buttonFont;
PFont screenFont;
PImage anndef, normal, sinful, cosmic, tanned, currBg;
String[][] caps;

void setup(){
  noLoop();
  /** 
  * Recommended Size: (FOR WHEN ALL DISPLAY IS RELATIVE
  * Width: 840 (32 factors!)
  * Height: 720 (30 factors)
  *
  * BOTH DIMENSIONS MUST BE UNDER 1000!!!
  */
  size(860, 740); // leave until all display is relative
  calc = new Calculator();
  caps = new String[][]
  {{"Rad", "Deg", "x!", "(", ")", "%", "del"},
   {"Inv", "sin", "ln", "7", "8", "9", "÷"},
   {"π", "cos", "log", "4", "5", "6", "×"},
   {"e", "tan", "√", "1", "2", "3", "-"},
   {"Ans", "EXP", "xⁿ", "0", ".", "=", "+"}};
  buttonFont = createFont("assets/fonts/OpenSans-Bold.ttf", 24);
  screenFont = createFont("assets/fonts/JetBrainsMono-VariableFont_wght.ttf", 36);
  anndef = loadImage("assets/images/anndef.jpg").get(0, 0, width, height);
  normal = loadImage("assets/images/normal.jpg").get(0, 0, width, height);
  sinful = loadImage("assets/images/sinful.jpg").get(0, 0, width, height);
  cosmic = loadImage("assets/images/cosmic.jpg").get((1000-width)/2, 0, width, height);
  tanned = loadImage("assets/images/tanned.jpg").get(0, 0, width, height);
  if (calc.annoying)
    bgState = 'a';
  else
    bgState = 'n';
  rectMode(CENTER);
  make();
  
}

void make(){
  switch (bgState){
    case 'a':
      currBg = anndef;
      break;
    case 'n':
      currBg = normal;
      break;
    case 's':
      currBg = sinful;
      break;
    case 'c':
      currBg = cosmic;
      break;
    case 't':
      currBg = tanned;
      break;
  }
  background(currBg);
  textFont(buttonFont);
  textAlign(CENTER, CENTER);
  noStroke();
  fill(255, 50);
  rect(130, 415, 220, 50, 10); // Rad
  rect(730, 45, 220, 50, 10); // Mode
  rect(55, 45, 70, 50, 10); // Name
  fill((calc.annoying)? 255 : 150);
  text("Annoy", 675, 43);
  fill((calc.annoying)? 150 : 255);
  text("Work", 785, 43);
  fill(255);
  text("TI-∞", 55, 43);
  stroke(255, 90);
  strokeWeight(2);
  line(130, 397, 130, 433); // Rad
  line(730, 27, 730, 63); // Mode
  noStroke();
  for (int i = 0; i < 7; i++){
    for (int j = 0; j < 5; j++){
      if (!(caps[j][i].equals(""))){
        if (i > 2 && i < 6 && j > 0)
          fill(255, 80);
        else
          fill(255, 50);
        if (i > 1 || j > 0)
          rect((120*i)+70, 415+(70*j), 100, 50, 10);
        switch(caps[j][i]){
          case "Rad":
            fill((calc.rad)? 255 : 150);
            text("Rad", i*120+70, j*70+412);
            break;
          case "Deg":
            fill((calc.rad)? 150 : 255);
            text("Deg", i*120+70, j*70+412);
            break;
          case "del":
            fill(255);
            text((calc.inv)? "CE":"del", i*120+70, j*70+412);
            break;
          case "Inv":
            fill((calc.inv)? 255 : 150);
            text("Inv", i*120+70, j*70+412);
            break;
          case "sin":
          case "cos":
          case "tan":
            fill(255);
            text((calc.inv)? "arc"+caps[j][i]:caps[j][i], i*120+70, j*70+412);
            break;
          case "Ans":
            fill(255);
            text((calc.inv)? "Rand" : "Ans", i*120+70, j*70+412);
            break;
          default:
            fill(255);
            text(caps[j][i], i*120+70, j*70+412);
            break;
        }
      }
    }
  }
}

void draw(){
  make(); // display buttons
  screen(); // display updated screen expression
  //coords(); // display x and y pos of cursor
}

void screen(){
  textAlign(LEFT, CENTER);
  fill(255);
  rect(430, 230, 820, 280, 20);
  fill(0);
  textFont(screenFont);
  screenExpression();
  textAlign(CENTER, CENTER);
  textSize(22);
}

void coords(){
  fill(255);
  rect(mouseX, mouseY+25, 80, 50);
  fill(255, 0, 0);
  circle(mouseX, mouseY, 3);
  fill(0);
  textSize(15);
  text("X: "+mouseX, mouseX, mouseY+15);
  text("Y: "+mouseY, mouseX, mouseY+30);
}

void screenExpression(){
  int pos = 20;
  int level = 0; // curr level of power, [0, 4]
  int[] levelQuan = {1, 0, 0, 0, 0}; // # unresolved left parentheses;
  for (int i = 0; i < calc.getExpression().size(); i ++){
    String str = calc.getExpression().get(i);
    if (str.equals("pow(")){
      if (level < 4){
        if (level == 0)
          pos += 12;
        pos += 13;
        level ++;
        levelQuan[level] ++;
        textSize(20);
        text("(", pos % 775, (150 - 10*level)+ 80 * ((pos) / 775));
      }else
        calc.getExpression().remove(calc.getExpression().size()-1);
    }else{
      if (level == 0){
        textSize(40);
        pos += 25;
      }else{
        pos += 12;
        if (levelQuan[level] > 0){
          textSize(20);
        }else{
          while (levelQuan[level] == 0)
            level --;
          if (level == 0){
            textSize(40);
          }
        }
        if (level > 0 && str.contains("("))
          levelQuan[level] ++;
      }
      if (pos % 775 + str.length()*25 > 775)
        pos += 820 - pos % 775;
      if (pos > 1550){
        calc.getExpression().remove(calc.getExpression().size()-1);
        return;
      }
      text(str, pos % 775, (150 - 10*level)+ 80 * (pos / 775));
      if (level > 0 && str.equals(")"))
        levelQuan[level] --;
      if (level == 0)
        pos += 13*(str.length()-1);
      pos += 12*(str.length()-1);
    }
  }
}

void mouseReleased(){
  for (Button b : calc.buttons){
    if (abs(b.x - mouseX) <= b.wid/2 && abs(b.y - mouseY) <= b.hei/2)
      calc.buttonClicked(b.getIdentity(calc.annoying)); 
  }
  if (calc.DEBUG){
    for (String i : calc.expression)
      System.out.print(i);
    System.out.print("\n");
  }
  redraw();
}
