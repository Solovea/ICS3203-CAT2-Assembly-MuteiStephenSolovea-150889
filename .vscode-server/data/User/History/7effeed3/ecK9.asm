section .data
    prompt db "Enter a number: ", 0
    prompt_len equ $ - prompt
    result_msg db "Factorial: ", 0
    result_msg_len equ $ - result_msg
    newline db 0xA, 0

section .bss
    buffer resb 20         ; Buffer for user input
    number resd 1          ; Space for the input number

section .text
global _start

_start:
    ; Print the prompt
    mov rax, 1             ; Syscall: write
    mov rdi, 1             ; File descriptor: stdout
    mov rsi, prompt        ; Address of the prompt
    mov rdx, prompt_len    ; Length of the prompt
    syscall

    ; Read user input
    mov rax, 0             ; Syscall: read
    mov rdi, 0             ; File descriptor: stdin
    mov rsi, buffer        ; Address of buffer
    mov rdx, 20            ; Max bytes to read
    syscall

    ; Convert input to integer
    lea rsi, [buffer]      ; Address of input buffer
    lea rdi, [number]      ; Address of number variable
    call string_to_int     ; Convert input string to integer

    ; Compute factorial
    mov eax, [number]      ; Load the input number into EAX
    test eax, eax          ; Check if the number is zero
    jz .error              ; If zero, handle as error
    call factorial         ; Call factorial subroutine
    ; Result is now in EAX

    ; Print the result message
    mov rax, 1             ; Syscall: write
    mov rdi, 1             ; File descriptor: stdout
    mov rsi, result_msg    ; Address of the result message
    mov rdx, result_msg_len ; Length of the result message
    syscall

    ; Convert factorial result to ASCII
    mov edi, eax           ; Load the result into EDI
    lea rsi, [buffer + 19] ; Temporary buffer for ASCII
    call int_to_ascii      ; Convert result to ASCII

    ; Print the result
    lea rsi, [buffer + 19]
    mov rdx, buffer + 20   ; End of buffer
    sub rdx, rsi           ; Calculate string length
    mov rax, 1             ; Syscall: write
    mov rdi, 1             ; File descriptor: stdout
    syscall

    ; Print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Exit program
    mov rax, 60            ; Syscall: exit
    xor rdi, rdi           ; Return code: 0
    syscall

.error:
    ; Handle error case (e.g., factorial of zero or invalid input)
    mov rax, 1             ; Syscall: write
    mov rdi, 1             ; File descriptor: stdout
    mov rsi, newline       ; Print a newline to signify error
    mov rdx, 1
    syscall
    ; Exit program
    mov rax, 60            ; Syscall: exit
    xor rdi, rdi           ; Return code: 0
    syscall


; Subroutine: Factorial
factorial:
    push rbx               ; Preserve RBX on the stack
    push rcx               ; Preserve RCX on the stack

    cmp eax, 1             ; Base case: if number <= 1
    jle .base_case

    ; Recursive case
    push rax               ; Save current number on stack
    dec eax                ; Decrement EAX
    call factorial         ; Recursive call
    pop rbx                ; Restore original number
    imul eax, ebx          ; Multiply result by original number
    jmp .done

.base_case:
    mov eax, 1             ; Factorial of 1 or 0 is 1

.done:
    pop rcx                ; Restore RCX from the stack
    pop rbx                ; Restore RBX from the stack
    ret

; Subroutine: String to Integer
string_to_int:
    xor rax, rax           ; Clear result
    xor rcx, rcx           ; Clear index
.convert_loop:
    mov bl, [rsi + rcx]    ; Load a character
    cmp bl, 0xA            ; Check for newline
    je .done_convert
    cmp bl, 0x30           ; Ensure input is a digit (ASCII '0'-'9')
    jb .done_convert
    cmp bl, 0x39
    ja .done_convert
    sub bl, '0'            ; Convert ASCII to integer
    imul rax, rax, 10      ; Multiply current result by 10
    add rax, rbx           ; Add current digit
    inc rcx                ; Move to the next character
    jmp .convert_loop

.done_convert:
    mov [rdi], eax         ; Store result in memory
    ret

; Subroutine: Integer to ASCII
int_to_ascii:
    xor rdx, rdx           ; Clear remainder
    mov rcx, 10            ; Divisor for base 10
.int_to_ascii_loop:
    xor rbx, rbx           ; Clear RBX
    div rcx                ; Divide RDI by 10
    add dl, '0'            ; Convert remainder to ASCII
    dec rsi                ; Move buffer pointer backward
    mov [rsi], dl          ; Store character
    test rax, rax          ; Check if quotient is 0
    jnz .int_to_ascii_loop
    ret