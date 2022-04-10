#include <stdio.h>
#include <iostream>
#include <fstream>
#include <cstring>
#include <vector>
#include "point.h"
#include "instruction.h"
using namespace std;

//Prototypes
vector<string> splitString(string);

//Main function
int main(int argc, char *argv[]){
	vector<instruction> Instructions;
	vector<point> Points;
	int i = 0;
	int addr = 0;
	string current;

	//Load contents of file
	ifstream ASM (argv[1]);
	cout << "Assembling " << argv[1] << endl;
	while(getline(ASM,current)){
		//Split line into elements
		vector<string> words = splitString(current);
		string cPoint = "";
		string OpCode = "";
		string ri = "";
		string rj = "";
		string iw2 = "";
		//Read parts from line
		for(int j=0; j<words.size();j++){
			if(j==0 && words.at(j)[0] == '#'){
				cPoint = words.at(j);
			}
			else if(OpCode.empty()){
				OpCode = words.at(j);
			}
			else if(ri.empty()){
				ri = words.at(j);
			}
			else if(rj.empty()){
				rj = words.at(j);
			}
			else if(iw2.empty()){
				iw2 = words.at(j);
			}
		}
		//Add to list of instruction words
		if(!cPoint.empty()){
			Points.push_back(point(addr,cPoint));
		}
		if(!OpCode.empty()){
			instruction In = instruction(OpCode, ri, rj, iw2, i+1);
			Instructions.push_back(In);
			addr = addr + In.getLength();
		}
		i++;
	}
	ASM.close();

	//Determine Output File
	const int nameL = strlen(argv[1]);
	char outFile[50] = {NULL};
	strcpy(outFile, argv[1]);
	outFile[nameL-3] = 'b';
	outFile[nameL-2] = 'i';
	outFile[nameL-1] = 'n';
	ofstream BIN (outFile);

	//Second loop writes to file
	addr = 0;
	for(i=0; i<Instructions.size(); i++){
		Instructions.at(i).convertNum(Points, addr);
		BIN << Instructions.at(i).writeWord(addr);
	}
	BIN.close();
	cout << "Created " << outFile << endl;
	return 0;
}

vector<string> splitString(string s){
	vector<string> out;
	int word = 0;
	bool space = 0;
	out.push_back("");
	//Iterate through each character
	for(int i = 0; i<s.size(); i++){
		if(s[i] == ';'){
			//Comment, end loop
			i = s.size();
		}
		else if(s[i] == ' ' || s[i] == '\t'){
			//Space, advance word
			if(!space){
				word++;
				out.push_back("");
				space = 1;
			}
		}
		else{
			//Regular character

			out.at(word) += toupper(s[i]);
			space = 0;
		}
	}
	return out;
}
