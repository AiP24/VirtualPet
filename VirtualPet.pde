int WIDTH = 500;
int HEIGHT = 500;
int[] xy = new int[2]; //will be reused later
//int[] relToAbs(float xPos, float yPos) {
//    int coords[] = new int[]{Math.round(WIDTH*xPos), Math.round(HEIGHT*yPos)};
//    return coords;
//}
int rtw(float xPos) { //Relative to width
    return Math.round(WIDTH*xPos);
}
int rth(float yPos) { //Relative to height
    return Math.round(HEIGHT*yPos);
}
//can't use variables in the size function
void setup() {
  size(500, 500);
}
void draw() {
  noStroke();
  fill(255, 255, 255);
  triangle(rtw(.25), rth(.1), rtw(.2), rth(.4), rtw(.35), rth(.3));
}
