// Aaron Cope
// CPSC240-01 //1 is the section number
// apc42190@csu.fullerton.edu
// Triangle Areas

#include <iostream>

extern "C" void error();

void error() {
    std::cout << "The inputted numbers do not form a triangle. The area is set to zero.\n\n";
}