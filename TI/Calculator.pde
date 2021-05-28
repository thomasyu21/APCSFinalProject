import java.util.Arrays;

class Calculator{
  public ArrayList<Button> buttons;
  public boolean annoying, rad, inv;
  private ArrayList<String> expression, expressionOld, nums, ops, misc, end;
  private boolean DEBUG = true;
  
  public Calculator(){
    annoying = true;
    rad = true;
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
    misc = new ArrayList<String>(Arrays.asList("π", "e", "√(", "pow(", "E"));
    end = new ArrayList<String>(Arrays.asList("Ans", "0", "1", "2", "e", "3", "π", "4", "5", "6", "7", "8", "9", ")"));
    buttons = new ArrayList<Button>();
    for (int m = 0; m < buttonArray.length; m++){
      for (int n = 0; n < buttonArray[0].length; n++){
        if (!buttonArray[m][n].equals("Rad")){
          buttons.add(new Button(buttonArray[m][n], (120*n)+70, 415+(70*m), 100, 50));
        }
      }
    }
    buttons.add(new Button("Rad", 130, 415, 220, 50));
    buttons.add(new Button("Mode", 765, 45, 150, 50));
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
      case "Mode":   annoying = !annoying;
                     newInv = inv;
                     break;
      case "CE":     if (inv)
                       expression.clear(); // clear
                     else if (expression.size() > 0)
                       expression.remove(expression.size()-1); // backspace
                     break;
      case "=":      eval();
                     break;
      case "Rad":    rad = !rad;
                     newInv = inv;
                     break;
      case "Inv":    inv = !inv;
                     newInv = inv;
                     break;
      case "pow(":    if (expression.size() > 0 &&
                      end.indexOf(expression.get(expression.size()-1)) != -1)
                       expression.add(id);
                     break;
      default:       expression.add((inv)? ammendInv(id) : id);
                     break;
    }
    inv = newInv;
    
    if (DEBUG){
      for (String i : expression)
        System.out.print(i);
      System.out.print("\n");
    }
  }
  
  private String ammendInv(String id){
    switch (id){
      case "sin(": return "arcsin(";
      case "cos(": return "arccos(";
      case "tan(": return "arctan(";
      case "Ans":  return randomAdd();
      default:     return id;
    }
  }
  
  private void eval(){
    //System.out.println(Arrays.toString(expression.toArray())); for testing
    evalHelp(expression);
   }
  
  private void evalHelp(ArrayList<String> e){
    if (e.indexOf("(") != -1){
      parenthesesCheck(e);
    }
    /* for testing
    for (int i = 0; i < e.size(); i++){
      if (e.get(i).equals("÷")){
        e.remove(i);
        int num1 = Integer.parseInt(e.remove(i-1));
        int num2 = Integer.parseInt(e.remove(i-1));
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
        //System.out.println(Arrays.toString(expressionSec.toArray())); for testing
        evalHelp(expressionSec);
        e.add(start, expressionSec.get(0));
        //System.out.println(expressionSec.get(0)); for testing
        numOpen = 0;
        numClose = 0;
      }
    }
  }
  
  private void shuffle(){}
  
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
