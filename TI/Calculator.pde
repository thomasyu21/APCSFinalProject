class Calculator{
  public ArrayList<Button> buttons;
  private boolean annoying, rad, inv;
  private String expression, expressionOld;
  private ArrayList<String> nums, ops, misc;
  
  public Calculator(){
    annoying = true;
    rad = true;
    expression = "";
    expressionOld = "";
    String[] buttonArray = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", 
                            "/", "*", "-", "+", 
                            "pi", "e", "sqrt", "pow", "EXP", 
                            "sin", "cos", "tan", "log", "ln", "fact", "%",
                            "(", ")", ".", "ans", "clear", "=", "rad", "inv"};
    nums = new ArrayList<String>();
    for (int i = 0; i <= 9; i++){
      nums.add(buttonArray[i]);
    }
    ops = new ArrayList<String>();
    for (int j = 10; j <= 13; j++){
      ops.add(buttonArray[j]);
    }
    misc = new ArrayList<String>();
    for (int k = 14; k <= 18; k++){
      misc.add(buttonArray[k]);
    }
    buttons = new ArrayList<Button>();
    for (int m = 0; m < buttonArray.length; m++){
      
    }
  }
  
  public String getExpression(){
    return ""; // placeholder
  }
  
  public String getExpressionOld(){
    return ""; // placeholder
  }
  
  public void buttonClicked(){}
  
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
