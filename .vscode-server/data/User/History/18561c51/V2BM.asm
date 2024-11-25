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

    ; Debug: print raw input to verify input is captured correctly
    mov rax, 1                    ; Syscall number for write
    mov rdi, 1                    ; File descriptor (stdout)
    mov rsi, buffer               ; Pointer to buffer
    mov rdx, 100                  ; Max number of bytes to read
    syscall

    ; Process the input and store numbers in array (assuming space-separated integers)
    lea rsi, [buffer]             ; Point to the start of the buffer
    lea rdi, [arr]                ; Point to the start of the array
    call process_input            ; Process the input into an array of integers

    ; Debugging: print the array before reversal
    mov rsi, arr                  ; Pointer to the array
    mov rdx, 20                   ; Max number of elements to print
    call print_array              ; Print the array before reversal

    ; Reverse the array
    lea rsi, [arr]                ; Point to the start of the array
    mov rcx, 20                   ; Max length of the array (20 elements)
    call reverse_array            ; Reverse the array

    ; Print the reversed array message
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
    ; Convert space-separated input string to an array of numbers
    xor rcx, rcx                  ; Clear counter (index for array)
.process_input_loop:
    mov al, [rsi]                 ; Load the byte (character)
    cmp al, 0xA                    ; Check for newline character (end of input)
    je .done_input                 ; If newline, end input processing
    cmp al, 0x20                   ; Check for space (separator between numbers)
    je .skip_space                 ; Skip space

    sub al, '0'                    ; Convert character to integer ('0' -> 0, '1' -> 1, etc.)
    mov [rdi + rcx], al           ; Store number in array
    inc rcx                        ; Move to next position in array

.skip_space:
    inc rsi                        ; Move to next byte (next character)
    jmp .process_input_loop        ; Continue loop

.done_input:
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
