section .data
    prompt_msg db "Enter a number: ", 0
    positive_msg db "The number is POSITIVE", 0
    negative_msg db "The number is NEGATIVE", 0
    zero_msg db "The number is ZERO", 0

section .bss
    input_num resb 1

section .text
global _start

_start:
    ; Display prompt for user input
    mov eax, 4                 ; syscall number for write
    mov ebx, 1                 ; file descriptor for stdout
    mov ecx, prompt_msg        ; pointer to message
    mov edx, len prompt_msg    ; length of message
    int 0x80                   ; call kernel

    ; Assume input captured in `input_num`
    mov al, [input_num]        ; load input into AL
    cmp al, 0
    je .is_zero                ; jump if zero
    jl .is_negative            ; jump if negative

.is_positive:
    mov ecx, positive_msg
    jmp .display_result        ; unconditional jump to display

.is_negative:
    mov ecx, negative_msg
    jmp .display_result

.is_zero:
    mov ecx, zero_msg

.display_result:
    ; Output the result message
    mov eax, 4
    mov ebx, 1
    mov edx, len zero_msg      ; using zero_msg length for simplicity
    int 0x80

.exit:
    mov eax, 1                 ; syscall number for exit
    xor ebx, ebx               ; return 0
    int 0x80
