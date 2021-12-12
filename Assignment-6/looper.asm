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
;   Name: looper
;   Programming Language: X86_64, C++, C
;   Date Written: Deciembre 9, 2021
;   Files needed for complete program: looper.asm, driver.cpp, clockspeed.asm, is_float.cpp, is_float.hpp 
;   Status: Completed
;   
;Purpose: Demonstrates the use of loops in x86 by calculating a sum
; 
;
;Translator information
;  Linux: nasm -f elf64 -l clock.lis -o clock.o clock.asm
;
;This file contains:
;   File Name: looper.asm
;   X86_64 Intel-syntax Assembly


extern printf
extern scanf
extern pow
extern fabs
extern clock_speed
extern get_precision_number

global looper


negative_one_point_zero equ 0xBFF0000000000000
one_point_zero equ 0x3FF0000000000000 
two_point_zero equ 0x4000000000000000 
four_point_zero equ 0x4010000000000000


section .data

print_cpu db "This machine is running a cpu rated at %1.8lf GHz.", 10, 0
current_ticks db "The time on the clock is now %ld ticks.", 10, 0
computed db "The sum has been computed.", 10, 0
print_sum db "The sum is %1.8lf.", 10, 0
print_time_passed db "The execution time was %ld ticks.", 10, 0
flush_stdout db "", 0
string_format db "%s", 0

iteration_term db "The current term is %1.8lf.", 10, 0


section .text
looper:

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

    ;CPU speed was not printing correctly and this somehow fixes it
    mov rdi, string_format
    mov rsi, flush_stdout
    call printf

    ;get cpu speed
    xorpd xmm0, xmm0                ;zero out xmm0
    mov qword rax, 0                ;zero out rax
    call clock_speed                ;get clock speed

    ;print clock speed
    mov rax, 1
    mov rdi, print_cpu
    call printf

    ;get number to stop at in iteration
    call get_precision_number
    movq r15, xmm0                  ;store in r15 for preservation

    ;get current time stamp
    cpuid
    rdtsc
    shl rdx, 32
    add rax, rdx
    mov r12, rax                    ;store timestamp in r12

    ;print timestamp
    mov rdi, current_ticks
    mov rsi, r12
    call printf
    
    ;zero out xmm13 and xmm15
    xorpd xmm13, xmm13              ;xmm13 = k, starts at 0.0 and increases by 1 each iteration
    xorpd xmm15, xmm15


    ;iterate through sum
    iterate:

    ;put -1.0 in xmm7
    mov r11, negative_one_point_zero
    push r11
    movsd xmm7, [rsp]
    pop r11

    ;(-1)^k
    movsd xmm0, xmm7                ;first parameter (-1)
    movsd xmm1, xmm13               ;second parameter(k)
    call pow

    ;put 4.0 in xmm10
    mov r11, four_point_zero
    push r11
    movsd xmm10, [rsp]
    pop r11

    ;4.0 * ((-1)^k)
    mulsd xmm10, xmm0               ;xmm10 = 4.0 and xmm0 = (-1) ^ k

    ;put 1.0 in xmm12
    mov r11, one_point_zero
    push r11
    movsd xmm12, [rsp]
    pop r11

    ;put 2.0 in xmm11
    mov r11, two_point_zero
    push r11
    movsd xmm11, [rsp]
    pop r11

    ;(2.0 * k) + 1
    mulsd xmm11, xmm13              ;xmm11 = 2.0, xmm13 = k
    addsd xmm11, xmm12              ;xmm12 = 1.0

    ;dividing top and bottom elements
    divsd xmm10, xmm11              ;xmm10(4.0 * (-1)^k) / xmm11((2.0 * k) + 1)

    ;get absolute value of term
    movsd xmm14, xmm10              ;store copy of term in xmm14
    movsd xmm0, xmm10               
    call fabs
    movsd xmm10, xmm0               ;store absolute value in xmm10

    ;add 1.0 to xmm13(k)
    mov r13, one_point_zero
    push r13
    addsd xmm13, [rsp]
    pop r13

    ;compare xmm9(precision number) to xmm10(absolute value of current term)
    movq xmm9, r15
    ucomisd xmm10, xmm9

    ;fork
    jb print_time                   ;if term smaller that precision number, break from loop
    addsd xmm15, xmm14              ;if not, add term to total
    jmp iterate                     ;continue next iteration of loop


    print_time:

    ;store sum in nonvolatile register
    movq r15, xmm15

    ;print that the sum has been computed
    mov rdi, string_format
    mov rsi, computed
    call printf

    ;get current timestamp and store in r14
    cpuid
    rdtsc
    shl rdx, 32
    add rax, rdx
    mov r14, rax

    ;print current timestamp
    mov rdi, current_ticks
    mov rsi, r14
    call printf

    ;print calculated sum
    movq xmm0, r15
    mov rax, 1
    mov rdi, print_sum
    call printf

    ;find time elapsed and print
    sub r14, r12                    ;end time - start time
    mov rdi, print_time_passed
    mov rsi, r14
    call printf

    ;returns calculated sum
    movq xmm0, r15                  

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