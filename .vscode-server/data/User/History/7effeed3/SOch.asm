section .data
    factorial_res dd 1           ; Store factorial result (32-bit to handle larger numbers)
    msg db "Factorial: ", 0
    newline db 0xA, 0            ; Newline character

section .bss
    buffer resb 10               ; Buffer to hold ASCII representation of the number

section .text
global _start

_start:
    mov ecx, 5                   ; Calculate factorial of 5
    call factorial               ; Call factorial subroutine

    ; Store the result in factorial_res
    mov [factorial_res], eax     ; Store the result in factorial_res

    ; Print the result message
    mov eax, 4                   ; Syscall number for write
    mov ebx, 1                   ; File descriptor (stdout)
    mov ecx, msg                 ; Pointer to message
    mov edx, msg_len             ; Length of the message
    int 0x80

    ; Convert factorial result to ASCII and print
    mov eax, [factorial_res]     ; Load the result
    mov edi, buffer              ; Point to the buffer
    call int_to_ascii            ; Convert to ASCII

    ; Print the result
    mov eax, 4                   ; Syscall number for write
    mov ebx, 1                   ; File descriptor (stdout)
    mov ecx, edi                 ; Pointer to the buffer
    mov edx, buffer + 10 - edi   ; Length of the number
    int 0x80

    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

.exit:
    mov eax, 1                   ; Syscall number for exit
    xor ebx, ebx                 ; Return 0
    int 0x80

factorial:
    cmp ecx, 1
    jle .base_case               ; If ecx <= 1, base case reached

    ; Recursive case
    push ecx                     ; Save current ECX value on the stack
    dec ecx                      ; Decrement ECX
    call factorial               ; Recursive call

    pop ecx                      ; Restore ECX
    imul ecx                     ; Multiply EAX (result) with ECX
    ret

.base_case:
    mov eax, 1                   ; Base case: factorial(1) = 1
    ret

; Convert integer in EAX to ASCII string in buffer
int_to_ascii:
    xor edx, edx                 ; Clear EDX
    mov ebx, 10                  ; Divisor (base 10)

.int_to_ascii_loop:
    div ebx                      ; Divide EAX by 10, quotient in EAX, remainder in EDX
    add dl, '0'                  ; Convert remainder to ASCII
    dec edi                      ; Move buffer pointer backward
    mov [edi], dl                ; Store character
    xor edx, edx                 ; Clear remainder
    test eax, eax                ; Check if EAX == 0
    jnz .int_to_ascii_loop       ; Repeat if not

    ret

section .data
    msg_len equ $ - msg          ; Calculate message length
