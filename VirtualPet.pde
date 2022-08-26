static int WIDTH = 500;
static int HEIGHT = 500;
static int STROKE = rw(.015);
static int rw(float xPos) { //Relative to Width
  return Math.round(WIDTH*xPos);
}
static int rh(float yPos) { //Relative to Height
  return Math.round(HEIGHT*yPos);
}
void drawLeft() {
  beginShape(POLYGON);
  vertex(rw(.35), rh(.72));
  vertex(rw(.25), rh(.7));
  bezierVertex(rw(.2), rh(.68), rw(.2), rh(.75), rw(.22), rh(.75));
  vertex(rw(.35), rh(.775));
  endShape();
}
void drawHead() {
  //I would have used PShape and createShape() but processing.js is outdated and I don't feel like migrating to p5.js
  /*
  bezier(1st point, 1st control, 2nd control, 2nd point)
   */
  bezier(rw(.2), rh(.6), rw(.25), rh(.25), rw(.75), rh(.25), rw(.71), rh(.6));
  bezier(rw(.2), rh(.6), rw(.3), rh(.75), rw(.6), rh(.75), rw(.71), rh(.6));
  stroke(0, 0, 0);
  strokeWeight(STROKE);
  bezier(rw(.375), rh(.425), rw(.37), rh(.43), rw(.35), rh(.49), rw(.35), rh(.51)); //right eye
  bezier(rw(.56), rh(.425), rw(.555), rh(.43), rw(.54), rh(.5), rw(.54), rh(.51)); //left eye

  fill(254, 150, 141);
  beginShape(POLYGON);
  vertex(rw(.405), rh(.54));
  bezierVertex(rw(.405), rh(.65), rw(.48), rh(.65), rw(.48), rh(.55));
  vertex(rw(.44), rh(.5));
  endShape();

  fill(255, 255, 255);
  beginShape(POLYGON);
  vertex(rw(.4), rh(.49));
  bezierVertex(rw(.38), rh(.54), rw(.4), rh(.56), rw(.44), rh(.5));
  bezierVertex(rw(.45), rh(.56), rw(.5), rh(.56), rw(.5), rh(.505));
  endShape();
}
void drawBody() {
  //inc
  beginShape(POLYGON);
  vertex(rw(.35), rh(.7));
  vertex(rw(.35), rh(.76));
  //bezierVertex(anchor1, anchor2, point)
  bezierVertex(rw(.36), rh(.7), rw(.34), rh(.95), rw(.35), rh(.9)); //left hip 1
  bezierVertex(rw(.34), rh(.95), rw(.35), rh(.98), rw(.37), rh(.98)); //left foot
  bezierVertex(rw(.4), rh(.985), rw(.4), rh(.98), rw(.4), rh(.91)); //left hip 2
  bezierVertex(rw(.45), rh(.92), rw(.5), rh(.92), rw(.58), rh(.9)); //right hip 1
  bezierVertex(rw(.585), rh(.97), rw(.585), rh(.98), rw(.6), rh(.98)); //right foot
  bezierVertex(rw(.64), rh(.97), rw(.64), rh(.95), rw(.64), rh(.89)); //right hip 2
  bezierVertex(rw(.65), rh(.88), rw(.7), rh(.88), rw(.65), rh(.78)); //right arm
  bezierVertex(rw(.7), rh(.78), rw(.72), rh(.8), rw(.75), rh(.75)); //right hand
  bezierVertex(rw(.7), rh(.73), rw(.64), rh(.7), rw(.64), rh(.64)); //right shoulder/neck
  endShape();
}
void drawTail() {
  beginShape(POLYGON);
  vertex(rw(.66), rh(.75));
  bezierVertex(rw(.7), rh(.75), rw(.8), rh(.75), rw(.8), rh(.57)); //top tuft
  bezierVertex(rw(.82), rh(.6), rw(.83), rh(.63), rw(.84), rh(.7)); //1st inside
  bezierVertex(rw(.85), rh(.7), rw(.88), rh(.67), rw(.88), rh(.6)); //2nd tuft
  bezierVertex(rw(.9), rh(.7), rw(.88), rh(.76), rw(.88), rh(.76)); //2nd inside
  bezierVertex(rw(.9), rh(.78), rw(.93), rh(.76), rw(.95), rh(.75)); //3rd tuft
  bezierVertex(rw(.9), rh(.9), rw(.75), rh(.85), rw(.65), rh(.85)); //end
  endShape();
}
void setup() {
  //can't use variables in the size function
  //please hardcode to match WIDTH and HEIGHT
  size(500, 500);
  //temporary
  //PImage bg = loadImage("sukon.png");
  //bg.resize(WIDTH, HEIGHT);
  background(50, 50, 50);
}
void draw() {
  strokeWeight(STROKE);
  fill(255, 255, 255);
  triangle(rw(.3), rh(.1), rw(.23), rh(.5), rw(.4), rh(.4));
  triangle(rw(.65), rh(.14), rw(.7), rh(.5), rw(.5), rh(.4));
  strokeWeight(0);
  fill(0, 0, 0);
  triangle(rw(.305), rh(.2), rw(.27), rh(.48), rw(.35), rh(.38));
  triangle(rw(.635), rh(.2), rw(.68), rh(.6), rw(.51), rh(.45));
  strokeWeight(STROKE);
  fill(255, 255, 255);
  drawLeft();
  drawTail();
  drawBody();
  drawHead();
}
