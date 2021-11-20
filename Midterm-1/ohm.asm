# Aaron Cope
# CPSC240-01
# apc42190@csu.fullerton.edu
# Program Name: Electrical Force

extern strlen
extern stdin
extern scanf
extern fgets
extern printf
extern strcat

global ohm

max_name_size equ 1024
max_title_size equ 1024
k equ 0x4200BEC41C000000


section .data

    ;Creating character arrays for all the user prompts to be printed to console
    open db "This program will help you find the force.", 10, 0
    charge_1 db "Please enter the electrical charge on particle 1: ", 0
    charge_2 db "Please enter the electrical charge on particle 2: ", 0
    distance db "Please enter the distance between the particles in meters: ", 0
    prompt_name db "Please enter your last name: ", 0
    prompt_title db "Please enter your title: ", 0
    thanks db "Thank you. Your force is %1.8lf Neutons.", 10, 0
    string_format db "%s", 0
    float_format db "%lf", 0




section .bss

    ;Reserving bytes for user responses
    title resb max_title_size
    name resb max_name_size
    new_line resb 3



section .text
ohm:

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

    ;says hello
    mov qword rax, 0
    mov rdi, string_format
    mov rsi, open
    call printf

    ;ask for charge_1
    mov qword rax, 0
    mov rdi, string_format
    mov rsi, charge_1
    call printf

    ;get charge 1 float
    push qword 0
    push qword 0
    mov qword rax, 0
    mov rdi, float_format  
    mov rsi, rsp                    
    call scanf
    movsd xmm6, [rsp]               
    pop rax 
    pop rax

    ;ask for charge_2
    mov qword rax, 0
    mov rdi, string_format
    mov rsi, charge_2
    call printf

    ;get charge 2 float
    push qword 0
    push qword 0
    mov qword rax, 0
    mov rdi, float_format  
    mov rsi, rsp                    
    call scanf
    movsd xmm7, [rsp]               
    pop rax 
    pop rax

    ;ask for distance between particles
    mov qword rax, 0
    mov rdi, string_format
    mov rsi, distance
    call printf

    ;get distance
    push qword 0
    push qword 0
    mov qword rax, 0
    mov rdi, float_format  
    mov rsi, rsp                    
    call scanf
    movsd xmm8, [rsp] 
    pop rax 
    pop rax

    ;ask for name
    mov qword rax, 0
    mov rdi, string_format          
    mov rsi, prompt_name             
    call printf  

    ;flush '/n' character from stdin
    mov rdi, new_line
    mov rsi, 3
    mov rdx, [stdin]
    call fgets

    ;get user name
    mov qword rax, 0
    mov rdi, name
    mov rsi, max_name_size
    mov rdx, [stdin]
    call fgets

    ;ask for title
    mov qword rax, 0
    mov rdi, string_format          
    mov rsi, prompt_title            
    call printf  

    ;get user title
    mov qword rax, 0
    mov rdi, title
    mov rsi, max_title_size
    mov rdx, [stdin]
    call fgets

    ;get string length of title
    mov rdi, title
    call strlen
    mov r15, rax

    ;get string length of name
    mov rdi, name
    call strlen
    mov r14, rax

    ;concatenate name and title so we can return both to C function
    mov rdi, title
    mov byte [rdi + r15 - 1], " "
    mov rsi, name
    mov byte [rsi + r14 - 1], "."
    call strcat
    mov r14, rax

    ;calculate force
    mulsd xmm6, xmm7
    mov r15, k
    push r15
    mulsd xmm6, [rsp]
    pop r15
    mulsd xmm8, xmm8
    divsd xmm6, xmm8

    ;print force
    movsd xmm0, xmm6
    mov rax, 1
    mov rdi, thanks
    call printf

    ;store return value
    mov rax, r14



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


    ret