#include <SoftwareSerial.h>

SoftwareSerial miBt(10,11);

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial.println("Already");

  miBt.begin(38400);

}

void loop() {
  // put your main code here, to run repeatedly:

  if(miBt.available()){
    Serial.write(miBt.read());
  }

  if(Serial.available())
  miBt.write(Serial.read());
}
