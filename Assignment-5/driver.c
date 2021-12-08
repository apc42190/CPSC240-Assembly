#include "stdio.h"

extern double clock_asm();

int main() {

    printf("%s", "Welcome to Gravitational Experiments by Aaron Cope..\n");
    double clock_time = -99.9999;
    clock_time = clock_asm();
    printf("%s", "The main function received the number "); 
    printf("%lf", clock_time);
    printf("%s", " and will keep it.\nA 0 will be returned to the OS.\n");

    return 0;
}