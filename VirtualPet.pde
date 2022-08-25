static int WIDTH = 500;
static int HEIGHT = 500;
int rw(float xPos) { //Relative to Width
  return Math.round(WIDTH*xPos);
}
int rh(float yPos) { //Relative to Height
  return Math.round(HEIGHT*yPos);
}
void drawLeft() {
  beginShape(POLYGON);
  vertex(rw(.25), rh(.7));
  vertex(rw(.35), rh(.72));
  vertex(rw(.35), rh(.775));
  vertex(rw(.25), rh(.75)); //left arm, fix border
  endShape();
  bezier(rw(.25), rh(.7), rw(.225), rh(.7), rw(.225), rh(.75), rw(.25), rh(.75));
}
void drawHead() {
  //I would have used PShape and createShape() but processing.js is outdated and I don't feel like migrating to p5.js
  /*
  bezier(1st point, 1st control, 2nd control, 2nd point)
   */
  bezier(rw(.2), rh(.6), rw(.25), rh(.25), rw(.75), rh(.25), rw(.71), rh(.6));
  bezier(rw(.2), rh(.6), rw(.3), rh(.75), rw(.6), rh(.75), rw(.71), rh(.6));
  stroke(0, 0, 0);
  strokeWeight(rw(.02));
  bezier(rw(.375), rh(.425), rw(.37), rh(.43), rw(.35), rh(.49), rw(.35), rh(.51)); //right eye
  bezier(rw(.56), rh(.425), rw(.555), rh(.43), rw(.54), rh(.5), rw(.54), rh(.51)); //left eye
}
void drawBody() {
  //inc
  beginShape(POLYGON);
  vertex(rw(.35), rh(.7));
  vertex(rw(.35), rh(.76));
  bezierVertex(rw(.36), rh(.7), rw(.34), rh(.95), rw(.35), rh(.9));
  bezierVertex(rw(.34), rh(.95), rw(.35), rh(.98), rw(.37), rh(.98));
  bezierVertex(rw(.4), rh(.985), rw(.4), rh(.98), rw(.4), rh(.91));
  bezierVertex(rw(.45), rh(.92), rw(.5), rh(.92), rw(.58), rh(.9));
  bezierVertex(rw(.585), rh(.97), rw(.585), rh(.98), rw(.6), rh(.98));
  bezierVertex(rw(.64), rh(.97), rw(.62), rh(.91), rw(.62), rh(.9));
  bezierVertex(rw(.65), rh(.88), rw(.7), rh(.88), rw(.65), rh(.78));
  bezierVertex(rw(.7), rh(.78), rw(.72), rh(.8), rw(.75), rh(.75));
  bezierVertex(rw(.7), rh(.78), rw(.72), rh(.8), rw(.64), rh(.67));
  endShape();
}
void setup() {
  //can't use variables in the size function
  //please hardcode to match WIDTH and HEIGHT
  size(500, 500);
  //temporary
  PImage bg = loadImage("sukon.png");
  bg.resize(WIDTH, HEIGHT);
  //background(bg);
}
void draw() {
  //strokeWeight(rw(.02));
  strokeWeight(3);
  fill(255, 255, 255);
  triangle(rw(.3), rh(.1), rw(.23), rh(.5), rw(.4), rh(.4));
  triangle(rw(.65), rh(.14), rw(.7), rh(.5), rw(.5), rh(.4));
  drawHead();
  strokeWeight(3);
  //drawLeft();
  drawBody();
}
