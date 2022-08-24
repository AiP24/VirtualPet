static int WIDTH = 500;
static int HEIGHT = 500;
int rw(float xPos) { //Relative to Width
    return Math.round(WIDTH*xPos);
}
int rh(float yPos) { //Relative to Height
    return Math.round(HEIGHT*yPos);
}
void drawHead() {
  //I would have used PShape and createShape() but processing.js is outdated and I don't feel like migrating to p5.js
  bezier(rw(.2), rh(.6), rw(.25), rh(.25), rw(.75), rh(.25), rw(.71), rh(.6));
  bezier(rw(.2), rh(.6), rw(.3), rh(.75), rw(.6), rh(.75), rw(.71), rh(.6));
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
  // noStroke();
  fill(255, 255, 255);
  triangle(rw(.3), rh(.1), rw(.23), rh(.5), rw(.4), rh(.4));
  triangle(rw(.65), rh(.14), rw(.7), rh(.5), rw(.5), rh(.4));
  drawHead();
}
