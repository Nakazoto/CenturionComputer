const int clk = 13;
const int rst = 12;

const int d0 = 2;
const int d1 = 3;
const int d2 = 4;
const int d3 = 5;
const int d4 = 6;
const int d5 = 7;
const int d6 = 8;
const int d7 = 9;

int cnt = 0;
int nl = 0;

void setup() {
  Serial.begin(9600);
  pinMode (clk, OUTPUT);
  pinMode (rst, INPUT);
  pinMode (d0, INPUT);
  pinMode (d1, INPUT);
  pinMode (d2, INPUT);
  pinMode (d3, INPUT);
  pinMode (d4, INPUT);
  pinMode (d5, INPUT);
  pinMode (d6, INPUT);
  pinMode (d7, INPUT);
  digitalWrite(clk, LOW);
}

void loop() {

  if (digitalRead(rst) == HIGH) {
    //4096 = 12bits, 2048 = 11bits, 1024 = 10bits, 512 = 9bits, 256 = 8bits
    if (cnt < 256) {

      cnt++;
      
      int sum = 0;
      if (digitalRead(d0) == HIGH) {sum += 1;}
      if (digitalRead(d1) == HIGH) {sum += 2;}
      if (digitalRead(d2) == HIGH) {sum += 4;}
      if (digitalRead(d3) == HIGH) {sum += 8;}
      if (digitalRead(d4) == HIGH) {sum += 16;}
      if (digitalRead(d5) == HIGH) {sum += 32;}
      if (digitalRead(d6) == HIGH) {sum += 64;}
      if (digitalRead(d7) == HIGH) {sum += 128;}

      if (nl >= 8) {
        nl = 0;
        Serial.println(); 
      }
      
      if (sum < 16) {Serial.print("0");}
      Serial.print(sum, HEX);
      if (nl < 7) {Serial.print(" ");}
      
      nl++;
     
      digitalWrite(clk, HIGH);
      delay(1);
      digitalWrite(clk, LOW);
      delay(1);
      
    } else {
      delay (1000);
    }
    
  } else {
    Serial.println();
    Serial.print("Break");
    Serial.println();
    cnt = 0;
    nl = 0;
    delay (1000);
  }
}
