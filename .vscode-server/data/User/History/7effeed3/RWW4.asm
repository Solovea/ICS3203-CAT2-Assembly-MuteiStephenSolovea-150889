section .data
    factorial_res dd 1           ; store factorial result (32-bit to handle larger numbers)
    msg db "Factorial: ", 0
    newline db 0xA, 0            ; newline character

section .bss
    buffer resb 10               ; buffer to hold ASCII representation of the number

section .text
global _start

_start:
    mov ecx, 5                   ; calculate factorial of 5
    call factorial               ; call factorial subroutine

    ; Store the result in factorial_res
    mov [factorial_res], eax     ; store the result in factorial_res

    ; Print the result message
    mov eax, 4                   ; syscall number for write
    mov ebx, 1                   ; file descriptor (stdout)
    mov ecx, msg                 ; pointer to message
    mov edx, msg_len             ; length of the message
    int 0x80

    ; Convert factorial result to ASCII and print
    mov eax, [factorial_res]     ; load the result
    mov edi, buffer              ; point to the buffer
    call int_to_ascii            ; convert to ASCII

    ; Print the result
    mov eax, 4                   ; syscall number for write
    mov ebx, 1                   ; file descriptor (stdout)
    mov ecx, edi                 ; pointer to the buffer
    mov edx, buffer + 10 - edi   ; length of the number
    int 0x80

    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

.exit:
    mov eax, 1                   ; syscall number for exit
    xor ebx, ebx                 ; return 0
    int 0x80

factorial:
    cmp ecx, 1
    jle .base_case               ; if ecx <= 1, base case reached

    ; Recursive case
    push ecx                     ; save current ECX value on the stack
    dec ecx                      ; decrement ECX
    call factorial               ; recursive call

    pop ecx                      ; restore ECX
    mul ecx                      ; multiply EAX (result) with ECX
    ret

.base_case:
    mov eax, 1                   ; base case: factorial(1) = 1
    ret

; Convert integer in EAX to ASCII string in buffer
int_to_ascii:
    xor edx, edx                 ; clear edx
    mov ebx, 10                  ; divisor (base 10)

.int_to_ascii_loop:
    div ebx                      ; divide EAX by 10, quotient in EAX, remainder in EDX
    add dl, '0'                  ; convert remainder to ASCII
    dec edi                      ; move buffer pointer backward
    mov [edi], dl                ; store character
    xor edx, edx                 ; clear remainder
    test eax, eax                ; check if EAX == 0
    jnz .int_to_ascii_loop       ; repeat if not

    ret

section .data
    msg_len equ $ - msg          ; calculate message length
