#include <cctype>

extern "C" int isFloat(char*);

int isFloat(char* pot_float) {
    int index = 0;
    bool period = false;

    if (isdigit(pot_float[index]) || pot_float[index] == '.') {
        index++;
        while (pot_float[index] != '\0') {
            if (isdigit(pot_float[index])) {
                index++;
            } else if (pot_float[index] == '.' && period == false) {
                index++;
                period = true;
            } else {
                return 0;
            }
        }
    } else {
        return 0;
    }

    return 1;
}