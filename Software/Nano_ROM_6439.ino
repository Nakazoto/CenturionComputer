int AD0 = 9;
int AD1 = 8;
int AD2 = 7;
int AD3 = 6;
int AD4 = 5;
int AD5 = 4;
int AD6 = 3;
int AD7 = 2;
int AD8 = 10;
int AD9 = 11;
int AD10 = 12;
int AD11 = 13;

int DO0 = 21;
int DO1 = 20;
int DO2 = 19;
int DO3 = 14;
int DO4 = 15;
int DO5 = 16;
int DO6 = 17;
int DO7 = 18;

int b0 = 0;
int b1 = 0;
int b2 = 0;
int b3 = 0;
int b4 = 0;
int b5 = 0;
int b6 = 0;
int b7 = 0;
int b8 = 0;
int b9 = 0;
int b10 = 0;
int b11 = 0;

int nl = 0;
  
void setup() {
  Serial.begin(19200); 
  
  pinMode(AD0, OUTPUT);       //D9 and Address AD0
  pinMode(AD1, OUTPUT);       //D8 and Address AD1
  pinMode(AD2, OUTPUT);       //D7 and Address AD2
  pinMode(AD3, OUTPUT);       //D6 and Address AD3
  pinMode(AD4, OUTPUT);       //D5 and Address AD4
  pinMode(AD5, OUTPUT);       //D4 and Address AD5
  pinMode(AD6, OUTPUT);       //D3 and Address AD6
  pinMode(AD7, OUTPUT);       //D2 and Address AD7
  pinMode(AD8, OUTPUT);       //D10 and Address AD8
  pinMode(AD9, OUTPUT);       //D11 and Address AD9
  pinMode(AD10, OUTPUT);      //D12 and Address AD10
  pinMode(AD11, OUTPUT);      //D12 and Address AD10
  
  pinMode(DO0, INPUT);       //D21 and DataOut DO0
  pinMode(DO1, INPUT);       //D20 and DataOut DO1
  pinMode(DO2, INPUT);       //D19 and DataOut DO2
  pinMode(DO3, INPUT);       //D14 and DataOut DO3
  pinMode(DO4, INPUT);       //D15 and DataOut DO4
  pinMode(DO5, INPUT);       //D16 and DataOut DO5
  pinMode(DO6, INPUT);       //D17 and DataOut DO6
  pinMode(DO7, INPUT);       //D18 and DataOut DO7
  
}

void loop() {
  digitalWrite(AD0, LOW);
  digitalWrite(AD1, LOW);
  digitalWrite(AD2, LOW);
  digitalWrite(AD3, LOW);
  digitalWrite(AD4, LOW);
  digitalWrite(AD5, LOW);
  digitalWrite(AD6, LOW);
  digitalWrite(AD7, LOW);
  digitalWrite(AD8, LOW);
  digitalWrite(AD9, LOW);
  digitalWrite(AD10, LOW);
  digitalWrite(AD11, LOW);
  
  Serial.println();
  Serial.println("Press button to begin.");
  delay(1000);

    //Start count for entire address range
    for (int i = 0; i < 512; i++) {  
      //Get each bit value from address
      b0 = bitRead(i, 0);
      b1 = bitRead(i, 1);
      b2 = bitRead(i, 2);
      b3 = bitRead(i, 3);
      b4 = bitRead(i, 4);
      b5 = bitRead(i, 5);
      b6 = bitRead(i, 6);
      b7 = bitRead(i, 7);
      b8 = bitRead(i, 8);
      b9 = bitRead(i, 9);
      b10 = bitRead(i, 10);
      b11 = bitRead(i, 11);

      //Assign bit value to actual address line to ROM
      if (b0 == 1) {digitalWrite(AD0, HIGH);} else {digitalWrite(AD0, LOW);}
      if (b1 == 1) {digitalWrite(AD1, HIGH);} else {digitalWrite(AD1, LOW);}
      if (b2 == 1) {digitalWrite(AD2, HIGH);} else {digitalWrite(AD2, LOW);}
      if (b3 == 1) {digitalWrite(AD3, HIGH);} else {digitalWrite(AD3, LOW);}
      if (b4 == 1) {digitalWrite(AD4, HIGH);} else {digitalWrite(AD4, LOW);}
      if (b5 == 1) {digitalWrite(AD5, HIGH);} else {digitalWrite(AD5, LOW);}
      if (b6 == 1) {digitalWrite(AD6, HIGH);} else {digitalWrite(AD6, LOW);}
      if (b7 == 1) {digitalWrite(AD7, HIGH);} else {digitalWrite(AD7, LOW);}
      if (b8 == 1) {digitalWrite(AD8, HIGH);} else {digitalWrite(AD8, LOW);}
      if (b9 == 1) {digitalWrite(AD9, HIGH);} else {digitalWrite(AD9, LOW);}
      if (b10 == 1) {digitalWrite(AD10, HIGH);} else {digitalWrite(AD10, LOW);}
      if (b11 == 1) {digitalWrite(AD11, HIGH);} else {digitalWrite(AD11, LOW);}

      //Delay to let chip stabilize
      delay(10);

      //Read contents of ROM
      int sum = 0;
      if (digitalRead(DO0) == HIGH) {sum += 1;}
      if (digitalRead(DO1) == HIGH) {sum += 2;}
      if (digitalRead(DO2) == HIGH) {sum += 4;}
      if (digitalRead(DO3) == HIGH) {sum += 8;}
      if (digitalRead(DO4) == HIGH) {sum += 16;}
      if (digitalRead(DO5) == HIGH) {sum += 32;}
      if (digitalRead(DO6) == HIGH) {sum += 64;}
      if (digitalRead(DO7) == HIGH) {sum += 128;}

      //Print data to Serial
      if (nl >= 32) {
        nl = 0;
        Serial.println(); 
      }
      
      if (sum < 16) {Serial.print("0");}
      Serial.print(sum, HEX);
      if (nl < 32) {Serial.print(" ");}
      
      nl++;

      //Delay to let ROM output stabilize
      delay(1);      
  }
}
