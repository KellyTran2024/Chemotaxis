Bacteria[] bacteria; 
int numBacteria = 100; 
int moveX = 0, moveY = 0; 

void setup() {
  size(800, 800); 
  bacteria = new Bacteria[numBacteria]; 
 for (int i = 0; i < numBacteria; i++) {
   bacteria[i] = new Bacteria((int)(Math.random()*width), (int)(Math.random()*height), color((int)(Math.random()*255), (int)(Math.random()*255), (int)(Math.random()*255)));
  }
}

void draw() {
  background(0); 
  for (int i = 0; i < numBacteria; i++) {
    bacteria[i].move();
    bacteria[i].show();
  }
}

void keyPressed() {
  //up key W
  if (key == 'w' || key == 'W') {
    moveY = -1; 
    
  // down key S
  }else if (key == 's' || key == 'S') {
    moveY = 1;  
    
    // left key A
  }else if (key == 'a' || key == 'A') {
    moveX = -1;  
    
    // right key D
  }else if (key == 'd' || key == 'D') {
    moveX = 1;  
   // color change if presses C
  }else if (key == 'c' || key == 'C') {
for (int i = 0; i < numBacteria; i++) {
      bacteria[i].changeColor();
    }
  
  //2x size
  } else if (key == 'q' || key == 'Q') {
    for (int i = 0; i < numBacteria; i++) {
      bacteria[i].changeSize(2);
    }
  } else if (key == 'z' || key == 'Z') {
    //divide size
    for (int i = 0; i < numBacteria; i++) {
      bacteria[i].changeSize(0.5);
    }
  } else if (keyCode == UP) {
    //increase bacteria count by 10
    addBacteria(10); 
  } else if (keyCode == DOWN) {
    //decrease bacteria count by 10
    removeBacteria(10); 
  }
}

void keyReleased() {
  //stop verticle movement (w/s)
  if (key == 'w' || key == 'W' || key == 's' || key == 'S') {
    moveY = 0;  
    //stop horiz movement (a,d) 
  } else if (key == 'a' || key == 'A' || key == 'd' || key == 'D') {
    moveX = 0;  
  }
}

//increase bacteria function
void addBacteria(int count) {
  Bacteria[] newBacteria = new Bacteria[numBacteria + count]; 
  for (int i = 0; i < numBacteria; i++) {
    //new array keeps old array data 
    newBacteria[i] = bacteria[i]; 
  }
  // null pointer exception if no loop 
  //function's loop that creates new random bacterias 
  for (int i = numBacteria; i < numBacteria + count; i++) {
   newBacteria[i] = new Bacteria((int)(Math.random()*width), (int)(Math.random()*height), color((int)(Math.random()*255), (int)(Math.random()*255), (int)(Math.random()*255)));
  }
  
  bacteria = newBacteria; 
  numBacteria = numBacteria + count;  
}

//function removes/reduce bacteria 
void removeBacteria(int count) {
  if (numBacteria - count >= 0) {
    numBacteria -= count; 
  }
}

//class
class Bacteria {
  int x, y;  
  int bacteriaColor;  
  float size;  
  
  // constructor
  Bacteria(int startX, int startY, int colorValue) {
    x = startX;
    y = startY;
    bacteriaColor = colorValue;  
    size = 10;  
  }

  //WASD and cursor random bias 
  void move() {
    int biasX = 0, biasY = 0;

    //bias random walk cursor 
    if (mouseX>x) biasX = 1;
    else if (mouseX<x) biasX = -1;
    if (mouseY >y) biasY = 1;
    else if (mouseY < y) biasY = -1;

    //biased random walk 
   x += (int)(Math.random()*3)-1 + biasX + moveX*5;
  y += (int)(Math.random()*3)-1 + biasY + moveY*5;

    //borders canvas 
    x = constrain(x,0,width);
    y = constrain(y,0,height);
  }

  void show() {
    fill(bacteriaColor);
    noStroke();
    ellipse(x, y, size, size);  
  }

  //change color
  void changeColor() {
    bacteriaColor = color((int)(Math.random()*255), (int)(Math.random()*255), (int)(Math.random()*255));
  }

  //size change
  void changeSize(float factor) {
    size = size * factor; 
    size = constrain(size, 5, 50);  
  }
}

