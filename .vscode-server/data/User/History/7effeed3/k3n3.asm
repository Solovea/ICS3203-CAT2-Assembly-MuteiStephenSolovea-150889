section .data
    result_msg db "Factorial: ", 0         ; Message for output
    result_msg_len equ $ - result_msg      ; Length of the result message
    newline db 0xA, 0                      ; Newline character
    buffer resb 20                         ; Buffer to hold ASCII representation of the number

section .bss
    ; No additional bss section required

section .text
global _start

_start:
    ; Input number
    ; Let's hardcode a number for testing purposes (for example 6)
    mov rdi, 6                           ; n = 6 (this can be user input)
    
    ; Call factorial subroutine
    call factorial                       ; Factorial result will be in RAX

    ; Print result message
    mov rax, 1                            ; Syscall: write
    mov rdi, 1                            ; File descriptor: stdout
    mov rsi, result_msg                   ; Pointer to result message
    mov rdx, result_msg_len               ; Length of result message
    syscall

    ; Convert result (in RAX) to ASCII string in buffer
    lea rsi, [buffer + 19]                ; Point to the end of the buffer
    mov rdi, rax                          ; Move factorial result to RDI
    call int_to_ascii                     ; Convert RDI (factorial result) to ASCII

    ; Print the result (converted number)
    mov rsi, rdi                          ; Pointer to the start of the number (ASCII)
    lea rdx, [buffer + 19]                ; Pointer to the end of the buffer
    sub rdx, rsi                          ; Calculate the length of the string
    mov rax, 1                            ; Syscall: write
    mov rdi, 1                            ; File descriptor: stdout
    syscall

    ; Print newline
    mov rax, 1                            ; Syscall: write
    mov rdi, 1                            ; File descriptor: stdout
    mov rsi, newline                      ; Pointer to newline
    mov rdx, 1                            ; Length of newline
    syscall

    ; Exit program
    mov rax, 60                           ; Syscall number for exit
    xor rdi, rdi                          ; Return code 0
    syscall

factorial:
    ; Factorial computation (recursive)
    cmp rdi, 1                            ; Base case: if n <= 1
    jle .base_case

    ; Recursive case
    push rdi                               ; Save the current value of RDI
    dec rdi                                ; n - 1
    call factorial                         ; Recursive call
    pop rdi                                ; Restore RDI
    imul rax, rdi                          ; Multiply result with n
    jo .error                              ; Check for overflow (optional)
    ret

.base_case:
    mov rax, 1                             ; Base case: factorial(1) = 1
    ret

.error:
    ; Handle overflow error (optional)
    mov rax, 60                            ; Syscall number for exit
    mov rdi, 1                             ; Exit code 1 (error)
    syscall

; Convert integer in RAX to ASCII string in buffer
int_to_ascii:
    xor rdx, rdx                           ; Clear RDX (remainder)
    mov rcx, 10                            ; Divisor (base 10)

.convert_loop:
    div rcx                                 ; Divide RAX by 10
    add dl, '0'                             ; Convert remainder to ASCII
    dec rsi                                 ; Move buffer pointer backward
    mov [rsi], dl                           ; Store character
    xor rdx, rdx                            ; Clear remainder
    test rax, rax                           ; Check if RAX == 0
    jnz .convert_loop                       ; Repeat if not
    mov rdi, rsi                            ; Return pointer to start of string
    ret
