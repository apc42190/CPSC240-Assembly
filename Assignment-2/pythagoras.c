//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *

// Author info
//   Name: Aaron Cope
//   Email: apc42190@csu.fullerton.edu

//Program info
//  Name: Float I/O
//  Programming Language: X86_64 and C
//  Date Written: August 31, 2021
//   Date of Last Update: September 18, 2021
// Status: Completed
//  Files needed for complete program:
//     triangle.asm
//     pythagoras.c
//  References: 
//      Seyfarth: Chapter 11
//      Floyd Holliday

//Purpose: This program demonstrates the input, output, and manipulation(addition, division, multiplication, sqrt) of
//  64 bit floating point numbers in assembly as well as the use of xmm/SSE registers

//Translator information
//  Gnu compiler: gcc -c -m64 -Wall -fno-pie -no-pie -l triangle.lis -o pythagoras.o pythagoras.c -std=c11
//  Gnu linker:   gcc -m64 -std=c11 -o pythagoras.out triangle.o pythagoras.o -fno-pie -no-pie 

//File info
//  File name: pythoagoras.c
//  Language: C

#include <stdio.h>
#include <math.h>

extern double triangle();

int main() {
    printf("%s", "Welcome to the Right Triangles program maintained by Aaron Cope.\n");
    printf("%s", "If errors are discovered please report them to Aaron Cope at apc42190@csu.fullerton.edu for a quick fix.\n");
    
    //declare double to store assembly return value
    double return_code = -99.999;

    //initiate assembly function and store return value in "return_code"
    return_code = triangle();
    printf("%s", "\nThe main function recieved the number ");

    //Print "return_code" which should contain the hypotenuse of the triangle calculated in triangle.asm
    printf("%lf", return_code);
    printf("%s", " and plans to keep it.\nAn integer 0 will be returned to the operating system. Bye.\n");

    return 0;
}