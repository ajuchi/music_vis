// Fractal Flower
// * adapted from Fractal Flower project by user morphogen
// * from: https://www.openprocessing.org/sketch/64159/

// --- Global Variables ---
String timestamp;
float theta;
float counter = 0;
float noPetals = 4;
float reductionFactor = 0.66;
float cutOff = 7;
float branchFactor = 2;

// --- Setup ---
void setup() {
  size(400, 400);
  smooth();
  frameRate(30);
  stroke(255);
}

// --- Main Loop ---
void draw() {
  background(0);
  // increase angle by one
  counter += 1;
  theta = radians(counter);
  
  // move origin to center of screen
  //translate(width/2, height/2);
  translate(0,height);
  // draw petals, rotating by PI/(noPetals/2) each time
  for(int i = 0; i < noPetals; i++) {
    drawPetal();
    rotate(PI / noPetals/2.0);
  }
}

// --- Functions ---

void branch(float h) {
  // Altered from Daniel Shiffman's fractal tree sketch
  
  // decrease the size of the branches
  h *= reductionFactor;
  
  // if branch size is large enough...
  if(h > cutOff) {
    // for each branch that we want to draw
    for(int i = 0; i < branchFactor; i++) {
      // rotate the coordinate frame and draw line
      pushMatrix();
      rotate(branchFactor * theta / 2);
      line(0,0,0,-h);
      // move origin to end of line that was just drawn
      translate(0,-h);
      // branch from there
      branch(h);
      popMatrix();
      
      // repeat in negative direction
      pushMatrix();
      rotate(-branchFactor * theta / 2);
      line(0,0,0,-h);
      translate(0,-h);
      branch(h);
      popMatrix();
      
      // if branching factor is odd, draw branch without a rotation
      if(branchFactor % 2 != 0) {
        pushMatrix();
        line(0,0,0,-h);
        translate(0,-h);
        branch(h);
        popMatrix();
      }
    }
  }
}

void drawPetal() {
  float h = height/8;
  line(0,0,0, -h);
  translate(0, -h);
  branch(h);
  translate(0, h);
}

// --- Interactions ---
void keyPressed() {
  if(key == ' ') {
    timestamp = year() + nf(month(),2) + nf(day(),2) + "-" + nf(hour(),2) + nf(minute(),2) + nf(second(),2);
    saveFrame(timestamp+".png");
  }
  
  if(key == CODED) {
    if (keyCode == UP) {
      noPetals++;
    }
    if (keyCode == DOWN) {
      noPetals--;
    }
    if (keyCode == LEFT) {
      branchFactor--;
    }
    if (keyCode == RIGHT) {
      branchFactor++;
    }
  }
}
