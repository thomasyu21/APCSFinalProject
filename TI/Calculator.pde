import java.util.*;

class Calculator{
  public ArrayList<Button> buttons;
  public boolean annoying, rad, inv;
  private ArrayList<String> expression, expressionOld, nums, ops, misc, end;
  private boolean DEBUG = true;
  private int openParen, closeParen;
  
  public Calculator(){
    annoying = true;
    rad = true;
    openParen = 0;
    closeParen = 0;
    expression = new ArrayList<String>();
    expressionOld = new ArrayList<String>();
    String[][] buttonArray = 
    {{"Rad", "Rad", "!", "(", ")", "%", "CE"},
     {"Inv", "sin(", "ln(", "7", "8", "9", "÷"},
     {"π", "cos(", "log(", "4", "5", "6", "×"},
     {"e", "tan(", "√(", "1", "2", "3", "-"},
     {"Ans", "E", "pow(", "0", ".", "=", "+"}};
    nums = new ArrayList<String>(Arrays.asList("0", "1", "2", "3", "4", "5", "6", "7", "8", "9"));
    ops = new ArrayList<String>(Arrays.asList("+", "-", "×", "÷"));
    misc = new ArrayList<String>(Arrays.asList("π", "e", "√(", "pow(", "E", "!"));
    end = new ArrayList<String>(Arrays.asList("Ans", "0", "1", "2", "e", "3", "π", "4", "5", "6", "7", "8", "9", ")"));
    buttons = new ArrayList<Button>();
    buttons.add(new Button("Mode", 765, 45, 150, 50));
    buttons.add(new Button("Rad", 130, 415, 220, 50));
    for (int m = 0; m < buttonArray.length; m++){
      for (int n = 0; n < buttonArray[0].length; n++){
        if (!buttonArray[m][n].equals("Rad")){
          buttons.add(new Button(buttonArray[m][n], (120*n)+70, 415+(70*m), 100, 50));
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
        scramble();
        newInv = inv;
        break;
      case "CE":
        if (inv){ // clear
          expression.clear(); 
          openParen = 0;
          closeParen = 0;
        }
        else if (expression.size() > 0){ // backspace
          if (expression.get(expression.size()-1).equals("(")){
            openParen--;
          }
          if (expression.get(expression.size()-1).equals(")")){
            closeParen--;
          }
          expression.remove(expression.size()-1);
        }
        break;
      case "=":
        if (!annoying){
          //before eval, 'process' for ~7 seconds
        }
        eval();
        scramble();
        break;
      case "Rad":
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
          bgState = (inv)? 'n' : id.charAt(0);
        expression.add((inv)? "arc"+id : id);
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
      default:
        expression.add(id);
        if (id.contains("(")){
          openParen++;
        }
        break;
    }
    inv = newInv;
  }
  
  private void eval(){
    expressionFix();
    //System.out.println(Arrays.toString(expression.toArray()));
    evalHelp(expression);
    //System.out.println(Arrays.toString(expression.toArray()));
   }
  
  private void evalHelp(ArrayList<String> e){
    if (e.indexOf("(") != -1){
      parenthesesCheck(e);
    }
    /*
    for (int i = 0; i < e.size(); i++){
      if (e.get(i).equals("÷")){
        e.remove(i);
        float num1 = Float.parseFloat(e.remove(i-1));
        float num2 = Float.parseFloat(e.remove(i-1));
        e.add(i-1, num1 / num2 + "");
      }
    }
    */
  }
  
  private void parenthesesCheck(ArrayList<String> e){
    int numOpen = 0;
    int numClose = 0;
    for (int i = 0; i < e.size(); i++){
      if (e.get(i).equals("(")){
        numOpen++;
      }
      if (e.get(i).equals(")")){
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
    for (int i = 0; i < expression.size()-1; i++){
      try{
        if (!(expression.get(i).contains("."))){
          Float current = Float.parseFloat(expression.get(i));
        }
        if (nums.contains(expression.get(i+1)) || expression.get(i+1).equals(".")){
          expression.set(i, expression.get(i) + expression.remove(i+1));
          i--;
        }
      }catch (NumberFormatException e){}
      ArrayList<String> funcs = new ArrayList<String>(Arrays.asList("sin(", "cos(", "tan(", "ln(", "log(", "√(", "pow("));
      if ((expression.get(i).equals(")") && !(ops.contains(expression.get(i+1)) || expression.get(i+1).equals(")")) ||
          (!(ops.contains(expression.get(i)) || expression.get(i).equals("(")) && (funcs.contains(expression.get(i+1)) || expression.get(i+1).equals("("))))){
        expression.add(i+1, "×");
      }
      if (funcs.contains(expression.get(i))){
        expression.add(i+1, "(");
      }
      while (closeParen < openParen){
        expression.add(")");
        closeParen++;
      }
    }
  }
  
  private void scramble(){
    if (annoying){
      Collections.shuffle(nums);
      Collections.shuffle(ops);
      Collections.shuffle(misc);
      for (Button b : buttons){
        if (nums.contains(b.getIdentity(annoying))){
          b.setIdentity(nums.get(0));
          nums.add(nums.remove(0));
        }
        else if (ops.contains(b.getIdentity(annoying))){
          b.setIdentity(ops.get(0));
          ops.add(ops.remove(0));
        }
        else if (misc.contains(b.getIdentity(annoying))){
          b.setIdentity(misc.get(0));
          misc.add(misc.remove(0));
        }
      }
    }
  }
  
  private double gamma(double n){
    if (n == (int) n)
      return factorial((int) n);
    n ++;
    double g = (Math.pow((n + 4.5), n - 0.5)
             * Math.pow(Math.E, -(n + 4.5))
             * Math.sqrt(2*Math.PI));
    g *= 1.0 + 76.18009173/(n + 0) - 86.50532033/(n + 1) + 24.01409822/(n + 2)
             - 1.231739516/(n + 3) + 0.00120858003/(n + 4) - 0.00000536382/(n + 5);
    int s = (int) Math.log10(g);
    if (g > 1)
      s ++;
    return (g - (g % Math.pow(10, -9+s)));
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
