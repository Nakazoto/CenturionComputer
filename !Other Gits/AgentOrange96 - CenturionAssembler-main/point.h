#ifndef POINT_H_
#define POINT_H_
#include <cstring>
using namespace std;

class point{
public:
	point(int loc, string n);
	string getName();
	int getLocation();
	//~point();
private:
	int location;
	string name;
};

#endif
