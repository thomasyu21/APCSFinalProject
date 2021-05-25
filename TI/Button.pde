class Button{
  private String identity; //to identify what the button does
  private String identityA; // identity assigned by shuffle in Annoying Mode
  public int x, y, wid, hei; //location and dimensions
  
  public Button(String Identity, int X, int Y, int w, int h){
    identity = Identity;
    x = X;
    y = Y;
    wid = w;
    hei = h;
  }
  
  public String getIdentity(){
    return (calc.annoying)? identityA : identity;
  }
  
  public void setIdentity(String newIdentity){
    identityA = newIdentity;
  }
  
}
