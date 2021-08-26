#include <iostream>
#include <stdio.h>

extern "C" int hello();

int main () {

    int return_code = 99;

    std::cout << "Welcome to my hello program written by Aaron Cope.\n";
    return_code = hello();
    std::cout << "ASSM hello() returned code " 
              << return_code << std::endl;

    return 0;
}