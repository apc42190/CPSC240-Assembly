// Aaron Cope
// CPSC240-01 //1 is the section number
// apc42190@csu.fullerton.edu
// Triangle Areas

#include "stdio.h"

extern "C" double triangle();


int main (void) {


    printf("%s", "Welcome to Triangle Areas by Aaron Cope.\n\n");
    double return_value = triangle();
    printf("%s", "The main function has recieved the number ");
    printf("%lf", return_value);
    printf("%s", " and will keep it.\n");
    printf("%s", "I hope you enjoyed this triangle program. Zero will be returned to the OS. Have a nice day\n");

    return 0;
}