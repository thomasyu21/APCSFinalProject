class Calculator{
  public ArrayList<Button> buttons;
  private boolean annoying, rad, inventor;
  private String expression, expressionOld;
  private ArrayList<String> nums, ops, misc;
  
  public Calculator(){}
  
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
