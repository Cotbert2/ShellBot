#include <SoftwareSerial.h>
SoftwareSerial btModule(10,11);
 
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  btModule.begin(9600);
  pinMode(7,OUTPUT);
  pinMode(6,OUTPUT);
  pinMode(5,OUTPUT);
  pinMode(4,OUTPUT);
  pinMode(12,OUTPUT);
  pinMode(3,OUTPUT);
  pinMode(8,OUTPUT);
  pinMode(2,INPUT);

  digitalWrite(8,true);
}

void left(){
  digitalWrite(7,true);
  digitalWrite(6,false);
  digitalWrite(5,true);
  digitalWrite(4,false);
}
void right(){
  digitalWrite(7,false);
  digitalWrite(6,true);
  digitalWrite(5,false);
  digitalWrite(4,true);
}

void backward(){
  digitalWrite(7,true);
  digitalWrite(6,false);
  digitalWrite(5,false);
  digitalWrite(4,true);
}
void forward(){
  digitalWrite(7,false);
  digitalWrite(6,true);
  digitalWrite(5,true);
  digitalWrite(4,false);
}

void loop() {
  // put your main code here, to run repeatedly:-            

  //ultrasonic
  long t,d;

  digitalWrite(3,true);

  delayMicroseconds(10);
  digitalWrite(3,false);
  t = pulseIn(2,true);
  d = t/59;

  btModule.println(d);

  if(btModule.available() > 0){
    char c = btModule.read();
    Serial.println(c);

    switch(c){
      case 'a':
        forward();
      break;
      case 'r':
        backward();
      break;
      case 'd':
        right();
      break;
      case 'i':
        left();
      break;
      default:
        digitalWrite(7,false);
        digitalWrite(6,false);
        digitalWrite(5,false);
        digitalWrite(4,false);
      break;
    }

  }
}
