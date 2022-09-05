#include <ArduinoJson.h>

#include <Adafruit_CircuitPlayground.h>
#include <Adafruit_Circuit_Playground.h>

int accelX;
int accelY;
int accelZ;
int light;
int sound;
int temp;
String jdat;
const size_t CAPACITY = JSON_OBJECT_SIZE(6);

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  CircuitPlayground.begin();
}

void loop() {
  // put your main code here, to run repeatedly:
  StaticJsonDocument<CAPACITY> doc;
  JsonObject object = doc.to<JsonObject>();
  object["light"] = analogRead(5);//lightSensor function acts funny
  object["accelX"] = CircuitPlayground.motionX();
  object["accelY"] = CircuitPlayground.motionY();
  object["accelZ"] = CircuitPlayground.motionZ();
  object["sound"] = CircuitPlayground.soundSensor();
  object["temp"] = CircuitPlayground.temperatureF();
  jdat = "";
  serializeJson(doc, jdat);
  Serial.print(jdat);
  Serial.print("\n");
}
