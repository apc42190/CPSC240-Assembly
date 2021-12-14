;Name: Aaron Cope
;Email: apc42190@csu.fullerton.edu
;Program: Final Exam


extern printf
extern scanf
extern atof


global force

zero_point_five equ 0x3FE0000000000000


section .data

    welcome db "Welcome to the Lisa Braking Program.", 10, 0
    frequency db "The frequency (GHz) of the processor in machine is %1.8lf.", 10, 0
    enter_mass db "Please enter the mass of moving vehicle (Kg): ", 0
    enter_vel db "Please enter the velocity of the vehicle (meters per second): ", 0
    enter_dist db "Please enter the distance (meters) required for a complete stop: ", 0
    enter_clock db "Please enter the cpu frequency (GHz): ", 0
    print_force db "The required braking force is %1.8lf Newtons.", 10, 0
    print_ticks db "The computation required %ld tics or %1.8lf nanosec.", 10, 0
    string_format db "%s", 0
    double_format db "%lf", 0


section .text
force:

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
    mov rdi, string_format
    mov rsi, welcome
    call printf


    ;the next several section retrieve the clock speed from the cpu, All credit to Bilal.
    mov r14, 0x80000003 
	xor r15, r15  
	xor r11, r11  

section_loop:
	xor r13, r13  

	mov rax, r14  
	cpuid         
	inc r14       

	push rdx      
	push rcx      
	push rbx      
	push rax      


register_loop:
	xor r12, r12  
	pop rbx       

char_loop:
	mov rdx, rbx  
	and rdx, 0xFF 
	shr rbx, 0x8  

	cmp rdx, 64   
	jne counter   
	mov r11, 1    

counter:
	cmp r11, 1    
	jl body       
	inc r11       

body:
	cmp r11, 4   
	jl loop_conditions
	cmp r11, 7  
	jg loop_conditions

	shr r10, 0x8 
	shl rdx, 0x18 
	or r10, rdx   

loop_conditions:
	inc r12
	cmp r12, 4 
	jne char_loop

	inc r13
	cmp r13, 4 
	jne register_loop

	inc r15
	cmp r15, 2 
	jne section_loop

exit:
	push r10
	xor rax, rax
	mov rdi, rsp 
	call atof  
    pop r10


    ;prints clockspeed
    movq r15, xmm0
    mov rax, 1
    mov rdi, frequency
    call printf

    ;prompts for mass
    mov rdi, string_format
    mov rsi, enter_mass
    call printf

    ;gets mass
    push qword 1
    push qword 1
    mov rdi, double_format
    mov rsi, rsp
    call scanf
    movsd xmm15, [rsp]
    pop rax
    pop rax

    ;prompt for velocity
    mov rdi, string_format
    mov rsi, enter_vel
    call printf

    ;get velocity
    push qword 0
    push qword 0
    mov rdi, double_format
    mov rsi, rsp
    call scanf
    movsd xmm14, [rsp]
    pop rax
    pop rax

    ;prompt for distance
    mov rdi, string_format
    mov rsi, enter_dist
    call printf

    ;get distance
    push qword 0
    push qword 0
    mov rdi, double_format
    mov rsi, rsp
    call scanf
    movsd xmm13, [rsp]
    pop rax 
    pop rax 

    ;get timestamp
    cpuid
    rdtsc
    shl rdx, 32
    add rax, rdx
    mov r14, rax


braking_force:

    ;put 0.5 in xmm4
    mov r10, zero_point_five
    push r10
    movsd xmm4, [rsp]
    pop r10

    mulsd xmm15, xmm4
    mulsd xmm15, xmm14
    mulsd xmm15, xmm13

    ;get timestamp
    cpuid
    rdtsc
    shl rdx, 32
    add rax, rdx
    mov r13, rax

    ;print braking force
    mov rax, 1
    movsd xmm0, xmm15
    mov rdi, print_force
    call printf

    ;check if clock_speed above zero
    movq xmm5, r15
    xorpd xmm6, xmm6
    ucomisd xmm5, xmm6
    ja non_zero_clockspeed

    ;prompt clockspeed
    mov rdi, string_format
    mov rsi, enter_clock
    call printf

    ;get speed
    push qword 0
    push qword 0
    mov rdi, double_format
    mov rsi, rsp
    call scanf
    movsd xmm0, [rsp]
    movq r15, xmm0
    pop rax
    pop rax


non_zero_clockspeed:

    ;difference between timestamps
    sub r13, r14

    ;convert to nanoseconds
    cvtsi2sd xmm0, r13
    movq xmm15, r15
    divsd xmm0, xmm15
    movq r15, xmm0

    ;print time info
    mov rax, 1
    mov rdi, print_ticks
    mov rsi, r13
    call printf

    ;return nanoseconds in xmm0
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

    ret