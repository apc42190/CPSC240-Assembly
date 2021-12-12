#include <stdlib.h>
#include <stdio.h>
#include "is_float.hpp"

extern double get_precision_number();

double get_precision_number() {

    char precision[100];
    double return_value = -99.999999;
    while(1) {
        printf("%s", "Please enter a precision number and press enter: ");
        scanf("%s", precision);
        if (isFloat(precision) == 0) {
            printf("%s", "Invalid input encountered. Please try again.\n");
            continue;
        }
        return_value = atof(precision);
        printf("You have entered %1.8lf which will be returned to caller function.\n", return_value);
        break;
    }

    return return_value;
}