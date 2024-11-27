section .data
    prompt db "Enter a number: ", 0         ; Prompt for user input
    prompt_len equ $ - prompt               ; Length of the prompt message
    result_msg db "Factorial: ", 0          ; Message to display before factorial result
    result_msg_len equ $ - result_msg      ; Length of result message
    error_msg db "Error: Invalid input or overflow.", 0xA, 0 ; Error message
    error_msg_len equ $ - error_msg       ; Length of error message
    newline db 0xA, 0                      ; Newline character for formatting

section .bss
    buffer resb 20                         ; Buffer to store user input

section .text
global _start

_start:
    ; Print prompt to the user
    mov rax, 1                            ; Syscall: write
    mov rdi, 1                            ; File descriptor: stdout
    mov rsi, prompt                       ; Pointer to prompt message
    mov rdx, prompt_len                   ; Length of prompt message
    syscall

    ; Read user input
    mov rax, 0                            ; Syscall: read
    mov rdi, 0                            ; File descriptor: stdin
    mov rsi, buffer                       ; Pointer to buffer
    mov rdx, 20                           ; Max input size
    syscall

    ; Convert input from string to integer
    lea rsi, [buffer]                     ; Pointer to input buffer
    xor rdi, rdi                           ; Clear RDI (used for input integer)
    call string_to_int                    ; Convert input string to integer
    mov rdi, rax                          ; Move result to RDI for factorial calculation

    ; Validate the input
    call validate_input                   ; Check if input is valid
    test rax, rax                         ; Check return value
    jz _error                             ; Jump to error if invalid

    ; Calculate factorial
    call factorial                        ; Result will be in RAX

    ; Print result message
    mov rax, 1                            ; Syscall: write
    mov rdi, 1                            ; File descriptor: stdout
    mov rsi, result_msg                   ; Pointer to result message
    mov rdx, result_msg_len               ; Length of result message
    syscall

    ; Convert result to string and print
    mov rdi, rax                          ; Move factorial result to RDI
    lea rsi, [buffer + 19]                ; Pointer to end of buffer
    call int_to_ascii                     ; Convert RDI to ASCII
    mov rsi, rdi                          ; Update RSI to the ASCII string start
    lea rdx, [buffer + 19]                ; Pointer to end of buffer
    sub rdx, rdi                          ; Calculate the length of the number
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
    mov rax, 60                           ; Syscall: exit
    xor rdi, rdi                          ; Exit code 0
    syscall

_error:
    ; Print error message
    mov rax, 1                            ; Syscall: write
    mov rdi, 1                            ; File descriptor: stdout
    mov rsi, error_msg                    ; Pointer to error message
    mov rdx, error_msg_len                ; Length of error message
    syscall

    ; Exit with error code
    mov rax, 60                           ; Syscall: exit
    mov rdi, 1                            ; Exit code 1
    syscall

validate_input:
    cmp rdi, 0                            ; Check if input is non-negative
    jl .invalid                           ; If negative, invalid
    cmp rdi, 20                           ; Limit input to prevent overflow
    jg .invalid                           ; If too large, invalid
    mov rax, 1                            ; Valid input
    ret

.invalid:
    xor rax, rax                          ; Invalid input
    ret

factorial:
    cmp rdi, 1                            ; Base case: if n <= 1
    jle .base_case

    ; Recursive case
    push rdi                               ; Save the current value of RDI
    dec rdi                                ; n - 1
    call factorial                         ; Recursive call
    pop rdi                                ; Restore RDI
    imul rax, rdi                          ; Multiply result with n
    jo _error                              ; Check for overflow
    ret

.base_case:
    mov rax, 1                             ; Base case: factorial(1) = 1
    ret

string_to_int:
    xor rax, rax                           ; Clear RAX (result)
    xor rcx, rcx                           ; Clear RCX (sign)
.next_char:
    movzx rdx, byte [rsi]                  ; Load next character
    cmp rdx, 0xA                           ; Check for newline
    je .done                               ; Stop if newline
    cmp rdx, 0x30                          ; Check if digit ('0')
    jl .done                               ; Stop if not digit
    cmp rdx, 0x39                          ; Check if digit ('9')
    jg .done                               ; Stop if not digit
    imul rax, rax, 10                      ; Multiply result by 10
    sub rdx, 0x30                          ; Convert ASCII to integer
    add rax, rdx                           ; Add digit to result
    inc rsi                                ; Move to next character
    jmp .next_char
.done:
    ret

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
