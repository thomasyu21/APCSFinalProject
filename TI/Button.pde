class Button{
  private String identity; //to identify what the button does
  private String identityA; // identity assigned by shuffle in Annoying Mode
  public int x, y, wid, hei; //location and dimensions
  
  public Button(String identity, int X, int Y, int w, int h){
    
  }
  
  public String getIdentity(){
    return (TI.calc.annoying)? identityA : identity;
  }
  
  public void setIdentity(String newIdentity){
  
  }
  
}
