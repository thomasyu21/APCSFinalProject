import java.util.Arrays;

class Calculator{
  public ArrayList<Button> buttons;
  public boolean annoying, rad, inv;
  private String expression, expressionOld;
  private ArrayList<String> nums, ops, misc;
  
  public Calculator(String[][] arrButtons){
    annoying = true;
    rad = true;
    expression = "";
    expressionOld = "";
    String[][] buttonArray = 
    {{"Rad", "Rad", "!", "(", ")", "per", "CE"},
     {"Inv", "sin(", "ln(", "7", "8", "9", "÷"},
     {"π", "cos(", "log(", "4", "5", "6", "×"},
     {"e", "tan(", "√(", "1", "2", "3", "-"},
     {"Ans", "E", "pow", "0", ".", "=", "+"}};
    nums = new ArrayList<String>(Arrays.asList("0", "1", "2", "3", "4", "5", "6", "7", "8", "9"));
    ops = new ArrayList<String>(Arrays.asList("+", "-", "×", "÷"));
    misc = new ArrayList<String>(Arrays.asList("π", "e", "√(", "pow", "E"));
    buttons = new ArrayList<Button>();
    for (int m = 0; m < arrButtons.length; m++){
      for (int n = 0; n < arrButtons[0].length; n++){
        if (!buttonArray[m][n].equals("Rad")){
          buttons.add(new Button(buttonArray[m][n], (120*n)+70, 415+(70*m), 100, 50));
        }
      }
    }
    buttons.add(new Button("Rad", 130, 415, 220, 50));
    buttons.add(new Button("Mode", 765, 45, 150, 50));
  }
  
  public String getExpression(){
    return expression;
  }
  
  public String getExpressionOld(){
    return expressionOld;
  }
  
  public void buttonClicked(String id){
    switch (id){
      case "Mode":   annoying = !annoying;
                     break;
      case "CE":     expression = ""; // requires elaboration, should be backspace, funcs complicate
                     break;
      case "=":      eval();
                     break;
      case "Rad":    rad = !rad;
                     break;
      case "Inv":    inv = !inv;
                     break;
      default:       expression += (inv)? ammendInv(id) : id;
                     break;
    }
  }
  
  private String ammendInv(String id){
    switch (id){
      case "sin(": return "arcsin(";
      case "cos(": return "arccos(";
      case "tan(": return "arctan(";
      case "Ans":  return "" + random(1);
      default:     return id;
    }
  }
  
  private void eval(){}
  
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
}
