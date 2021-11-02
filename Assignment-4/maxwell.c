#include "stdio.h"

extern "C" double hertz();


int main (void) {


    printf("%s", "Welcome to Power Unlimited programming by Aaron Cope.\nWe will find your power.\n");
    double return_value = hertz();
    printf("%s", "The main function has recieved ");
    printf("%lf", return_value);
    printf("%s", " and will keep it.\n");
    printf("%s", "Zero will be returned to the OS.\n");

    return 0;
}