class Calculator{
  public ArrayList<Button> buttons;
  public boolean annoying;
  private boolean rad, inv;
  private String expression, expressionOld;
  private ArrayList<String> nums, ops, misc;
  
  public Calculator(String[][] arrButtons){
    annoying = true;
    rad = true;
    expression = "";
    expressionOld = "";
    String[] buttonArray = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", 
                            "/", "*", "-", "+", 
                            "pi", "e", "sqrt", "pow", "EXP"};
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
    for (int m = 0; m < arrButtons.length; m++){
      for (int n = 0; n < arrButtons[0].length; n++){
        if (arrButtons[m][n] != "Rad" && arrButtons[m][n] != "Deg"){
          buttons.add(new Button(arrButtons[m][n], (120*n)+70, 415+(70*m), 100, 50));
        }
      }
    }
    buttons.add(new Button("Rad", 130, 415, 220, 50));
    buttons.add(new Button("switch", 765, 45, 150, 50));
  }
  
  public String getExpression(){
    return expression;
  }
  
  public String getExpressionOld(){
    return expressionOld;
  }
  
  public void buttonClicked(){
    for (Button i : buttons){
      if (mouseX < i.x + i.wid/2 && mouseX > i.x - i.wid/2){
        if (mouseY < i.y + i.hei/2 && mouseY > i.y - i.hei/2){
          if (i.getIdentity().equals("switch")){
            annoying = !annoying;
          }else if (i.getIdentity().equals("CE")){
            expression = "";
          }else if (i.getIdentity().equals("=")){
            eval();
          }else if (i.getIdentity().equals("Rad")){
            rad = !rad;
          }else if (i.getIdentity().equals("Inv")){
            inv = !inv;
          }else{
            expression += i.getIdentity();
          }
        }
      }
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
