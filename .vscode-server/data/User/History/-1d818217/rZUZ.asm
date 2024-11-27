section .data
    prompt db "Enter numbers to reverse (space-separated): ", 0
    prompt_len equ $ - prompt
    newline db 0xA, 0             ; Newline character
    msg db "Reversed numbers: ", 0
    msg_len equ $ - msg

section .bss
    buffer resb 100               ; Reserve space for user input (max 100 bytes)
    arr resb 20                   ; Reserve space for reversed array (max 20 elements)

section .text
global _start

_start:
    ; Print prompt message
    mov rax, 1                    ; Syscall number for write
    mov rdi, 1                    ; File descriptor (stdout)
    mov rsi, prompt               ; Pointer to the prompt
    mov rdx, prompt_len           ; Length of the prompt
    syscall

    ; Read user input (space-separated numbers)
    mov rax, 0                    ; Syscall number for read
    mov rdi, 0                    ; File descriptor (stdin)
    mov rsi, buffer               ; Pointer to buffer
    mov rdx, 100                  ; Max number of bytes to read
    syscall

    ; Process the input and store numbers in array (assuming space-separated integers)
    lea rsi, [buffer]             ; Point to the start of the buffer
    lea rdi, [arr]                ; Point to the start of the array
    call process_input            ; Process the input into an array of integers

    ; Reverse the array
    lea rsi, [arr]                ; Point to the start of the array
    mov rcx, 20                   ; Max length of the array (20 elements)
    call reverse_array            ; Reverse the array

    ; Print the reversed array
    mov rax, 1                    ; Syscall number for write
    mov rdi, 1                    ; File descriptor (stdout)
    mov rsi, msg                  ; Pointer to message
    mov rdx, msg_len              ; Length of message
    syscall

    ; Print the array (reversed)
    mov rsi, arr                  ; Pointer to the reversed array
    mov rdx, 20                   ; Max number of elements to print
    call print_array              ; Print the reversed array

    ; Exit the program
    mov rax, 60                   ; Syscall number for exit
    xor rdi, rdi                  ; Exit code 0
    syscall

process_input:
    xor rcx, rcx                  ; Clear index for array
    xor rbx, rbx                  ; Temporary storage for current number
    xor rdx, rdx                  ; Flag to indicate a number is being processed
.process_input_loop:
    mov al, [rsi]                 ; Load byte (character) from input
    cmp al, 0xA                   ; Check for newline (end of input)
    je .done_input                ; Exit loop on newline
    cmp al, 0x20                  ; Check for space
    je .store_number              ; Store number on space

    sub al, '0'                   ; Convert ASCII to integer ('0' -> 0)
    imul rbx, rbx, 10             ; Multiply current number by 10
    add rbx, rax                  ; Add new digit to current number
    mov rdx, 1                    ; Set flag to indicate number processing
    jmp .next_char

.store_number:
    test rdx, rdx                 ; Check if a number is being processed
    jz .next_char                 ; Skip if no number to store
    mov [rdi + rcx * 4], ebx      ; Store the full number (4 bytes per number)
    inc rcx                       ; Increment array index
    xor rbx, rbx                  ; Reset current number
    xor rdx, rdx                  ; Reset flag

.next_char:
    inc rsi                       ; Move to next input character
    jmp .process_input_loop       ; Repeat loop

.done_input:
    test rdx, rdx                 ; Check if there's a number to store
    jz .exit                      ; Exit if no pending number
    mov [rdi + rcx * 4], ebx      ; Store the last number
    inc rcx                       ; Increment array index
.exit:
    ret


reverse_array:
    ; Reverse the array in place (using two pointers)
    xor rbx, rbx                  ; Set rbx to 0 (start index)
    mov rdx, 19                   ; Set rdx to 19 (end index, array length - 1)
.reverse_loop:
    cmp rbx, rdx                  ; Compare start index (rbx) and end index (rdx)
    jge .done_reverse              ; If indices meet or cross, stop

    mov al, [rsi + rbx]           ; Load element at start index
    xchg al, [rsi + rdx]          ; Swap with element at end index
    mov [rsi + rbx], al           ; Store swapped element back

    inc rbx                        ; Move start index forward
    dec rdx                        ; Move end index backward
    jmp .reverse_loop              ; Repeat loop

.done_reverse:
    ret

print_array:
    ; Print each number in the array (we assume each number is a single digit for simplicity)
    xor rcx, rcx                  ; Clear counter
.print_loop:
    cmp rcx, rdx                  ; Compare counter with max length of array
    jge .done_printing             ; If done, exit loop

    mov al, [rsi + rcx]           ; Load element from array
    add al, '0'                   ; Convert number to ASCII
    mov rbx, 1                    ; File descriptor (stdout)
    mov rdx, 1                    ; Length of output (1 byte)
    syscall                       ; Print the number

    inc rcx                        ; Increment the index
    jmp .print_loop                ; Repeat loop

.done_printing:
    ; Print newline
    mov al, 0xA                    ; Newline character
    mov rbx, 1                     ; File descriptor (stdout)
    mov rdx, 1                     ; Length of output (1 byte)
    syscall                        ; Print newline
    ret
