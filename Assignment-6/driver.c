#include "stdio.h"
#include "math.h"

extern double looper();

int main() {

    printf("%s", "Welcome to this wonderful program written by Aaron Cope planning a career in microprocessor architecture.\n");
    double return_value = -99.9999;
    return_value = looper();
    printf("%s", "The main function received the number ");
    printf("%lf", return_value);
    printf("%s", " and has no knowledge about it.\nA 0 will be returned to the OS as a signal of success.\n");

    return 0;
}