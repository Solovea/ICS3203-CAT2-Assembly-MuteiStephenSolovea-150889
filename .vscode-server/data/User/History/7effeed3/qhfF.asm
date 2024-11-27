section .data
    factorial_res dq 1            ; Store factorial result (64-bit)
    msg db "Factorial: ", 0
    newline db 0xA, 0             ; Newline character
    debug_msg db "Debug: ", 0
    debug_newline db 0xA, 0       ; Debug newline

section .bss
    buffer resb 20                ; Buffer to hold ASCII representation of the number

section .text
global _start

_start:
    mov rdi, 5                    ; Calculate factorial of 5
    call factorial                ; Call factorial subroutine

    ; Store the result in factorial_res
    mov [factorial_res], rax      ; Store the result in factorial_res

    ; Print the result message
    mov rax, 1                    ; Syscall number for write
    mov rdi, 1                    ; File descriptor (stdout)
    mov rsi, msg                  ; Pointer to message
    mov rdx, msg_len              ; Length of the message
    syscall

    ; Convert factorial result to ASCII and print
    mov rax, [factorial_res]      ; Load the result into RAX
    lea rdi, [buffer + 19]        ; Point to the end of the buffer
    call int_to_ascii             ; Convert RAX to ASCII in buffer

    ; Print debug message (check if conversion is working)
    mov rax, 1                    ; Syscall number for write
    mov rdi, 1                    ; File descriptor (stdout)
    mov rsi, debug_msg            ; Pointer to debug message
    mov rdx, debug_msg_len        ; Length of debug message
    syscall

    ; Print the result (converted number)
    lea rsi, [buffer + 19]        ; Pointer to the end of the number
    sub rsi, rdi                  ; Calculate the length (start pointer - current pointer)
    mov rdx, rsi                  ; Move the length into rdx

    ; Print the number (debug)
    mov rax, 1                    ; Syscall number for write
    mov rdi, 1                    ; File descriptor (stdout)
    lea rsi, [buffer + 19]        ; Pointer to the number
    syscall

    ; Print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Exit program
    mov rax, 60                   ; Syscall number for exit
    xor rdi, rdi                  ; Return code 0
    syscall

factorial:
    cmp rdi, 1
    jle .base_case                ; If rdi <= 1, base case reached

    ; Recursive case
    push rdi                      ; Save current RDI value on the stack
    dec rdi                       ; Decrement RDI
    call factorial                ; Recursive call

    pop rdi                       ; Restore RDI
    imul rax, rdi                 ; Multiply RAX (result) with RDI
    ret

.base_case:
    mov rax, 1                    ; Base case: factorial(1) = 1
    ret

; Convert integer in RAX to ASCII string in buffer
int_to_ascii:
    xor rdx, rdx                  ; Clear RDX (remainder)
    mov rcx, 10                   ; Divisor (base 10)

.int_to_ascii_loop:
    div rcx                       ; Divide RAX by 10, quotient in RAX, remainder in RDX
    add dl, '0'                   ; Convert remainder to ASCII
    dec rdi                       ; Move buffer pointer backward
    mov [rdi], dl                 ; Store character
    xor rdx, rdx                  ; Clear remainder
    test rax, rax                 ; Check if RAX == 0
    jnz .int_to_ascii_loop        ; Repeat if not

    ret

section .data
    msg_len equ $ - msg           ; Calculate message length
    debug_msg_len equ $ - debug_msg  ; Length of debug message