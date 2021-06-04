Calculator calc;
char bgState;
boolean solve;
float gx, gy, lx, ly, dx, dy;
PFont buttonFont;
PFont screenFont;
PImage anndef, normal, sinful, cosmic, tanned, currBg;
String[][] caps;

void setup(){
  /** 
  * Recommended Size:
  * Width: 840 (32 factors!)
  * Height: 720 (30 factors)
  */
  size(840, 720);
  
  noLoop();
  surface.setTitle(":)");
  gx = width/40;
  gy = height/40;
  lx = 4*width/35;
  ly = 3*gy;
  dx = gx + lx;
  dy = gy + ly;
  calc = new Calculator();
  caps = new String[][]
  {{"Rad", "Deg", "x!", "(", ")", "%", "del"},
   {"Inv", "sin", "ln", "7", "8", "9", "÷"},
   {"π", "cos", "log", "4", "5", "6", "×"},
   {"e", "tan", "√", "1", "2", "3", "-"},
   {"Ans", "EXP", "xⁿ", "0", ".", "=", "+"}};
  solve = false;
  buttonFont = createFont("assets/fonts/OpenSans-Bold.ttf", width/35);
  screenFont = createFont("assets/fonts/JetBrainsMono-VariableFont_wght.ttf", 3*width/70);
  anndef = loadImage("assets/images/anndef.jpg");
  normal = loadImage("assets/images/normal.jpg");
  sinful = loadImage("assets/images/sinful.jpg");
  cosmic = loadImage("assets/images/cosmic.jpg");
  tanned = loadImage("assets/images/tanned.jpg");
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
  currBg.resize(width, height);
  background(currBg);
  float ty = height/200;
  textFont(buttonFont);
  textAlign(CENTER, CENTER);
  noStroke();
  fill(255, 50);
  rect(dx + gx/2, 5*dy + ly/2, 2*lx + gx, ly, 10); // Rad
  rect(6*dx + gx/2, gy + ly/2, 2*lx + gx, ly, 10); // Mode
  rect(gx+lx/2, gy+ly/2, lx, ly, 10); // Name
  fill((calc.annoying)? 255 : 150);
  text("Annoy", 11*dx/2 + 3*gx/4, gy + ly/2 - ty);
  fill((calc.annoying)? 150 : 255);
  text("Work", 13*dx/2 + gx/4, gy + ly/2 - ty);
  fill(255);
  text("TI-∞", gx + lx/2, gy + ly/2 - ty);
  rect(width/2, 3*dy, width - 2*gx, 4*ly + 2*gy, 20); // Screen
  stroke(255, 90);
  strokeWeight(2);
  line(dx + gx/2, 5*dy + 5*ly/6, dx + gx/2, 5*dy + ly/6); // Rad
  line(6*dx + gx/2, gy + 5*ly/6, 6*dx + gx/2, gy + 1*ly/6); // Mode
  noStroke();
  for (int i = 0; i < 7; i++){
    for (int j = 0; j < 5; j++){
      if (!(caps[j][i].equals(""))){
        if (i > 2 && i < 6 && j > 0)
          fill(255, 80);
        else
          fill(255, 50);
        if (i > 1 || j > 0)
          rect((i+1)*dx - lx/2, (j+5)*dy + ly/2, lx, ly, 10);
        switch(caps[j][i]){
          case "Rad":
            fill((calc.rad)? 255 : 150);
            text("Rad", (i+1)*dx - lx/2, (j+5)*dy + ly/2 - ty);
            break;
          case "Deg":
            fill((calc.rad)? 150 : 255);
            text("Deg", (i+1)*dx - lx/2, (j+5)*dy + ly/2 - ty);
            break;
          case "del":
            fill(255);
            text((calc.inv)? "CE":"del", (i+1)*dx - lx/2, (j+5)*dy + ly/2 - ty);
            break;
          case "Inv":
            fill((calc.inv)? 255 : 150);
            text("Inv", (i+1)*dx - lx/2, (j+5)*dy + ly/2 - ty);
            break;
          case "sin":
          case "cos":
          case "tan":
            fill(255);
            text((calc.inv)? "arc"+caps[j][i]:caps[j][i], (i+1)*dx - lx/2, (j+5)*dy + ly/2 - ty);
            break;
          case "Ans":
            fill(255);
            text((calc.inv)? "Rand" : "Ans", (i+1)*dx - lx/2, (j+5)*dy + ly/2 - ty);
            break;
          default:
            fill(255);
            text(caps[j][i], (i+1)*dx - lx/2, (j+5)*dy + ly/2 - ty);
            break;
        }
      }
    }
  }
}

void mouseReleased(){
  for (Button b : calc.buttons){
    if (abs(b.x - mouseX) <= b.wid/2 && abs(b.y - mouseY) <= b.hei/2){
      calc.buttonClicked(b.getIdentity(calc.annoying));
      solve = b.getIdentity(calc.annoying).equals("=");
    }
  }
  redraw();
}

void draw(){
  make(); // display buttons
  screen(); // display updated screen expression
  expDebug(); // Print out the expression in console
  //coords(); // display x and y pos of cursor
}

void screen(){
  fill(0);
  textFont(screenFont);
  textAlign(LEFT, CENTER);
  int pos = (int) gx;
  int max = width - (int) gx*4;
  int level = 0; // curr level of power, [0, 4]
  int[] levelQuan = {1, 0, 0, 0, 0}; // # unresolved left parentheses;
  ArrayList<String> screxp = (solve)? calc.getExpressionOld() : calc.getExpression();
  for (int i = 0; i < screxp.size(); i ++){
    String str = screxp.get(i);
    if (str.equals("pow(")){
      if (level < 4){
        if (level == 0)
          pos += width/70;
        pos += width/70;
        level ++;
        levelQuan[level] ++;
        textSize(width/40);
        text("(", pos % max, height/5 - height*level/72 + height*(pos/max)/10);
      }else
        screxp.remove(screxp.size()-1);
    }else{
      if (level == 0){
        textSize(width/21);
        pos += width/35;
      }else{
        pos += width/70;
        if (levelQuan[level] > 0){
          textSize(width/40);
        }else{
          while (levelQuan[level] == 0)
            level --;
          if (level == 0){
            textSize(width/21);
          }
        }
        if (level > 0 && str.contains("("))
          levelQuan[level] ++;
      }
      if (pos % max + str.length()*width/35 > max)
        pos += (width - 2*gx) - pos % max;
      if (pos > 2*max){
        screxp.remove(screxp.size()-1);
        return;
      }
      text(str, pos % max, height/5 - height*level/72 + height*(pos/max)/10);
      if (level > 0 && str.equals(")"))
        levelQuan[level] --;
      if (level == 0)
        pos += (str.length()-1)*width/70;
      pos += (str.length()-1)*width/70;
    }
  }
  textSize(width/21);
  if (solve){
    textAlign(RIGHT, CENTER);
    text(calc.ans, max, 2*height/5);
    textAlign(LEFT, CENTER);
  }else{
    text("Ans: "+calc.ans, (int) gx*2, 2*height/5);
  }
  if (calc.ans.equals("ERROR")
    ||calc.ans.equals("Infinity")
    ||calc.ans.equals("NaN"))
    calc.ans = calc.ansOld;
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

void expDebug(){
  for (String i : calc.expression)
    System.out.print(i);
  System.out.print("\n");
}
