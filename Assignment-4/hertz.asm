
extern printf
extern atof
extern fgets
extern scanf
extern isFloat
extern stdin
extern strlen
extern atof


global hertz

max_name_size equ 1024
max_float_size equ 1024

section .data:

    prompt_name_title db "Please enter your name and title. You choose the format: ", 0
    welcome db "Welcome ", 0
    prompt_res db "Please enter the resistance in this curcuit: ", 0
    prompt_cur db "Please enter the current in this curcuit: ", 0
    thank db "Thank you ", 0
    print_power db " Your power consumption is %1.8lf watts.", 10, 0
    try_again db "Input is invalid. Please try again", 10, 0
    string_format db "%s", 0
    float_format db "%lf", 0

section .bss

    name_title resb max_name_size
    resistance resb max_float_size
    current resb max_float_size
    newline_eater resb 3

section .text
hertz:

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


    mov rdi, string_format
    mov rsi, prompt_name_title
    call printf

    mov rdi, name_title
    mov rsi, max_name_size
    mov rdx, [stdin]
    call fgets
    
    mov rdi, string_format
    mov rsi, welcome
    call printf

    mov rdi, string_format
    mov rsi, name_title
    call printf


input_floats:

    mov rdi, string_format
    mov rsi, prompt_res
    call printf

    mov rdi, string_format
    mov rsi, resistance
    call scanf

    mov rdi, resistance
    call isFloat
    cmp rax, 0
    je invalid

    mov rdi, resistance
    call atof
    movq xmm12, xmm0

    mov rdi, string_format
    mov rsi, prompt_cur
    call printf

    mov rdi, string_format
    mov rsi, current
    call scanf

    mov rdi, current
    call isFloat
    cmp rax, 0
    je invalid

    mov rdi, current
    call atof
    movq xmm13, xmm0

    jmp valid


invalid:

    mov rdi, string_format
    mov rsi, try_again
    call printf

    jmp input_floats

valid:

    mulsd xmm13, xmm13
    mulsd xmm13, xmm12

    mov rdi, string_format
    mov rsi, thank
    call printf

    mov rdi, name_title
    call strlen
    mov r13, rax
    
    mov rdi, string_format
    mov rsi, name_title
    mov byte [rsi + r13 - 1], "."
    call printf

    movsd xmm0, xmm13
    mov rax, 1
    mov rdi, print_power
    call printf

    movsd xmm0, xmm13


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