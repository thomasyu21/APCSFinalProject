import java.util.*;

class Calculator{
  public ArrayList<Button> buttons;
  private int openParen, closeParen;
  public String ans, ansOld;
  private ArrayList<String> expression, expressionOld, nums, ops, backops, misc, end;
  
  public Calculator(){
    openParen = 0;
    closeParen = 0;
    ans = "0.0";
    expression = new ArrayList<String>();
    expressionOld = new ArrayList<String>();
    expressionOld.add("0");
    String[][] buttonArray = 
    {{"Rad", "Rad", "!", "(", ")", "%", "CE"},
     {"Inv", "sin(", "ln(", "7", "8", "9", "÷"},
     {"π", "cos(", "log(", "4", "5", "6", "×"},
     {"e", "tan(", "√(", "1", "2", "3", "-"},
     {"Ans", "E", "pow(", "0", ".", "=", "+"}};
    nums = new ArrayList<String>(Arrays.asList("0", "1", "2", "3", "4", "5", "6", "7", "8", "9"));
    ops = new ArrayList<String>(Arrays.asList("+", "-", "×", "÷"));
    backops = new ArrayList<String>(Arrays.asList("pow(", "!", "%"));
    misc = new ArrayList<String>(Arrays.asList("π", "e", "√(", "pow(", "E"));
    end = new ArrayList<String>(Arrays.asList("Ans", "0", "1", "2", "e", "3", "π", "4", "5", "6", "7", "8", "9", ")", "%", "!"));
    buttons = new ArrayList<Button>();
    buttons.add(new Button("Mode", 6*dx + gx/2, gy + ly/2, 2*lx + gx, ly));
    buttons.add(new Button("Rad", dx + gx/2, 5*dy + ly/2, 2*lx + gx, ly));
    for (int m = 0; m < buttonArray.length; m++){
      for (int n = 0; n < buttonArray[0].length; n++){
        if (!buttonArray[m][n].equals("Rad")){
          buttons.add(new Button(buttonArray[m][n], (n+1)*dx - lx/2, (m+5)*dy + ly/2, lx, ly));
        }
      }
    }
    scramble();
  }
  
  public ArrayList<String> getExpression(){
    return expression;
  }
  
  public ArrayList<String> getExpressionOld(){
    return expressionOld;
  }
  
  public void buttonClicked(String id){
    boolean newInv = false;
    switch (id){
      case "Mode":
        annoying = !annoying;
        if (bgState == 'a'){
          surface.setTitle(":|");
          bgState = 'n';
        }
        else if (bgState == 'n'){
          surface.setTitle(":)");
          bgState = 'a';
        }
        scramble();
        newInv = inv;
        break;
      case "CE":
        if (annoying){
          double temp = Math.random();
          System.out.println(temp);
          if (temp < 0.2){
            //black out the screen
          }
          if (temp < 0.3){
            expression.clear();
          }
          if (temp < 0.5){
            //remove last button pressed
          }
        }
        if (inv){ // clear
          expression.clear(); 
          openParen = 0;
          closeParen = 0;
        }
        else if (expression.size() > 0){ // backspace
          if (expression.get(expression.size()-1).contains("(")){
            openParen--;
          }
          if (expression.get(expression.size()-1).contains(")")){
            closeParen--;
          }
          expression.remove(expression.size()-1);
        }
        break;
      case "=":
        if (!annoying){
          //before eval, 'process' for ~7 seconds
        }
        expressionOld = new ArrayList<String>(expression); // makes copy
        eval();
        scramble();
        break;
      case "Rad":
        if (annoying){
          numberCombine();
          alterExpression(id);
          numberSplit();
        }
        rad = !rad;
        newInv = inv;
        break;
      case "Inv":
        inv = !inv;
        newInv = inv;
        break;
      case "pow(":
        if (expression.size() > 0 &&
            end.contains(expression.get(expression.size()-1))){
          expression.add(id);
          openParen++;
        }
        break;
      case "sin(":
      case "cos(":
      case "tan(":
        if (annoying)
          bgState = (inv)? 'a' : id.charAt(0);
        expression.add((inv)? "arc"+id : id);
        openParen++;
        break;
      case "log(":
      case "ln(":
        if (annoying)
          bgState = (id.contains("o"))? 'l' : 'e';
        expression.add(id);
        openParen++;
        break;
      case "Ans":
        expression.add((inv)? randomAdd() : "Ans");
        break;
      case ")":
        if (openParen > closeParen && !expression.get(expression.size()-1).contains("(")){
          expression.add(id);
          closeParen++;
        }
        break;
      case "-":
        if (expression.size() == 0 || (!expression.isEmpty() && !expression.get(expression.size()-1).equals("-")))
          expression.add(id);
          break;
      case "+":
      case "×":
      case "÷":
      case "%":
      case "!":
        if (!expression.isEmpty() && end.contains(expression.get(expression.size()-1)) && place(id))
          expression.add(id);
        if (annoying)
          alterExpression(id);
        break;
      case ".":
        if (place(id)){
          expression.add(id);
        }
        break;
      case "E":
        if (expression.size() > 0 && end.contains(expression.get(expression.size()-1)) && place(id)){
          expression.add(id);
        }
        break;
      default:
        expression.add(id);
        if (id.contains("(")){
          openParen++;
        }
        break;
    }
    if (!(id.equals("CE") || ops.contains(id) || backops.contains(id) || expression.size() < 2 || id.equals(")") || id.equals("Mode")) && (
        expression.get(expression.size()-2).equals("!") ||
        expression.get(expression.size()-2).equals("%")))
      expression.add(expression.size()-1, "×");
    inv = newInv;
  }
  
  private boolean place(String s){
    boolean place = true;
    for (int j = expression.size()-1; j >= 0; j--){
          if (!nums.contains(expression.get(j))){
            if (expression.get(j).equals(s)){
              j = -1;
              place = false;
            }else{
              j = -1;
            }
          }
        }
    return place;
  }
  
  private void eval(){
    if (annoying){
      annoyingExpressionFix();
    }
    expressionFix();
    evalHelp(expression);
    if (annoying){
      if (Math.random() > 0.5){
        ansOld = ans;
        ans = expression.remove(0);
      }
    }else{
      ansOld = ans;
      ans = expression.remove(0);
    }
    expression.clear();
  }
  
  private void evalHelp(ArrayList<String> e){
    if (e.indexOf("(") != -1){
      parenthesesCheck(e);
    }
    try{
      for (int i = 0; i < e.size(); i++){
        switch (e.get(i)){
          case "sin(": 
            if (rad){
              e.set(i, cut(sin(Float.parseFloat(e.remove(i+1))%(PI*2))));
            }else{
              e.set(i, cut(sin(radians(Float.parseFloat(e.remove(i+1)))%(PI*2))));
            }
            i--;
            break;
          case "cos(": 
             if (rad){
              e.set(i, cut(cos(Float.parseFloat(e.remove(i+1))%(PI*2))));
            }else{
              e.set(i, cut(cos(radians(Float.parseFloat(e.remove(i+1)))%(PI*2))));
            }
            i--;
            break;
          case "tan(": 
            if (rad){
              e.set(i, cut(tan(Float.parseFloat(e.remove(i+1))%(PI*2))));
            }else{
              e.set(i, cut(tan(radians(Float.parseFloat(e.remove(i+1)))%(PI*2))));
            }
            i--;
            break;
          case "arcsin(": 
            if (rad){
              e.set(i, cut(asin(Float.parseFloat(e.remove(i+1)))));
            }else{
              e.set(i, cut(degrees(asin(Float.parseFloat(e.remove(i+1))))));
            }
            i--;
            break;
          case "arccos(": 
            if (rad){
              e.set(i, cut(acos(Float.parseFloat(e.remove(i+1)))));
            }else{
              e.set(i, cut(degrees(acos(Float.parseFloat(e.remove(i+1))))));
            }
            i--;
            break;
          case "arctan(": 
            if (rad){
              e.set(i, cut(atan(Float.parseFloat(e.remove(i+1)))));
            }else{
              e.set(i, cut(degrees(atan(Float.parseFloat(e.remove(i+1))))));
            }
            i--;
            break;
          case "pow(":
            e.set(i-1, cut(pow(Float.parseFloat(e.remove(i-1)), Float.parseFloat(e.remove(i)))));
            i-=2;
            break;
          case "√(":
            e.set(i, cut(sqrt(Float.parseFloat(e.remove(i+1)))));
            i--;
            break;
          case "!":
            e.set(i-1, gamma(Float.parseFloat(e.remove(i-1))));
            i--;
            break;
          case "log(":
            e.set(i, cut((float)Math.log10(Float.parseFloat(e.remove(i+1)))));
            i--;
            break;
          case "ln(":
            if (annoying){ 
              e.set(i, cut((float)(Math.log10(exp(1.0))/Math.log10(Float.parseFloat(e.remove(i+1))))));
            }else{
              e.set(i, cut(log(Float.parseFloat(e.remove(i+1)))));
            }
            i--;
            break;
          case "%":
            e.set(i-1, ""+(Float.parseFloat(e.remove(i-1))/100.0));
            i--;
            break;
          case "E":
            e.set(i-1, cut(Float.parseFloat(e.remove(i-1))*pow(10, Float.parseFloat(e.remove(i)))));
            i--;
            break;
        }
      }
      for (int j = 0; j < e.size(); j++){
        switch (e.get(j)){
          case "×":
            float num1 = Float.parseFloat(e.remove(j-1));
            float num2 = Float.parseFloat(e.remove(j));
            e.set(j-1, num1*num2 + "");
            j--;
            break;
          case "÷":
            float num3 = Float.parseFloat(e.remove(j-1));
            float num4 = Float.parseFloat(e.remove(j));
            e.set(j-1, num3/num4 + "");
            j--;
            break;
        }
      }
      for (int k = 0; k < e.size(); k++){
        switch (e.get(k)){
          case "+":
            float num1 = Float.parseFloat(e.remove(k-1));
            float num2 = Float.parseFloat(e.remove(k));
            e.set(k-1, num1+num2 + "");
            k--;
            break;
          case "-":
            float num3 = Float.parseFloat(e.remove(k-1));
            float num4 = Float.parseFloat(e.remove(k));
            e.set(k-1, num3-num4 + "");
            k--;
            break;
        }
      }
      Float.parseFloat(e.get(0));
    }catch (Exception a){
      expression.clear();
      expression.add("ERROR");
    }
  }
  
  private void parenthesesCheck(ArrayList<String> e){
    int numOpen = 0;
    int numClose = 0;
    for (int i = 0; i < e.size(); i++){
      if (e.get(i).equals("(")){
        numOpen++;
      }
      else if (e.get(i).equals(")")){
        numClose++;
      }
      if (numOpen > 0 && numOpen == numClose){
        ArrayList<String> expressionSec = new ArrayList<String>();
        int start = e.indexOf("(");
        for (int j = start; j <= i; i--){
          expressionSec.add(e.remove(j));
        }
        expressionSec.remove(expressionSec.indexOf("("));
        expressionSec.remove(expressionSec.lastIndexOf(")"));
        evalHelp(expressionSec);
        e.add(start, expressionSec.get(0));
        numOpen = 0;
        numClose = 0;
      }
    }
  }
  
  private void expressionFix(){
    for (int j = 0; j < expression.size(); j++){
      if (!(expression.get(j).equals("Ans") || expression.get(j).equals("E"))){
        expression.set(j, expression.get(j).toLowerCase());
      }
      if (expression.get(j).equals("-")){
        try{
          Float.parseFloat(expression.get(j-1));
        }catch (Exception e){
          if (j == 0 || !end.contains(expression.get(j-1))){
            if (expression.size() > 1){
            switch(expression.get(j+1)){
              case "Ans":
                expression.set(j, "-"+ans);
                expression.add(j+1, ")");
                expression.add(j, "(");
                break;
              case "π":
                expression.set(j, "-"+PI);
                expression.add(j+1, ")");
                expression.add(j, "(");
                break;
              case "e":
                expression.set(j, "-"+exp(1.0));
                expression.add(j+1, ")");
                expression.add(j, "(");
                break;
              default:
                expression.set(j, "-"+expression.get(j+1));
            }
              expression.remove(j+1);
            }
          }
        }
      }
    }
    numberCombine();
    for (int k = 0; k < expression.size()-1; k++){
      ArrayList<String> funcs = new ArrayList<String>(Arrays.asList("sin(", "cos(", "tan(", "arcsin(", "arccos(", "arctan(", "ln(", "log(", "√("));
      ArrayList<String> neOps = new ArrayList<String>(Arrays.asList("+", "-", "×", "÷", "%", "!", "E")); 
      if ((expression.get(k).equals(")") && !(neOps.contains(expression.get(k+1)) || expression.get(k+1).equals(")"))) ||
          (end.contains(expression.get(k)) && (funcs.contains(expression.get(k+1)) || expression.get(k+1).equals("(")))){
        if (!expression.get(k+1).equals("pow(")){
          expression.add(k+1, "×");
        }
      }
      if (funcs.contains(expression.get(k)) || expression.get(k).equals("pow(")){
        expression.add(k+1, "(");
      }
    }
    while (closeParen < openParen){
      expression.add(")");
      closeParen++;
    }
  }
  
  private void numberCombine(){
    for (int j = 0; j < expression.size(); j++){
      if (expression.get(j).equals("Ans")){
          expression.set(j, ans);
          expression.add(j+1, ")");
          expression.add(j, "(");
      }
      if (expression.get(j).equals("π")){
        expression.set(j, ""+PI);
        expression.add(j+1, ")");
        expression.add(j, "(");
      }
      if (expression.get(j).equals("e")){
        expression.set(j, ""+exp(1.0));
        expression.add(j+1, ")");
        expression.add(j, "(");
      }
    }
    for (int i = 0; i < expression.size()-1; i++){
      try{
        if (!(expression.get(i).contains("."))){
          Float.parseFloat(expression.get(i));
        }
        if (nums.contains(expression.get(i+1)) || expression.get(i+1).equals(".")){
          expression.set(i, expression.get(i) + expression.remove(i+1));
          i--;
        }
      }catch (NumberFormatException e){}
    }
  }
  
  private void annoyingExpressionFix(){
    if (expression.contains("%")){
      expression.clear();
      expression.add("99999999999999999999");
    }
    for (int i = 0; i < expression.size(); i++){
      if (expression.get(i).equals(".")){
        expression.set(i, "×");
      }
    }
  }
  
  private void alterExpression(String id){
    if (id.equals("Rad")){
      if (rad){
        for (int i = 0; i < expression.size(); i++){
          try{
            expression.set(i, ""+degrees(Float.parseFloat(expression.get(i))));
          }catch(NumberFormatException e){}
        }
      }else{
        for (int j = 0; j < expression.size(); j++){
          try{
            expression.set(j, ""+radians(Float.parseFloat(expression.get(j))));
          }catch(NumberFormatException e){}
        }
      }
    }
    if (id.equals("!")){
      for (int k = 0; k < expression.size(); k++){
          expression.set(k, expression.get(k).toUpperCase());
      }
    }
  }
  
  private void numberSplit(){
    for (int i = 0; i < expression.size(); i++){
      try{
        Float test = Float.parseFloat(expression.get(i));
        String current = expression.remove(i);
        for (int j = current.length()-1; j >= 0; j--){
          expression.add(i, current.substring(j, j+1));
        }
      }catch (NumberFormatException e){}
    }
  }
  
  private void scramble(){
    if (annoying){
      Collections.shuffle(nums);
      Collections.shuffle(ops);
      Collections.shuffle(misc);
      for (Button b : buttons){
        if (nums.contains(b.getIdentity())){
          b.setIdentity(nums.get(0));
          nums.add(nums.remove(0));
        }
        else if (ops.contains(b.getIdentity())){
          b.setIdentity(ops.get(0));
          ops.add(ops.remove(0));
        }
        else if (misc.contains(b.getIdentity())){
          b.setIdentity(misc.get(0));
          misc.add(misc.remove(0));
        }
      }
    }
  }
  
  private String cut(float num){
    String str = "" + num;
    if (str.contains("E-") && 
        Integer.parseInt(str.substring(str.indexOf("E-")+2)) > 6)
      return "" + 0.0;
    if (!str.contains("E") && str.contains(".") && str.indexOf(".")+6 < str.length())
      return str.substring(0, str.indexOf(".") + 7);
    return str;
  }
  
  private String gamma(double n){
    if (n == (int) n)
      return "" + factorial((int) n);
    n ++;
    double g = (Math.pow((n + 4.5), n - 0.5)
             * Math.pow(Math.E, -(n + 4.5))
             * Math.sqrt(2*Math.PI));
    g *= 1.0 + 76.18009173/(n + 0) - 86.50532033/(n + 1) + 24.01409822/(n + 2)
             - 1.231739516/(n + 3) + 0.00120858003/(n + 4) - 0.00000536382/(n + 5);
    return cut((float) g);
    
    //int s = (int) Math.log10(g);
    //if (g > 1)
    //  s ++;
    //return (g - (g % Math.pow(10, -9+s)));
  }

  
  private int factorial(int n){
    if (n < 2)
      return 1;
    return n * factorial(n-1);
  }
  
  private String randomAdd(){
    String num = "" + random(1);
    for (int i = 0; i < num.length(); i ++){
      if (i < num.length() - 1)
        expression.add(num.substring(i, i+1));
      else
        return num.substring(i, i+1);
    }
    return "";
  }
}
