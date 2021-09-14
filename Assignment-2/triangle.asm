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
;
;Translator information
;  Linux: nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm


extern strlen
extern stdin
extern scanf
extern fgets
extern printf
extern strtod
extern sqrt


global triangle

;Defining the max length of user inputs
max_name_size equ 20
max_title_size equ 10
max_side_size equ 6


section .data

    ;Creating the arrays to hold user prompts and program responses
    promt_name db "Please enter your last name (20 byte limit): ", 0
    prompt_title db "Please enter a title (Mr, Ms, Mrs, Master, etc): ", 0
    prompt_sides db "Please enter the sides of your triangle separated by an enter (use 2 decimals): ", 0
    print_area db "The area of your triangle is ", 0
    square_units db " square units.", 10
    print_len db "The length of the hypotenuse is ", 0
    len db " units.", 10
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

    mov rdi, string_format          ;string format for argument 1 of printf
    mov rsi, prompt_sides           ;prompt user for sides of triangle
    call printf

    push qword 0
    mov qword rax, 0
    mov rdi, float_format
    mov rsi, rsp
    call scanf
    movsd xmm0, [rsp]
    pop rax

    
    
    mov rax, 1
    push rax
    movsd xmm0, [rsp]
    pop rax 


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