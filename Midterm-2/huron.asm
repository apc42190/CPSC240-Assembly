;Aaron Cope
;CPSC240-01 //1 is the section number
;apc42190@csu.fullerton.edu
;Triangle Areas

extern printf
extern atof
extern scanf
extern isFloat
extern atof
extern error
extern output


global triangle

max_float_size equ 1024
two_point_zero equ 0x4000000000000000

section .data:

    welcome db "We find any area.", 10
    get_side_one db "Please enter the length of the first side: ", 0
    get_side_two db "Please enter the length of the second side: ", 0
    get_side_three db "Please enter the length of the third side: ", 0
    semi_perim db 10, "The semi-perimeter is: %1.8lf", 10, 10, 0
    ret_to db "The area will be returned to the driver.", 10, 10, 0
    string_format db "%s", 0
    float_format db "%lf", 0

section .bss

    side_one resb max_float_size
    side_two resb max_float_size
    side_three resb max_float_size

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


    ;welcome
    mov rdi, string_format
    mov rsi, welcome
    call printf


input_floats:

    ;ask for side one
    mov rdi, string_format
    mov rsi, get_side_one
    call printf

    ;get side one as string
    mov rdi, string_format
    mov rsi, side_one
    call scanf

    ;validate format of side one
    mov rdi, side_one
    call isFloat
    cmp rax, 0
    je input_floats

    ;convert side one to float
    mov rdi, side_one
    call atof
    movq xmm12, xmm0

    ;prompt side 2
    mov rdi, string_format
    mov rsi, get_side_two
    call printf

    ;get side 2 as string
    mov rdi, string_format
    mov rsi, side_two
    call scanf

    ;convert side 2 to float
    mov rdi, side_two
    call atof
    movq xmm13, xmm0

    ;prompt side 3
    mov rdi, string_format
    mov rsi, get_side_three
    call printf

    ;get side 3 as string
    mov rdi, string_format
    mov rsi, side_three
    call scanf

    ;convert side 3 to float
    mov rdi, side_three
    call atof
    movq xmm14, xmm0

    ;find semi-perimeter
    movsd xmm8, xmm12
    movsd xmm9, xmm13
    movsd xmm10, xmm14
    addsd xmm8, xmm9
    addsd xmm8, xmm10
    mov r11, two_point_zero
    push r11
    divsd xmm8, [rsp]
    pop r11
    movsd xmm11, xmm8
    
    ;print semi-perimeter
    mov rax, 1
    movsd xmm0, xmm11
    mov rdi, semi_perim
    call printf

    ;compare side 1 + side 2 > side 3
    movsd xmm8, xmm12
    movsd xmm9, xmm13
    movsd xmm10, xmm14
    addsd xmm8, xmm9
    ucomisd xmm8, xmm10
    jb not_a_triangle

    ;compare side 1 + side 2 > side 3
    movsd xmm8, xmm12
    movsd xmm9, xmm13
    movsd xmm10, xmm14
    addsd xmm8, xmm10
    ucomisd xmm8, xmm9
    jb not_a_triangle

    ;compare side 1 + side 2 > side 3
    movsd xmm8, xmm12
    movsd xmm9, xmm13
    movsd xmm10, xmm14
    addsd xmm10, xmm9
    ucomisd xmm10, xmm8
    jb not_a_triangle

    ;calculate area
    movsd xmm8, xmm12
    movsd xmm9, xmm13
    movsd xmm10, xmm14
    movsd xmm7, xmm11
    subsd xmm7, xmm8
    movsd xmm8, xmm7
    movsd xmm7, xmm11
    subsd xmm7, xmm9
    movsd xmm9, xmm7
    movsd xmm7, xmm11
    subsd xmm7, xmm10
    movsd xmm10, xmm7
    movsd xmm7, xmm11
    mulsd xmm7, xmm8
    mulsd xmm7, xmm9
    mulsd xmm7, xmm10
    sqrtsd xmm7, xmm7
    movsd xmm11, xmm7

    ;output area
    mov rax, 0
    movsd xmm0, xmm11
    call output

    ;print that area will be returned
    mov rdi, string_format
    mov rsi, ret_to
    call printf

    ;return area and skip over "not_a_triangle"
    movsd xmm0, xmm11
    jmp end


not_a_triangle:    

    ;call error and zero-out return value
    call error
    xorpd xmm0, xmm0
    jmp end


end:

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