section .data
    factorial_res dq 1           ; Store factorial result (64-bit for larger values)
    msg db "Factorial: ", 0
    newline db 0xA, 0            ; Newline character

section .bss
    buffer resb 20               ; Buffer to hold ASCII representation of the number

section .text
global _start

_start:
    mov rdi, 5                   ; Calculate factorial of 5
    call factorial               ; Call factorial subroutine

    ; Store the result in factorial_res
    mov [factorial_res], rax     ; Store the result in factorial_res

    ; Print the result message
    mov rax, 1                   ; Syscall number for write
    mov rdi, 1                   ; File descriptor (stdout)
    mov rsi, msg                 ; Pointer to message
    mov rdx, msg_len             ; Length of the message
    syscall

    ; Convert factorial result to ASCII and print
    mov rax, [factorial_res]     ; Load the result
    mov rdi, buffer + 19         ; Point to the end of the buffer
    call int_to_ascii            ; Convert to ASCII

    ; Print the result
    mov rax, 1                   ; Syscall number for write
    mov rdi, 1                   ; File descriptor (stdout)
    lea rsi, [buffer + 19]       ; Pointer to the start of the number
    mov rdx, 20                  ; Assume the number is at most 20 characters long
    syscall

    ; Print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Exit program
    mov rax, 60                  ; Syscall number for exit
    xor rdi, rdi                 ; Return code 0
    syscall

factorial:
    cmp rdi, 1
    jle .base_case               ; If rdi <= 1, base case reached

    ; Recursive case
    push rdi                     ; Save current RDI value on the stack
    dec rdi                      ; Decrement RDI
    call factorial               ; Recursive call

    pop rdi                      ; Restore RDI
    imul rax, rdi                ; Multiply RAX (result) with RDI
    ret

.base_case:
    mov rax, 1                   ; Base case: factorial(1) = 1
    ret

; Convert integer in RAX to ASCII string in buffer
int_to_ascii:
    xor rdx, rdx                 ; Clear RDX
    mov rcx, 10                  ; Divisor (base 10)

.int_to_ascii_loop:
    div rcx                      ; Divide RAX by 10, quotient in RAX, remainder in RDX
    add dl, '0'                  ; Convert remainder to ASCII
    dec rdi                      ; Move buffer pointer backward
    mov [rdi], dl                ; Store character
    xor rdx, rdx                 ; Clear remainder
    test rax, rax                ; Check if RAX == 0
    jnz .int_to_ascii_loop       ; Repeat if not

    ret

section .data
    msg_len equ $ - msg          ; Calculate message length
