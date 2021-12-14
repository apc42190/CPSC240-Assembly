;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *

;Author info
;   Name: Aaron Cope
;   Email: apc42190@csu.fullerton.edu
;
;Program info
;   Name: Float I/O
;   Programming Language: X86_64 and C
;   Date Written: August 31, 2021
;   Date of Last Update: September 18, 2021
;   Status: Completed
;   Files needed for complete program:
;       triangle.asm
;       pythagoras.c
;   References: 
;       Seyfarth: Chapter 11
;       Floyd Holliday
;
;Purpose: This program demonstrates the input, output, and manipulation(addition, division, multiplication, sqrt) of
;   64 bit floating point numbers in assembly as well as the use of xmm/SSE registers
;
;Translator information
;  Linux: nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm
;
;File info:
;   Name: triangle.asm
;   Language: X86_64 Assembly with Intel syntax



extern strlen
extern stdin
extern scanf
extern fgets
extern printf


global triangle

;Defining the max length of user inputs
max_name_size equ 1024
max_title_size equ 1024
max_side_size equ 6
two_point_zero equ 0x4000000000000000


section .data

    ;Creating the arrays to hold user prompts and program responses
    promt_name db "Please enter your last name (20 byte limit): ", 0
    prompt_title db "Please enter a title (Mr, Ms, Mrs, Master, etc): ", 0
    prompt_sides db "Please enter the sides of your triangle separated by an enter: ", 0
    print_area db "The area of your triangle is %1.8lf square units", 10, 0
    print_len db "The length of the hypotenuse is %1.8lf units", 10, 0
    conclude db "Please enjoy your triangles ", 0
    string_format db "%s", 0
    float_format db "%lf", 0


section .bss

    ;reserve space for user responses
    name resb max_name_size
    title resb max_name_size
    side_a resb max_side_size
    side_b resb max_side_size


section .text
triangle:

    ;prolog: Backing up general purpose registers
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rdi
    push rsi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf


    mov rdi, string_format          ;pass string_format to printf
    mov rsi, promt_name             ;ask user for last name
    call printf  

    mov rdi, name                   ;retrieve user input and store in "name" array
    mov rsi, max_name_size          ;max number of characters
    mov rdx, [stdin]                ;pass standard input to fgets
    call fgets

    mov rdi, string_format          
    mov rsi, prompt_title           ;ask user for title
    call printf

    mov rdi, title                  ;retrieve user input and store in "title" array
    mov rsi, max_title_size         ;max number of title characters
    mov rdx, [stdin]                ;pass standard input to fgets
    call fgets

    ;Ask for side lengths
    mov rdi, string_format          ;string format for argument 1 of printf
    mov rsi, prompt_sides           ;prompt user for sides of triangle
    call printf
    
    ;retrieve side 1
    push qword 0                    ;align stack on a 0
    push qword 0
    mov qword rax, 0
    mov rdi, float_format  
    mov rsi, rsp                    ;pass top of stack to scanf
    call scanf
    movsd xmm6, [rsp]               ;store retrieved float(side 1) in xmm6
    pop rax 
    pop rax

    ;retrieve side 2 the same as side 1
    push qword 0
    push qword 0
    mov qword rax, 0
    mov rdi, float_format
    mov rsi, rsp
    call scanf
    movsd xmm7, [rsp]               ;store retrieved float(side 2) in xmm5
    pop rax 
    pop rax
    
    movsd xmm8, xmm6                ;make copy of side 1
    movsd xmm9, xmm7                ;make copy of side 2
    
    ;Find area of triangle
    mulsd xmm6, xmm7                ;base * height; multiply side 1 and side 2 and store it in xmm0
    mov r15, two_point_zero         ;put 2.0 in r15
    push r15                        ;put r15 on the top of the stack
    divsd xmm6, [rsp]               ;base * height / 2; calculate area of triangle
    pop r15

    ;printing area of triangle results
    movsd xmm0, xmm6
    mov rax, 1                      ;one float will be printed
    mov rdi, print_area
    call printf

    ;Calculate hypotenuse
    mulsd xmm8, xmm8                ;square side 1
    mulsd xmm9, xmm9                ;square side 2
    addsd xmm8, xmm9                ;add side 1 squared to side 2 squared and store it in xmm8
    sqrtsd xmm8, xmm8               ;calculate square root/hypotenuse

    ;Printing value of hypotenuse
    movsd xmm0, xmm8                ;place value of hypotenuse in xmm0 to be printed
    mov rax, 1                      ;1 mxx register to be printed
    mov rdi, print_len
    call printf

    ;Print enjoy triangles
    mov rdi, string_format
    mov rsi, conclude
    call printf

    ;calculates length of "title" string using strlen and stores length in r13 register
    mov qword rax, 0
    mov rdi, title
    call strlen
    mov r13, rax
    
    ;Print title without newline character
    mov rdi, string_format
    mov rsi, title
    mov byte [rsi + r13 - 1], " "           ;replaces newline character with space
    call printf

    ;stores length of "name" array in r13
    mov rdi, name
    call strlen
    mov r13, rax

    ;print name inline with title
    mov rdi, string_format
    mov rsi, name                           ;print name inputted by user
    mov byte [rsi + r13 - 1], "."           ;replace newline character with '.'
    call printf

    movsd xmm0, xmm8           
    



    ;epilog: returns stack to state prior to the assembly fuction
    popf
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rbp

    ;end of assembly function
    ret