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
;   Name: Clock Cycles
;   Programming Language: X86_64 and C++
;   Date Written: Deciembre 3, 2021
;   Files needed for complete program: clock.asm, driver.cpp
;   Status: Completed
;   
;Purpose: Demonstrates reading of the CPU clock with X86_64 Assembly
; 
;
;Translator information
;  Linux: nasm -f elf64 -l clock.lis -o clock.o clock.asm
;
;This file contains:
;   File Name: clock.asm
;   X86_64 Intel-syntax Assembly


extern printf
extern scanf

global clock_asm


nine_point_eight equ 0x402399999999999A
two_point_zero equ 0x4000000000000000
clock_speed equ 0x400A57143393AB43

section .data

    ;Define strings to print
    current db "The current clock time is %ld ticks.", 10, 0
    height_p db "Please enter the height in meters of the dropped marble: ", 0
    earth db "The marble will reach earth after %1.8lf seconds.", 10, 0
    execution db "The execution time was %ld tics which equals %1.8lf ns", 10, 0
   ;wish db "Aaron wishes you a nice day.", 10, 0
    string_format db "%s", 0
    double_format db "%lf", 0

section .text
clock_asm:

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



    mov rax, 0
    mov rdx, 0
    cpuid
    rdtsc
    shl rdx, 32
    add rax, rdx
    mov r13, rax

    mov rdi, current
    mov rsi, r13
    call printf

    mov rdi, string_format
    mov rsi, height_p
    call printf

    push qword 0
    push qword 0
    mov rdi, double_format
    mov rsi, rsp
    call scanf
    movsd xmm14, [rsp]
    pop rax
    pop rax

    mov qword r12, nine_point_eight
    movq xmm13, r12
    mov qword r15, two_point_zero
    movq xmm15, r15
    divsd xmm13, xmm15
    divsd xmm14, xmm13
    sqrtsd xmm14, xmm14

    movsd xmm0, xmm14
    mov rax, 1
    mov rdi, earth
    call printf

    mov rax, 0
    mov rdx, 0
    cpuid
    rdtsc
    shl rdx, 32
    add rax, rdx
    mov r14, rax

    mov qword rdi, current
    mov rsi, r14
    call printf

    sub r14, r13

    cvtsi2sd xmm8, r14
    mov r8, clock_speed
    push r8
    divsd xmm8, [rsp]
    pop r8

    movsd xmm0, xmm8
    mov rax, 1
    mov rdi, execution
    mov rsi, r14
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