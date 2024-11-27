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
    ; Calculate factorial of 5
    mov rdi, 5
    call factorial

    ; Store the result in factorial_res
    mov [factorial_res], rax

    ; Print the result message
    mov rax, 1                    ; Syscall number for write
    mov rdi, 1                    ; File descriptor (stdout)
    mov rsi, msg                  ; Pointer to message
    mov rdx, msg_len              ; Length of the message
    syscall

    ; Debug: Print raw factorial result in rax
    mov rdi, rax                  ; Copy result into rdi for debugging
    call print_debug_value

    ; Convert factorial result to ASCII
    mov rax, [factorial_res]      ; Load the result into rax
    lea rdi, [buffer + 19]        ; Point to the end of the buffer
    call int_to_ascii             ; Convert rax to ASCII in buffer

    ; Debug: Check the converted ASCII value
    mov rsi, buffer + 19          ; Pointer to the converted number
    call print_debug_string       ; Print ASCII conversion result

    ; Print the result (converted number)
    lea rsi, [buffer + 19]        ; Pointer to the end of the number
    mov rdx, 20                   ; Length of the buffer
    call print_string             ; Print the result

    ; Exit program
    mov rax, 60                   ; Syscall number for exit
    xor rdi, rdi                  ; Return code 0
    syscall

; Factorial subroutine
factorial:
    cmp rdi, 1
    jle .base_case

    ; Recursive case
    push rdi
    dec rdi
    call factorial
    pop rdi
    imul rax, rdi
    ret

.base_case:
    mov rax, 1
    ret

; Convert integer in RAX to ASCII string in buffer
int_to_ascii:
    xor rdx, rdx
    mov rcx, 10

.int_to_ascii_loop:
    div rcx
    add dl, '0'
    dec rdi
    mov [rdi], dl
    xor rdx, rdx
    test rax, rax
    jnz .int_to_ascii_loop
    ret

; Print string subroutine
print_string:
    mov rax, 1                    ; Syscall number for write
    mov rdi, 1                    ; File descriptor (stdout)
    syscall
    ret

; Debug: Print raw integer value
print_debug_value:
    mov rsi, debug_msg            ; Debug message prefix
    mov rdx, debug_msg_len
    mov rax, 1
    mov rdi, 1
    syscall

    mov rax, rdi                  ; Convert integer to ASCII
    lea rdi, [buffer + 19]
    call int_to_ascii

    mov rsi, buffer + 19          ; Print converted integer
    mov rdx, 20
    call print_string
    ret

; Debug: Print string
print_debug_string:
    mov rsi, debug_msg            ; Debug message prefix
    mov rdx, debug_msg_len
    mov rax, 1
    mov rdi, 1
    syscall

    mov rsi, buffer + 19          ; Print buffer
    mov rdx, 20
    call print_string
    ret

section .data
    msg_len equ $ - msg
    debug_msg_len equ $ - debug_msg
