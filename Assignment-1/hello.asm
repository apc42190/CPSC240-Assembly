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
;   Name: Strings I/O
;   Programming Language: X86_64 and C++
;   Date Written: August 25, 2021
;   Purpose: Demonstrates input, manipulation, 
;       and output of strings in X86 Assembly
;       as well as interaction between X86 and C++
;
;Translator information
;  Linux: nasm -f elf64 -l hello.lis -o hello.o hello.asm



extern printf                   ;C funtion for standard output
extern fgets                    ;C function for reading input
extern stdin                    ;Name of standard input device
extern strlen                   ;C function for determining length of a string

global hello

;size limits for each user response
max_name_size equ 40
max_title_size equ 16
max_response_size equ 15


section .data
    align 16

    ;prompts for getting user input and program responses
    ask_name db "Please enter your first and last names (40 byte limit): ", 0
    ask_title db "Please enter a title (16 byte limit): ", 0
    greeting db "Hello, ", 0
    how db " How are you? (good, bad, horrible, etc): ", 0
    sympathize db "is an acceptable response. ", 0, 10
    string_format db "%s", 0

    align 64

section .bss
    ;reserving memory for user inputs
    name resb max_name_size
    title resb max_title_size
    response resb max_response_size

section .text
hello:

    ;Prolog. Not actually sure what this is for.
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

    ;Asks user for first and last names
    mov qword rax, 0
    mov rdi, string_format
    mov rsi, ask_name
    call printf

    ;retrieves name and stores it in "name" array
    mov qword rax, 0
    mov rdi, name
    mov rsi, max_name_size
    mov rdx, [stdin]
    call fgets

    ;asks user for prefered title
    mov qword rax, 0
    mov rdi, string_format
    mov rsi, ask_title
    call printf

    ;retrieves name and stores it in "title" array
    mov qword rax, 0
    mov rdi, title
    mov rsi, max_title_size
    mov rdx, [stdin]
    call fgets

    ;says "Hello, "
    mov qword rax, 0
    mov rdi, string_format
    mov rsi, greeting
    call printf

    ;calculates length of "title" string using strlen and stores length in r13 register
    mov qword rax, 0
    mov rdi, title
    call strlen
    mov r13, rax

    ;prints "title" array without newline character at the end
    mov rdi, string_format
    mov rsi, title
    mov byte [rsi + r13 - 1], " "   ;replaces newline character with a space  
    call printf

    ;stores length of "name" array in r13
    mov rdi, name
    call strlen
    mov r13, rax

    ;prints "name" inline with title and removes newline character from the end
    mov rdi, string_format
    mov rsi, name
    mov byte [rsi + r13 - 1], "."
    call printf

    ;prints "How are you doing? "
    mov rdi, string_format
    mov rsi, how
    call printf

    ;recieves response and stores it in "response" array
    mov rdi, response
    mov rsi, max_response_size
    mov rdx, [stdin]
    call fgets

    ;stores length of "response" array in r13
    mov rdi, response
    call strlen
    mov r13, rax

    ;prints response inline with following output
    mov rdi, string_format
    mov rsi, response
    mov byte [rsi + r13 - 1], " "
    call printf

    ;prints sympathtic affirmation of user response
    mov rdi, string_format
    mov rsi, sympathize
    call printf

    ;stores name in xmm0 to return to c++
    mov rax, name
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