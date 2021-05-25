Calculator calc;
char bgState;
PImage sinful, cosmic, tanned;
color defaultColor;

void setup(){
  size(860, 720);
  for (int i = 0; i < 7; i++){
    for (int j = 0; j < 5; j++){
      if ( !((j == 4) && (i == 0 || i == 1))){
        rect((120*i)+20, 650 - (70*j), 100, 50);
      }
    }
  }
  rect(20, 370, 110, 50);
  rect(130, 370, 110, 50);
  rect(20, 70, 820, 280);
  rect(20, 20, 70, 30);
  rect(690, 20, 75, 30);
  rect(765, 20, 70, 30);
}

void draw(){
}

void display(){
}

void mouseClicked(){
}

void clickCheck(){
}
