section .data
    prompt db "Enter 5 integers (space-separated): ", 0
    prompt_len equ $ - prompt
    reversed_msg db "Reversed array: ", 0
    reversed_msg_len equ $ - reversed_msg
    newline db 0xA, 0             ; Newline character

section .bss
    arr resd 5                    ; Reserve space for 5 integers
    buffer resb 20                ; Buffer for ASCII conversion

section .text
global _start

_start:
    ; Prompt user for input
    mov rax, 1                    ; Syscall number for write
    mov rdi, 1                    ; File descriptor (stdout)
    mov rsi, prompt               ; Pointer to the prompt message
    mov rdx, prompt_len           ; Length of the prompt message
    syscall

    ; Read user input
    mov rax, 0                    ; Syscall number for read
    mov rdi, 0                    ; File descriptor (stdin)
    lea rsi, [arr]                ; Pointer to array in bss
    mov rdx, 20                   ; Read up to 20 bytes (input size)
    syscall

    ; Reverse the array in place
    lea rsi, [arr]                ; Pointer to the start of the array
    lea rdi, [arr + 16]           ; Pointer to the end of the array
    call reverse_array

    ; Output reversed message
    mov rax, 1                    ; Syscall number for write
    mov rdi, 1                    ; File descriptor (stdout)
    mov rsi, reversed_msg         ; Pointer to the reversed message
    mov rdx, reversed_msg_len     ; Length of the reversed message
    syscall

    ; Print the reversed array
    lea rsi, [arr]                ; Pointer to the start of the array
    mov rcx, 5                    ; Number of elements to print
    call print_array

    ; Exit program
    mov rax, 60                   ; Syscall number for exit
    xor rdi, rdi                  ; Exit code 0
    syscall

; Reverse array in place
reverse_array:
    mov rcx, 2                    ; Half the array size (5 / 2 = 2)
.reverse_loop:
    cmp rcx, 0                    ; If swaps are done, exit
    jz .reverse_done
    mov eax, [rsi]                ; Load element from start
    mov ebx, [rdi]                ; Load element from end
    mov [rsi], ebx                ; Swap start with end
    mov [rdi], eax                ; Swap end with start
    add rsi, 4                    ; Move to the next start element
    sub rdi, 4                    ; Move to the next end element
    loop .reverse_loop
.reverse_done:
    ret

; Print array
print_array:
    mov rax, 1                    ; Syscall number for write
    mov rdi, 1                    ; File descriptor (stdout)
.print_loop:
    cmp rcx, 0                    ; If all elements printed, exit
    jz .print_done
    mov eax, [rsi]                ; Load current element
    call int_to_ascii             ; Convert integer to ASCII
    mov rsi, buffer               ; Pointer to ASCII string
    mov rdx, 20                   ; Length of buffer
    syscall
    mov rax, 1                    ; Write newline
    mov rsi, newline
    mov rdx, 1
    syscall
    add rsi, 4                    ; Move to the next element
    loop .print_loop
.print_done:
    ret

; Convert integer in EAX to ASCII string in buffer
int_to_ascii:
    xor rdx, rdx                  ; Clear RDX for division
    mov rcx, 10                   ; Base 10
    lea rdi, [buffer + 19]        ; Point to the end of the buffer
    mov byte [rdi], 0             ; Null-terminate the buffer
.int_to_ascii_loop:
    div ecx                       ; Divide EAX by 10
    add dl, '0'                   ; Convert remainder to ASCII
    dec rdi                       ; Move buffer pointer back
    mov [rdi], dl                 ; Store ASCII character
    xor rdx, rdx                  ; Clear RDX for next division
    test eax, eax                 ; Check if quotient is 0
    jnz .int_to_ascii_loop        ; Continue if not zero
    lea rsi, [rdi]                ; Point to the start of the ASCII string
    ret
