//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *

// Author info
//   Name: Aaron Cope
//   Email: apc42190@csu.fullerton.edu

//Program info
//   Name: Floats I/O
//   Programming Language: X86_64 and C
//   Date Written: August 31, 2021 

//Translator information
//  Gnu compiler: gcc -c -m64 -Wall -fno-pie -no-pie -l triangle.lis -o pythagoras.o pythagoras.c -std=c11
//  Gnu linker:   gcc -m64 -std=c11 -o pythagoras.out triangle.o pythagoras.o -fno-pie -no-pie 

#include <stdio.h>
#include <math.h>

extern int triangle();

int main() {
    printf("%s", "Welcome to the Right Triangles program maintained by Aaron Cope.\n");
    printf("%s", "If errors are discovered please report them to Aaron Cope at apc42190@csu.fullerton.edu for a quick fix.\n");
    double return_code = -99.999;
    return_code = triangle();
    printf("%s", "\nThe main function recieved the number ");
    printf("%lf", return_code);
    printf("%s", " and plans to keep it.\nAn integer 0 will be returned to the operating system. Bye.\n");

    return 0;
}