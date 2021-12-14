//Name: Aaron Cope
//Email: apc42190@csu.fullerton.edu

#include <iostream>

extern "C" double force();


int main() {

    std::cout << "This is Final exam by Aaron Cope.\n";
    double return_value = -99.99;
    return_value = force();
    std::cout << "The main program recieved " << return_value << " and will keep it.\nHave a nice day.\n";

    return 0;
}