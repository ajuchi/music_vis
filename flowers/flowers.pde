import ddf.minim.*;
import ddf.minim.analysis.*;

// Fractal Flower
// * adapted from Fractal Flower project by user morphogen
// * from: https://www.openprocessing.org/sketch/64159/

// --- Global Variables ---
String timestamp;
float theta;
float counter = 0;
float noPetals = 8;
float reductionFactor = 0.66;
float cutOff = 10; // slows down if cutOff < 2
float branchFactor = 1; // slows down if branchFactor > 2

// minim object variables
Minim minim;
AudioPlayer song;

// --- Setup ---
void setup() {
  size(800, 800);
  frameRate(60);
  stroke(#fcbf49);
  background(#003049);
  
  // minim setup
  minim = new Minim(this);
  // loads sound file
  song = minim.loadFile("julia_florida_EDIT.mp3", 4096);
  
  // plays file
  song.play(0);
}

// --- Main Loop ---
void draw() {
  background(#003049);
  // increase angle by one
  counter += (song.right.level()+song.left.level())/2 * 10;
  theta = radians(counter);
  
  // move origin to center of screen
  translate(width/2, height/2);
  //translate(0,height);
  // draw petals, rotating by PI/(noPetals/2) each time
  for(int i = 0; i < noPetals; i++) {
    drawPetal();
    rotate(PI / noPetals*2);
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
/*
void keyPressed() {
  // screenshot
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
*/
