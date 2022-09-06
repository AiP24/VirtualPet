import processing.serial.*;
Serial serial;
//Arduino code moved to Arduino C to make use of the CircuitPlayground library

static int WIDTH = 500;
static int HEIGHT = 500;
static int STROKE = Math.round(WIDTH*.015);
static float LIGHTMAX = 50;
float tailRotate;
float tailX;
float tailY;
float accelX;
float accelY;
float accelZ;
float light;
float sound;
String rawJson = "";
int temp;
int bg;
float accelZOffset = 0;
float accelYOffset;

static int trw(float xPos) { //Relative to Width
  return Math.round(WIDTH*xPos);
}
static int trh(float yPos) { //Relative to Height
  return Math.round(HEIGHT*yPos);
}
static int rw(float xPos) { //Relative to Width
  return Math.round(WIDTH*xPos)-(WIDTH/2);
}
static int rh(float yPos) { //Relative to Height
  return Math.round(HEIGHT*yPos)-(HEIGHT/2);
}
//for debugging without an actual arduino
boolean arduinoEnabled = true;
void drawLeft() {
  beginShape(POLYGON);
  vertex(rw(.35), rh(.72));
  vertex(rw(.25), rh(.7));
  bezierVertex(rw(.2), rh(.68), rw(.2), rh(.75), rw(.22), rh(.75));
  vertex(rw(.35), rh(.775));
  endShape();
}
void drawHead(boolean eyeMode) {
  //I would have used PShape and createShape() but processing.js is outdated and I don't feel like migrating to p5.js
  /*
  bezier(1st point, 1st control, 2nd control, 2nd point)
   */
  bezier(rw(.2), rh(.6), rw(.25), rh(.25), rw(.75), rh(.25), rw(.71), rh(.6));
  bezier(rw(.2), rh(.6), rw(.3), rh(.75), rw(.6), rh(.75), rw(.71), rh(.6));
  stroke(0, 0, 0);
  strokeWeight(STROKE);
  if (eyeMode) {
    bezier(rw(.375), rh(.425), rw(.37), rh(.43), rw(.35), rh(.49), rw(.35), rh(.51)); //right eye
    bezier(rw(.56), rh(.425), rw(.555), rh(.43), rw(.54), rh(.5), rw(.54), rh(.51)); //left eye
  } else {
    beginShape(POLYGON);
    vertex(rw(.35), rh(.42));
    vertex(rw(.4), rh(.45));
    vertex(rw(.35), rh(.5));
    endShape();
    beginShape(POLYGON);
    vertex(rw(.56), rh(.42));
    vertex(rw(.5), rh(.45));
    vertex(rw(.56), rh(.5));
    endShape();
  } //else if (eyeMode == 2) {
    
  //}
  
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
  serial = new Serial(this, Serial.list()[0], 9600);
}
void drawEars() {
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
}
void draw() {
  if ( serial.available() > 0){
    System.out.println("_");
    rawJson = serial.readStringUntil('\n');
    if (rawJson == null || rawJson.equals("") || rawJson.equals("\n")) {System.out.println("NO DATA"); return;}
    serial.clear();
    System.out.println(rawJson);
    JSONObject jsonData = parseJSONObject(rawJson);
    light = jsonData.getInt("light");
    sound = jsonData.getInt("sound");
    temp = jsonData.getInt("temp");
    accelX = jsonData.getFloat("accelX");
    accelY = jsonData.getFloat("accelY");
    accelZ = jsonData.getFloat("accelZ") - 9.7; //gravity
    System.out.print(accelX + " " + accelY + " " + accelZ + "\n");
    System.out.print(light + " " + sound + " " + temp + "\n");
  } else {return;}
  bg = Math.round(255*(((light > LIGHTMAX) ? LIGHTMAX : light)/LIGHTMAX));
  background(bg, bg, bg);
  fill(170, 170, 190);
  noStroke();
  rect(0, HEIGHT-trh(.2), WIDTH, HEIGHT);
  stroke(0, 0, 0);
  fill(255, 255, 255);
  //if (abs(accelY) > 10) {
  //  accelYOffset = ((abs(accelY) - 10)/10)*(WIDTH*((accelY >= 0) ? .5: -.5));
  //  //rotate(radians(((accelY - 10) / 10) * 45)); //doesn't work very well
  //} else accelYOffset = 0;
  //if (abs(accelZ) > 10) {
  //  accelZOffset = ((abs(accelZ) - 10)/15)*(HEIGHT*((accelZ >= 0) ? -.5: .5)); //height opposite direction from IRL
  //} else accelZOffset = 0;
  accelYOffset = (abs(accelY) > 1.5) ? (abs(accelY) / 20) * (WIDTH*((accelY >= 0) ? .5: -.5)) : 0;
  translate(WIDTH/2.0+accelYOffset, HEIGHT/2.0+accelZOffset);
  drawEars();
  drawLeft();
  tailRotate = 90-90*(((light > LIGHTMAX) ? LIGHTMAX : light)/LIGHTMAX);
  tailX = tailRotate/90.0*trw(.4);
  tailY = tailRotate/90.0*trh(.1);
  //System.out.println(String.format("%f %f", tailX, tailY));
  translate(tailX, tailY);
  rotate(radians(tailRotate));
  drawTail();
  rotate(radians(-tailRotate));
  translate(-tailX, -tailY);
  drawBody();
  drawHead(light > LIGHTMAX*(3.0/4) && abs(accelY) < 1.5 && abs(accelZ) < 1.5);
}
