int WIDTH = 500;
int HEIGHT = 500;
int[] xy = new int[2]; //will be reused later
PShape head;
//int[] relToAbs(float xPos, float yPos) {
//    int coords[] = new int[]{Math.round(WIDTH*xPos), Math.round(HEIGHT*yPos)};
//    return coords;
//}
int rw(float xPos) { //Relative to width
    return Math.round(WIDTH*xPos);
}
int rh(float yPos) { //Relative to height
    return Math.round(HEIGHT*yPos);
}
//can't use variables in the size function
void setup() {
  size(500, 500);
  //temporary
  PImage bg = loadImage("sukon.png");
  bg.resize(WIDTH, HEIGHT);
  background(bg);

  head = createShape();
  head.beginShape();
  //1&2 - anchor 1 (start point)
  //3&4 - control 1 (guide 1)
  //5&6 - control 2 (guide 2)
  //7&8 - anchor 2 (end point)
  bezier(rw(.2), rh(.6), rw(.25), rh(.25), rw(.75), rh(.25), rw(.71), rh(.6));
  bezier(rw(.2), rh(.6), rw(.3), rh(.75), rw(.6), rh(.75), rw(.71), rh(.6));
  // bezier(rw(.2), rh(.6), rw(.2), rh(.3), rw(.7), rh(.3), rw(.7), rh(.6));
  //bezier(rw(.1), rh(.4), rw(.2), rh(.6), rw(.8), rh(.6), rw(.9), rh(.4));
  head.endShape(CLOSE);
}
void draw() {
  // noStroke();
  fill(255, 255, 255);
  triangle(rw(.3), rh(.1), rw(.23), rh(.5), rw(.4), rh(.4));
  triangle(rw(.65), rh(.14), rw(.7), rh(.5), rw(.5), rh(.4));
  shape(head);
}
