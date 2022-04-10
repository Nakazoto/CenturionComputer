#include "instruction.h"
#include <iostream>
#include <bitset>
#include <stdlib.h>
using namespace std;

instruction::instruction(string opCode, string Ri, string Rj, string iw2, int lineNum){
	//Set defaults
	Op = 0b00000001;
	A = Ri;
	B = Rj;
	off = iw2;
	Mem = "";
	Len = 1;
	sourceLine = lineNum;

	//Assign correct OpCode
	//HLT & NOP
	if(opCode == "HLT"){
		Op = Op | 0b00000000;
	}
	else if(opCode == "NOP"){
		Op = Op | 0b00000001;
	}
	//Flags
	else if(opCode == "FSN"){
		Op = Op | 0b00000010;
	}
	else if(opCode == "FCN"){
		Op = Op | 0b00000010;
	}
	else if(opCode == "FSI"){
		Op = Op | 0b00000100;
	}
	else if(opCode == "FSC"){
		Op = Op | 0b00000110;
	}
	else if(opCode == "FCC"){
		Op = Op | 0b00000111;
	}
	else if(opCode == "FCA"){
		Op = Op | 0b00001000;
	}
	//RET & RETI
	else if(opCode == "RET"){
		Op = Op | 0b00001001;
	}
	else if(opCode == "RETI"){
		Op = Op | 0b00001010;
	}
	//Delay
	else if(opCode == "DLY"){
		Op = Op | 0b00001110;
	}
	//Branch
	else if(opCode == "BCS"){
		Op = Op | 0b00010000;
		Len = 2;
		off = A;
	}
	else if(opCode == "BCC"){
		Op = Op | 0b00010001;
		Len = 2;
		off = A;
	}
	else if(opCode == "BNS"){
		Op = Op | 0b00010010;
		Len = 2;
		off = A;
	}
	else if(opCode == "BNC"){
		Op = Op | 0b00010011;
		Len = 2;
		off = A;
	}
	else if(opCode == "BZS"){
		Op = Op | 0b00010100;
		Len = 2;
		off = A;
	}
	else if(opCode == "BZC"){
		Op = Op | 0b00010101;
		Len = 2;
		off = A;
	}
	else if(opCode == "BLT"){
		Op = Op | 0b00010110;
		Len = 2;
		off = A;
	}
	else if(opCode == "BGE"){
		Op = Op | 0b00010111;
		Len = 2;
		off = A;
	}
	else if(opCode == "BGT"){
		Op = Op | 0b00011000;
		Len = 2;
		off = A;
	}
	else if(opCode == "BLE"){
		Op = Op | 0b00011001;
		Len = 2;
		off = A;
	}
	else if(opCode == "BS1"){
		Op = Op | 0b00011010;
		Len = 2;
		off = A;
	}
	else if(opCode == "BS2"){
		Op = Op | 0b00011011;
		Len = 2;
		off = A;
	}
	else if(opCode == "BS3"){
		Op = Op | 0b00011100;
		Len = 2;
		off = A;
	}
	else if(opCode == "BS4"){
		Op = Op | 0b00011101;
		Len = 2;
		off = A;
	}
	//INC
	else if(opCode == "INC"){
		//Opcode
		if(A == "AL"){
			Op = Op | 0b00101000;
		}
		else if(A == "AX"){
			Op = Op | 0b00111000;
		}
		else if(A == "RT"){
			Op = Op | 0b00111110;
		}
		else if(A[1] == 'X'){
			Op = Op | 0b00110000;
			Len = 2;
		}
		else if(A[1] == 'H' || A[1] == 'L'){
			Op = Op | 0b00100000;
			Len = 2;
		}
		else{
			error(1);
		}
		//Register
		if(Len == 2){
			off = "B" + RegisterNibble(A);
		}
	}
	//DEC
	else if(opCode == "DEC"){
		//Opcode
		if(A == "AL"){
			Op = Op | 0b00101001;
		}
		else if(A == "AX"){
			Op = Op | 0b00111001;
		}
		else if(A == "RT"){
			Op = Op | 0b00111111;
		}
		else if(A[1] == 'X'){
			Op = Op | 0b00110001;
			Len = 2;
		}
		else if(A[1] == 'H' || A[1] == 'L'){
			Op = Op | 0b00100001;
			Len = 2;
		}
		else{
			error(1);
		}
		//Register
		if(Len == 2){
			off = "B" + RegisterNibble(A);
		}
	}
	//CLR
	else if(opCode == "CLR"){
		//Opcode
		if(A == "AL"){
			Op = Op | 0b00101010;
		}
		else if(A == "AX"){
			Op = Op | 0b00111010;
		}
		else if(A[1] == 'X'){
			Op = Op | 0b00110010;
			Len = 2;
		}
		else if(A[1] == 'H' || A[1] == 'L'){
			Op = Op | 0b00100010;
			Len = 2;
		}
		else{
			error(1);
		}
		//Register
		if(Len == 2){
			off = "B" + RegisterNibble(A);
		}
	}
	//NOT
	else if(opCode == "NOT"){
		//Opcode
		if(A == "AL"){
			Op = Op | 0b00101011;
		}
		else if(A == "AX"){
			Op = Op | 0b00111011;
		}
		else if(A[1] == 'X'){
			Op = Op | 0b00110011;
			Len = 2;
		}
		else if(A[1] == 'H' || A[1] == 'L'){
			Op = Op | 0b00100011;
			Len = 2;
		}
		else{
			error(1);
		}
		//Register
		if(Len == 2){
			off = "B" + RegisterNibble(A);
		}
	}
	//LSL
	else if(opCode == "LSL"){
		//Opcode
		if(A == "AL"){
			Op = Op | 0b00101100;
		}
		else if(A == "AX"){
			Op = Op | 0b00111100;
		}
		else if(A[1] == 'X'){
			Op = Op | 0b00110100;
			Len = 2;
		}
		else if(A[1] == 'H' || A[1] == 'L'){
			Op = Op | 0b00100100;
			Len = 2;
		}
		else{
			error(1);
		}
		//Register
		if(Len == 2){
			off = "B" + RegisterNibble(A);
		}
	}
	//LSR
	else if(opCode == "LSR"){
		//Opcode
		if(A == "AL"){
			Op = Op | 0b00101101;
		}
		else if(A == "AX"){
			Op = Op | 0b00111101;
		}
		else if(A[1] == 'X'){
			Op = Op | 0b00110101;
			Len = 2;
		}
		else if(A[1] == 'H' || A[1] == 'L'){
			Op = Op | 0b00100101;
			Len = 2;
		}
		else{
			error(1);
		}
		//Register
		if(Len == 2){
			off = "B" + RegisterNibble(A);
		}
	}
	//ADD
	else if(opCode == "ADD"){
		//Opcode
		if(A == "BL" && B == "AL"){
			Op = Op | 0b01001000;
		}
		else if(A == "BX" && B == 'AX'){
			Op = Op | 0b01011000;
		}
		else if(A[1] == 'X' && B[1] == 'X'){
			Op = Op | 0b01010000;
			Len = 2;
		}
		else if((A[1] == 'H' || A[1] == 'L') && (B[1] == 'H' || B[1] == 'L')){
			Op = Op | 0b01000000;
			Len = 2;
		}
		else{
			error(2);
		}
		//Register
		if(Len == 2){
			off = "B" + RegisterNibble(A) + RegisterNibble(B);
		}
	}
	//SUB
	else if(opCode == "SUB"){
		//Opcode
		if(A == "BL" && B == "AL"){
			Op = Op | 0b01001001;
		}
		else if(A == "BX" && B == 'AX'){
			Op = Op | 0b01011001;
		}
		else if(A[1] == 'X' && B[1] == 'X'){
			Op = Op | 0b01010001;
			Len = 2;
		}
		else if((A[1] == 'H' || A[1] == 'L') && (B[1] == 'H' || B[1] == 'L')){
			Op = Op | 0b01000001;
			Len = 2;
		}
		else{
			error(2);
		}
		//Register
		if(Len == 2){
			off = "B" + RegisterNibble(A) + RegisterNibble(B);
		}
	}
	//AND
	else if(opCode == "AND"){
		//Opcode
		if(A == "BL" && B == "AL"){
			Op = Op | 0b01001010;
		}
		else if(A == "BX" && B == 'AX'){
			Op = Op | 0b01011010;
		}
		else if(A[1] == 'X' && B[1] == 'X'){
			Op = Op | 0b01010010;
			Len = 2;
		}
		else if((A[1] == 'H' || A[1] == 'L') && (B[1] == 'H' || B[1] == 'L')){
			Op = Op | 0b01000010;
			Len = 2;
		}
		else{
			error(2);
		}
		//Register
		if(Len == 2){
			off = "B" + RegisterNibble(A) + RegisterNibble(B);
		}
	}
	//OR
	else if(opCode == "OR"){
		//Opcode
		if(A == "BL" && B == "AL"){
			Op = Op | 0b01001011;
		}
		else if(A == "BX" && B == 'AX'){
			Op = Op | 0b01011011;
		}
		else if(A[1] == 'X' && B[1] == 'X'){
			Op = Op | 0b01010011;
			Len = 2;
		}
		else if((A[1] == 'H' || A[1] == 'L') && (B[1] == 'H' || B[1] == 'L')){
			Op = Op | 0b01000011;
			Len = 2;
		}
		else{
			error(2);
		}
		//Register
		if(Len == 2){
			off = "B" + RegisterNibble(A) + RegisterNibble(B);
		}
	}
	//XOR
	else if(opCode == "XOR"){
		//Opcode
		if(A == "BL" && B == "AL"){
			Op = Op | 0b01001100;
		}
		else if(A[1] == 'X' && B[1] == 'X'){
			Op = Op | 0b01010100;
			Len = 2;
		}
		else if((A[1] == 'H' || A[1] == 'L') && (B[1] == 'H' || B[1] == 'L')){
			Op = Op | 0b01000100;
			Len = 2;
		}
		else{
			error(2);
		}
		//Register
		if(Len == 2){
			off = "B" + RegisterNibble(A) + RegisterNibble(B);
		}
	}
	//MOV
	else if(opCode == "MOV"){
		//Opcode
		if(A == "BL" && B == "AL"){
			Op = Op | 0b01001101;
		}
		else if(A == "BX" && B == 'AX'){
			Op = Op | 0b01011101;
		}
		else if(A == "DX" && B == 'AX'){
			Op = Op | 0b01011100;
		}
		else if(A == "EX" && B == 'AX'){
			Op = Op | 0b01011110;
		}
		else if(A == "SP" && B == 'AX'){
			Op = Op | 0b01011111;
		}

		else if(A[1] == 'X' && B[1] == 'X'){
			Op = Op | 0b01010101;
			Len = 2;
		}
		else if((A[1] == 'H' || A[1] == 'L') && (B[1] == 'H' || B[1] == 'L')){
			Op = Op | 0b01000101;
			Len = 2;
		}
		else{
			error(2);
		}
		//Register
		if(Len == 2){
			off = "B" + RegisterNibble(A) + RegisterNibble(B);
		}
	}
	//MEM
	else if(opCode == "MEM"){
		Mem = Ri;
	}
	else{
		error(3);
	}
}

//Return length of instruction
int instruction::getLength(){
	return Len;
}

//Convert all values to binary
void instruction::convertNum(vector<point> points, int address){
	//Fill Missing Information
	if(A.empty()){
		A = "0";
	}
	if(B.empty()){
		B = "0";
	}
	if(off.empty()){
		off = "0";
	}

	//Check A
	A = A.substr(1, A.size());
	int t = atoi(A.c_str());
	A = bitset<5>(t).to_string();

	//Check B
	if(B[0] == '#'){
		//Memory Location
		int success = 0;
		for(int i=1; i<points.size(); i++){
			if(B == points.at(i).getName()){
				B = bitset<5>(points.at(i).getLocation()).to_string();
				success = 1;
			}
		}
		if(!success){
			B = bitset<14>(0).to_string();
		}
	}
	else if(B[0] == 'R'){
		//Register
		B = B.substr(1, B.size());
		int t = atoi(B.c_str());
		B = bitset<5>(t).to_string();
	}
	else if(B[0] == 'B'){
		//Binary
		B = B.substr(1, B.size());
		int t = strtol(B.c_str(), NULL, 2);
		B = bitset<5>(t).to_string();
	}
	else if(B[0] == 'H'){
		//Hexidecimal
		B = B.substr(1, B.size());
		int t = strtol(B.c_str(), NULL, 16);
		B = bitset<5>(t).to_string();
	}
	else{
		//Decimal
		int t = atoi(B.c_str());
		B = bitset<5>(t).to_string();
	}

	//iw2
	if(off[0] == '#'){
		//Memory Location
		int success = 0;
		for(int i=1; i<points.size(); i++){
			if(off == points.at(i).getName()){
				off = bitset<14>(points.at(i).getLocation()).to_string();
				success = 1;
			}
		}
		if(!success){
			off = bitset<14>(0).to_string();
		}
	}
	else if(off[0] == 'B'){
		//Binary
		off = off.substr(1, off.size());
		int t = strtol(off.c_str(), NULL, 2);
		off = bitset<14>(t).to_string();
	}
	else if(off[0] == 'H'){
		//Hexidecimal
		off = off.substr(1, off.size());
		int t = strtol(off.c_str(), NULL, 16);
		off = bitset<14>(t).to_string();
	}
	else{
		//Decimal
		int t = atoi(off.c_str());
		off = bitset<14>(t).to_string();
	}

	//Mem
	if(!Mem.empty()){
		if(Mem[0] == '#'){
			//Memory Location
			int success = 0;
			for(int i=1; i<points.size(); i++){
				if(Mem == points.at(i).getName()){
					Mem = bitset<14>(points.at(i).getLocation()).to_string();
					success = 1;
				}
			}
			if(!success){
				Mem = bitset<14>(0).to_string();
			}
		}
		else if(Mem[0] == 'B'){
			//Binary
			Mem = Mem.substr(1, Mem.size());
			int t = strtol(Mem.c_str(), NULL, 2);
			Mem = bitset<14>(t).to_string();
		}
		else if(Mem[0] == 'H'){
			//Hexidecimal
			Mem = Mem.substr(1, Mem.size());
			int t = strtol(Mem.c_str(), NULL, 16);
			Mem = bitset<14>(t).to_string();
		}
		else{
			//Decimal
			int t = atoi(Mem.c_str());
			Mem = bitset<14>(t).to_string();
		}
	}

}

//Generate line(s) for instruction
string instruction::writeWord(int &address){
	string out = "";

	//Raw Data
	if(!Mem.empty()){
		out += Mem;
		address++;
	}
	//First instruction word
	else{
		out += Op;
		address++;
	//Second instruction word
		if(Len == 2){
			out += off;
			address++;
		}
	}
	return out;
}

string instruction::RegisterNibble(string reg){
	string nibble = "";
	switch(reg[1]){
	case 'A':
		nibble = "000";
		break;
	case 'B':
		nibble = "001";
		break;
	case 'C':
		nibble = "010";
		break;
	case 'R':
		nibble = "010";
		break;
	case 'D':
		nibble = "011";
		break;
	case 'E':
		nibble = "100";
		break;
	default:
		nibble = "000";
	}
	switch(reg[2]){
	case 'X':
		nibble += '0';
		break;
	case 'H':
		nibble += '0';
		break;
	case 'L':
		nibble += '1';
		break;
	default:
		error(1);
	}
	return nibble;
}

void instruction::error(int errNum){
	string errorString = "Error at " + sourceLine + " - ";
	switch(errNum){
	case 1:
		errorString += "Invalid register specified";
		break;
	case 2:
		errorString += "Invalid register or register combination specified";
		break;
	case 3:
		errorString == "Invalid OpCode specified";
		break;
	default:
		errorString += "Unknown error";
		break;
	}
	cout << errorString + "\n";
	exit(errNum);
}
