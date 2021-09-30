//Aaron Cope
//CPSC240-01
//apc42190@csu.fullerton.edu
//Program Name: Electrical Force

#include <stdio.h>

int main() {

    extern char* ohm();

    printf("%s", "Welcome to High Voltage System Programming brought to you by Aaron Cope.\n");

    char* name;
    name = ohm();

    printf("%s", "Goodbye ");
    printf("%s", name);
    printf("%s", " Have a nice research party.\nZero will be returned to the operating system.\n");


    return 0;
}