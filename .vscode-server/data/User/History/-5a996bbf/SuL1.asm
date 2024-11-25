section .data
    prompt_msg db "Enter a number: ", 0
    prompt_msg_len equ $ - prompt_msg       ; Calculate length of prompt_msg
    positive_msg db "The number is POSITIVE", 0
    positive_msg_len equ $ - positive_msg   ; Calculate length of positive_msg
    negative_msg db "The number is NEGATIVE", 0
    negative_msg_len equ $ - negative_msg   ; Calculate length of negative_msg
    zero_msg db "The number is ZERO", 0
    zero_msg_len equ $ - zero_msg           ; Calculate length of zero_msg

section .bss
    input_num resb 1

section .text
global _start

_start:
    ; Display prompt for user input
    mov eax, 4                 ; syscall number for write
    mov ebx, 1                 ; file descriptor for stdout
    mov ecx, prompt_msg        ; pointer to message
    mov edx, prompt_msg_len    ; length of message
    int 0x80                   ; call kernel

    ; Capture user input
    mov eax, 3                 ; syscall number for read
    mov ebx, 0                 ; file descriptor for stdin
    mov ecx, input_num         ; buffer to store input
    mov edx, 1                 ; number of bytes to read
    int 0x80                   ; call kernel

    ; Process input
    mov al, [input_num]        ; load input into AL
    sub al, '0'                ; convert ASCII to integer
    cmp al, 0
    je .is_zero                ; jump if zero
    jl .is_negative            ; jump if negative

.is_positive:
    mov ecx, positive_msg
    mov edx, positive_msg_len
    jmp .display_result        ; unconditional jump to display

.is_negative:
    mov ecx, negative_msg
    mov edx, negative_msg_len
    jmp .display_result

.is_zero:
    mov ecx, zero_msg
    mov edx, zero_msg_len

.display_result:
    ; Output the result message
    mov eax, 4                 ; syscall number for write
    mov ebx, 1                 ; file descriptor for stdout
    int 0x80                   ; call kernel

.exit:
    mov eax, 1                 ; syscall number for exit
    xor ebx, ebx               ; return 0
    int 0x80
