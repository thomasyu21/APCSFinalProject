class Button{
  private String identity; //to identify what the button does
  private String identityA; // identity assigned by shuffle in Annoying Mode
  public float x, y, wid, hei; //location and dimensions
  
  public Button(String Identity, float X, float Y, float w, float h){
    identity = Identity;
    identityA = Identity;
    x = X;
    y = Y;
    wid = w;
    hei = h;
  }
  
  public String getIdentity(){
    return (annoying)? identityA : identity;
  }
  
  public void setIdentity(String newIdentity){
    identityA = newIdentity;
  }
  
}
