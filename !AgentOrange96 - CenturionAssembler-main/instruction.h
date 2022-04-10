#ifndef INSTRUCTION_H_
#define INSTRUCTION_H_
#include <cstring>
#include <vector>
#include "point.h"
using namespace std;

class instruction{
public:
	instruction(string opCode, string Ri, string Rj = "0", string iw2 = "0", int lineNum);
	int getLength();
	void convertNum(vector<point> points, int address);
	string writeWord(int &address);
	//~instruction();
private:
	char Op;
	string A;
	string B;
	string off;
	string Mem;
	int Len;
	int sourceLine;
	string RegisterNibble(string reg);
	void error(int errorNum);
};

#endif
