//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *

// Author info
//   Name: Aaron Cope
//   Email: apc42190@csu.fullerton.edu

//Program info
//   Name: Strings I/O
//   Programming Language: X86_64 and C++
//   Date Written: August 25, 2021
//   Purpose: Demonstrates input, manipulation, 
//      and output of strings in X86 Assembly
//      as well as interaction between X86 and C++


//Translator information
//  Gnu compiler: g++ -c -m64 -Wall -fno-pie -no-pie -l good-moring.lis -o good_morning.o good_morning.cpp -std=c++2a
//  Gnu linker:   g++ -m64 -std=c++2a -o go.out hello.o good_morning.o -fno-pie -no-pie 


#include <iostream>     //needed for standard output
#include <stdio.h>      //needed for calls made in assembly program

extern "C" char* hello();       //linking hello.asm and welcome.cpp

int main () {

    char* name;     //declare c-style string to recieve name from hello()

    //greets user
    std::cout << "Welcome to my hello program written by Aaron Cope.\n";

    name = hello();     //calls assembly program and stores returned name in "name"

    //bids farewell to user, calling them by name which is stored in "name"
    std::cout << "\nGoodbye " << name << " Stay safe. \nThe program will now terminate.\n";

    return 0;
}