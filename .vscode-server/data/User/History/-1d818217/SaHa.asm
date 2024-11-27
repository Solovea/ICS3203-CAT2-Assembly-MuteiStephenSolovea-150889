section .data
    prompt db "Enter 5 integers (space-separated): ", 0
    prompt_len equ $ - prompt
    output_msg db "Reversed array: ", 0
    output_msg_len equ $ - output_msg
    newline db 0xA, 0

section .bss
    buffer resb 100       ; Reserve space for user input
    array resd 5          ; Array of 5 integers

section .text
global _start

_start:
    ; Print the prompt
    mov rax, 1            ; Syscall: write
    mov rdi, 1            ; File descriptor: stdout
    mov rsi, prompt       ; Address of the prompt
    mov rdx, prompt_len   ; Length of the prompt
    syscall

    ; Read user input
    mov rax, 0            ; Syscall: read
    mov rdi, 0            ; File descriptor: stdin
    mov rsi, buffer       ; Address of buffer
    mov rdx, 100          ; Max bytes to read
    syscall

    ; Convert input to integers and store in array
    lea rsi, [buffer]     ; Address of buffer
    lea rdi, [array]      ; Address of array
    call parse_input

    ; Reverse the array
    lea rsi, [array]      ; Address of array
    mov rcx, 5            ; Number of elements
    call reverse_array

    ; Print the output message
    mov rax, 1            ; Syscall: write
    mov rdi, 1            ; File descriptor: stdout
    mov rsi, output_msg   ; Address of the output message
    mov rdx, output_msg_len ; Length of the message
    syscall

    ; Print the reversed array
    lea rsi, [array]      ; Address of array
    mov rcx, 5            ; Number of elements
    call print_array

    ; Exit the program
    mov rax, 60           ; Syscall: exit
    xor rdi, rdi          ; Return code: 0
    syscall

; Subroutine: Parse input
; Converts space-separated integers from buffer to array
parse_input:
    xor rcx, rcx          ; Element index (0)
    mov rbx, 0            ; Current number
.parse_loop:
    mov al, [rsi]         ; Read character
    cmp al, 0xA           ; Check for newline
    je .done_parse
    cmp al, ' '           ; Check for space
    je .store_number

    ; Convert ASCII to integer
    sub al, '0'
    imul rbx, rbx, 10     ; Multiply previous number by 10
    add rbx, rax          ; Add current digit
    jmp .next_char

.store_number:
    mov [rdi + rcx * 4], rbx ; Store number in array
    xor rbx, rbx          ; Reset current number
    inc rcx               ; Move to the next array element
.next_char:
    inc rsi               ; Move to the next character
    jmp .parse_loop

.done_parse:
    mov [rdi + rcx * 4], rbx ; Store the last number
    ret

; Subroutine: Reverse array
reverse_array:
    xor rbx, rbx          ; Start index
    dec rcx               ; End index
.reverse_loop:
    cmp rbx, rcx          ; Check if pointers meet or cross
    jge .done_reverse

    ; Swap elements at start and end
    mov eax, [rsi + rbx * 4] ; Load start element
    xchg eax, [rsi + rcx * 4] ; Swap with end element
    mov [rsi + rbx * 4], eax ; Store swapped value at start

    inc rbx               ; Increment start index
    dec rcx               ; Decrement end index
    jmp .reverse_loop

.done_reverse:
    ret

; Subroutine: Print array
print_array:
    xor rbx, rbx          ; Element index
.print_loop:
    cmp rbx, rcx          ; Check if all elements are printed
    jge .done_print

    ; Convert number to string
    mov eax, [rsi + rbx * 4] ; Load array element
    lea rdi, [buffer + 20] ; Temporary buffer for number
    call int_to_ascii

    ; Print number
    lea rsi, [buffer + 20]
    call print_string

    ; Print space
    mov rax, 1            ; Syscall: write
    mov rdi, 1            ; File descriptor: stdout
    mov rsi, ' '          ; Space character
    mov rdx, 1            ; Length: 1
    syscall

    inc rbx               ; Next array element
    jmp .print_loop

.done_print:
    ; Print newline
    mov rax, 1            ; Syscall: write
    mov rdi, 1            ; File descriptor: stdout
    mov rsi, newline      ; Newline character
    mov rdx, 1            ; Length: 1
    syscall
    ret

; Subroutine: Convert integer to ASCII
int_to_ascii:
    xor rdx, rdx          ; Clear remainder
    mov rcx, 10           ; Divisor (base 10)
.int_to_ascii_loop:
    div rcx               ; Divide EAX by 10
    add dl, '0'           ; Convert remainder to ASCII
    dec rdi               ; Move buffer pointer backward
    mov [rdi], dl         ; Store character
    xor rdx, rdx          ; Clear remainder
    test eax, eax         ; Check if quotient is 0
    jnz .int_to_ascii_loop
    ret

; Subroutine: Print string
print_string:
    mov rdx, 20           ; Max length of the string
    mov rax, 1            ; Syscall: write
    mov rdi, 1            ; File descriptor: stdout
    syscall
    ret
