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
    xor rbx, rbx                  ; Start index (0)
    mov rdx, rcx                  ; Load array length (rcx)
    dec rdx                       ; Set end index (length - 1)
.reverse_loop:
    cmp rbx, rdx                  ; Compare start and end indices
    jge .done_reverse             ; Exit if indices meet or cross

    mov eax, [rsi + rbx * 4]      ; Load element at start index
    mov ebx, [rsi + rdx * 4]      ; Load element at end index
    mov [rsi + rbx * 4], ebx      ; Swap start with end
    mov [rsi + rdx * 4], eax      ; Swap end with start

    inc rbx                       ; Increment start index
    dec rdx                       ; Decrement end index
    jmp .reverse_loop             ; Repeat loop

.done_reverse:
    ret


print_array:
    xor rcx, rcx                  ; Clear counter
.print_loop:
    cmp rcx, rdx                  ; Compare counter with array length
    jge .done_printing            ; Exit loop if done

    mov eax, [rsi + rcx * 4]      ; Load integer from array
    call print_integer            ; Print the integer
    mov al, 0x20                  ; Print space (ASCII for ' ')
    mov rbx, 1                    ; File descriptor (stdout)
    mov rdx, 1                    ; Length (1 byte)
    syscall

    inc rcx                       ; Increment index
    jmp .print_loop               ; Repeat loop

.done_printing:
    ; Print newline
    mov al, 0xA                   ; Newline character
    mov rbx, 1                    ; File descriptor (stdout)
    mov rdx, 1                    ; Length (1 byte)
    syscall
    ret

print_integer:
    ; Convert and print an integer (in EAX) to stdout
    push rax                      ; Save registers
    push rcx
    push rdx

    xor rcx, rcx                  ; Clear digit counter
    mov rbx, 10                   ; Divisor for base-10
.integer_loop:
    xor rdx, rdx                  ; Clear remainder
    div rbx                       ; Divide EAX by 10
    add dl, '0'                   ; Convert remainder to ASCII
    push rdx                      ; Store digit on stack
    inc rcx                       ; Increment digit counter
    test eax, eax                 ; Check if quotient is 0
    jnz .integer_loop             ; Repeat if not

.print_digits:
    pop rax                       ; Retrieve digit from stack
    mov rbx, 1                    ; File descriptor (stdout)
    mov rdx, 1                    ; Length (1 byte)
    syscall                       ; Print digit
    loop .print_digits            ; Print all digits

    pop rdx                       ; Restore registers
    pop rcx
    pop rax
    ret

