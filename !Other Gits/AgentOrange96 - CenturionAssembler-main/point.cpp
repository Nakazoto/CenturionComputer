#include "point.h"
using namespace std;

point::point(int loc, string n){
	location = loc;
	name = n;
}

string point::getName(){
	return name;
}
int point::getLocation(){
	return location;
}
