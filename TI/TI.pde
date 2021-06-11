Calculator calc;
char bgState;
float gx, gy, lx, ly, dx, dy;
boolean annoying, rad, inv, solve, struggle, big;
PFont buttonFont, screenFont;
String line;
PImage currBg, anndef, normal, sinful, cosmic, tanned, logged, eulers;
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
  annoying = true;
  rad = true;
  inv = false;
  solve = false;
  struggle = false;
  big = false;
  line = "";
  calc = new Calculator();
  caps = new String[][]
  {{"Rad", "Deg", "x!", "(", ")", "%", "del"},
   {"Inv", "sin", "ln", "7", "8", "9", "÷"},
   {"π", "cos", "log", "4", "5", "6", "×"},
   {"e", "tan", "√", "1", "2", "3", "-"},
   {"Ans", "EXP", "xⁿ", "0", ".", "=", "+"}};
  buttonFont = createFont("assets/fonts/OpenSans-Bold.ttf", 1);
  screenFont = createFont("assets/fonts/JetBrainsMono-VariableFont_wght.ttf", 1);
  anndef = loadImage("assets/images/anndef.jpg");
  normal = loadImage("assets/images/normal.jpg");
  sinful = loadImage("assets/images/sinful.jpg");
  cosmic = loadImage("assets/images/cosmic.jpg");
  tanned = loadImage("assets/images/tanned.jpg");
  logged = loadImage("assets/images/logged.jpg");
  eulers = loadImage("assets/images/eulers.jpg");
  bgState = (annoying)? 'a' : 'n';
  rectMode(CENTER);
  make();
}

void make(){
  float ty = height/200;
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
    case 'l':
      currBg = logged;
      break;
    case 'e':
      currBg = eulers;
      break;
  }
  currBg.resize(width, height);
  background(currBg);
  textFont(buttonFont);
  textAlign(CENTER, CENTER);
  noStroke();
  textSize((big)? 2*width/35 : width/35);
  fill(255, 50);
  rect(dx + gx/2, 5*dy + ly/2, 2*lx + gx, ly, 10); // Rad
  rect(6*dx + gx/2, gy + ly/2, 2*lx + gx, ly, 10); // Mode
  rect(gx+lx/2, gy+ly/2, lx, ly, 10); // Name
  fill((annoying)? 255 : 150);
  text((big)? "ANNOY" : "Annoy", 11*dx/2 + 3*gx/4, gy + ly/2 - ty);
  fill((annoying)? 150 : 255);
  text((big)? "WORK" : "Work", 13*dx/2 + gx/4, gy + ly/2 - ty);
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
      fill(255, (i > 2 && i < 6 && j > 0)? 80 : 50);
      if (i > 1 || j > 0)
        rect((i+1)*dx - lx/2, (j+5)*dy + ly/2, lx, ly, 10);
      String cap = caps[j][i];
      switch(cap){
        case "Rad":
        case "Deg":
          fill((rad ^ cap.equals("Deg"))? 255 : 150);
          break;
        case "del":
          fill(255);
          if (inv) cap = "CE";
          break;
        case "Inv":
          fill((inv)? 255 : 150);
          break;
        case "sin":
        case "cos":
        case "tan":
          fill(255);
          if (inv) cap = "arc"+cap;
          break;
        case "Ans":
          fill(255);
          if (inv) cap = "Rand";
          break;
        default:
          fill(255);
          break;
      }
      if (big)
        cap = cap.toUpperCase();
      text(cap, (i+1)*dx - lx/2, (j+5)*dy + ly/2 - ty);
    }
  }
}

void mouseReleased(){
  for (Button b : calc.buttons){
    if (abs(b.x - mouseX) <= b.wid/2 && abs(b.y - mouseY) <= b.hei/2){
      calc.buttonClicked(b.getIdentity());
      solve = b.getIdentity().equals("=");
      //struggle = solve && !annoying;
    }
  }
  if (struggle) struggle();
  else redraw();
}

void draw(){
  if (struggle){
    textFont(screenFont);
    textSize(width/21);
    textAlign(LEFT, CENTER);
    fill(255);
    rect(width/2, 3*dy, width - 2*gx, 4*ly + 2*gy, 20); // Screen
    fill(0);
    text(line, 2*gx, height/5);
  }else{
    make(); // display buttons
    screen(); // display updated screen expression
    coords(); // print out x and y positions of cursor in console
    expDebug(); // Print out the expression in console
  }
}

void screen(){
  fill(0);
  textFont(screenFont);
  textAlign(LEFT, CENTER);
  int pos = (int) gx*2;
  int max = width - pos;
  int level = 0; // curr level of power, [0, 4]
  int[] levelQuan = {1, 0, 0, 0, 0}; // # unresolved left parentheses;
  ArrayList<String> screxp = (solve)? calc.getExpressionOld() : calc.getExpression();
  for (int i = 0; i < screxp.size(); i ++){
    String str = screxp.get(i);
    if (str.equals("pow(")){
      if (level < 4){
        level ++;
        levelQuan[level] ++;
        textSize(width/40);
        str = "(";
      }else{
        screxp.remove(screxp.size()-1);
      }
    }else{
      while (levelQuan[level] == 0)
        level --;
      if (level > 0 && str.contains("("))
        levelQuan[level] ++;
    }
    if (pos % max + str.length()*width/21 > max){
      pos += width - pos % max;
      if (pos > 2*max){
        screxp.remove(screxp.size()-1);
      }
    }else{
      textSize((level == 0)? width/21 : width/40);
      text(str, pos % max, height/5 - height*level/72 + height*(pos/max)/10);
      if (level > 0 && str.equals(")"))
        levelQuan[level] --;
      if (level == 0){
        pos += (str.length())*width/35;
      }else{
        pos += (str.length())*width/70;
      }
    }
  }
  textSize(width/21);
  if (solve){
    textAlign(RIGHT, CENTER);
    text(calc.ans, max, 2*height/5);
    textAlign(LEFT, CENTER);
  }else{
    if (calc.ans.equals("ERROR")
      ||calc.ans.equals("Infinity")
      ||calc.ans.equals("NaN"))
      calc.ans = calc.ansOld;
    text("Ans: "+calc.ans, (int) gx*2, 2*height/5);
  }
  textAlign(CENTER, CENTER);
}

void struggle(){
  loop();
  BufferedReader txt = createReader("assets/text/work.txt");
  String curr;
  try{
    while ((curr = txt.readLine()) != null){
      if (random(4) < 1){
        line = curr;
        System.out.println("\t"+line);
        delay((int)sq(random(5, 20))); // exponential variation
      }
    }
  }catch (IOException e){}
  noLoop();
  System.out.println("hello?");
  struggle = false;
  redraw();
}

void coords(){
  fill(255, 0, 0);
  // circle(mouseX, mouseY, 5); // Optionally draws a dot at current position
  System.out.println("\n\nX: "+mouseX+"\tY: "+mouseY);
}

void expDebug(){
  // Uncomment the following for additional by-index console info:
  
  /*System.out.print("By index: ");
  for (String i : (solve)? calc.expressionOld : calc.expression)
    System.out.print(i+", ");
  System.out.print("\nTogether: ");*/
  
  for (String i : (solve)? calc.expressionOld : calc.expression)
    System.out.print(i);
  if (solve)
    System.out.print(" = "+calc.ans);
  System.out.print("\n");
}
