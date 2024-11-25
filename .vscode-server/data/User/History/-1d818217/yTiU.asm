section .data
    arr db 3, 5, 7, 9, 11     ; sample input array (replace with actual input logic)
    arr_len equ 5             ; length of the array

section .bss
    buffer resb 20            ; Reserve space for output (20 bytes, enough for 5 digits)

section .text
global _start

_start:
    ; Print the array before reversal
    mov rsi, arr              ; Load the array into RSI
    mov rdx, arr_len          ; Set RDX to the length of the array
    call print_array

    ; Reverse the array
    mov rsi, 0                ; start index
    mov rdi, arr_len - 1      ; end index

.reverse_loop:
    cmp rsi, rdi
    jge .end_reverse          ; if indices meet or cross, stop

    mov al, [arr + rsi]       ; load element at start index
    xchg al, [arr + rdi]      ; swap with end index
    mov [arr + rsi], al       ; store swapped element back

    inc rsi                   ; move start index forward
    dec rdi                   ; move end index backward
    jmp .reverse_loop

.end_reverse:
    ; Print the array after reversal
    mov rsi, arr              ; Load the array into RSI again for printing
    mov rdx, arr_len          ; Set RDX to the length of the array
    call print_array

    ; Exit program
    mov rax, 60               ; Syscall number for exit
    xor rdi, rdi              ; Return code 0
    syscall

print_array:
    ; Print elements of the array in buffer
    ; Print each byte in the array
    ; Loop through the array and print each element

    mov rcx, 0                ; Reset index counter
.print_loop:
    cmp rcx, rdx              ; Compare index with array length
    jge .done_printing        ; If index >= length, exit loop

    ; Print each byte
    mov al, [rsi + rcx]       ; Load element into AL register
    add al, '0'               ; Convert number to ASCII (for single digit)
    mov rbx, 1                ; File descriptor (stdout)
    mov rdx, 1                ; Length of output (1 byte)
    syscall                   ; Print byte

    inc rcx                   ; Increment index counter
    jmp .print_loop           ; Repeat loop

.done_printing:
    ; Print a newline character
    mov al, 0xA               ; Newline ASCII character
    mov rbx, 1                ; File descriptor (stdout)
    mov rdx, 1                ; Length of output (1 byte)
    syscall                   ; Print newline
    ret
