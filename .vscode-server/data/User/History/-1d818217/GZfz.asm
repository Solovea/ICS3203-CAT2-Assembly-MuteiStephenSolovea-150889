section .data
    arr db 3, 5, 7, 9, 11        ; sample input array (can be replaced with actual input logic)
    arr_len equ 5                ; length of the array
    msg db "Reversed Array: ", 0
    space db ", ", 0             ; separator between array elements
    newline db 0xA, 0            ; newline character

section .text
global _start

_start:
    ; Print the message
    mov eax, 4                   ; syscall number for write
    mov ebx, 1                   ; file descriptor (stdout)
    mov ecx, msg                 ; pointer to message
    mov edx, msg_len             ; length of the message
    int 0x80

    ; Reverse the array
    mov esi, 0                   ; start index
    mov edi, arr_len - 1         ; end index

.reverse_loop:
    cmp esi, edi
    jge .end_reverse             ; if indices meet or cross, stop

    mov al, [arr + esi]          ; load element at start index
    xchg al, [arr + edi]         ; swap with end index
    mov [arr + esi], al          ; store swapped element back

    inc esi                      ; move start index forward
    dec edi                      ; move end index backward
    jmp .reverse_loop

.end_reverse:
    ; Display the reversed array
    mov ecx, arr                 ; pointer to the start of the array
    mov edx, arr_len             ; length of the array
    call print_array

    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

.exit:
    mov eax, 1                   ; syscall number for exit
    xor ebx, ebx                 ; return 0
    int 0x80

; Helper function to print the array
print_array:
    push edx                     ; save array length
    print_loop:
        mov al, [ecx]            ; load array element
        call int_to_ascii        ; convert to ASCII

        ; Print the number
        mov eax, 4               ; syscall number for write
        mov ebx, 1               ; file descriptor (stdout)
        mov ecx, edi             ; pointer to the ASCII buffer
        mov edx, buffer + 10 - edi ; length of the number
        int 0x80

        ; Print separator if not the last element
        dec edx                  ; decrement array length
        jz .end_print_loop       ; if last element, skip separator

        mov eax, 4               ; syscall number for write
        mov ebx, 1               ; file descriptor (stdout)
        mov ecx, space           ; separator ", "
        mov edx, 2               ; length of separator
        int 0x80

        inc ecx                  ; move to the next element
        jmp print_loop

    .end_print_loop:
        pop edx                  ; restore array length
        ret

; Convert integer in AL to ASCII string in buffer
int_to_ascii:
    xor edi, edi                 ; reset buffer pointer
    mov edi, buffer + 10         ; point to the end of the buffer
    xor eax, eax                 ; clear higher bits of EAX
    mov ah, 0                    ; clear AH for division
    mov al, [ecx]                ; load single byte from the array

    mov ebx, 10                  ; divisor (base 10)

.int_to_ascii_loop:
    div bl                       ; divide AL by 10
    add ah, '0'                  ; convert remainder to ASCII
    dec edi                      ; move pointer backward
    mov [edi], ah                ; store character
    xor ah, ah                   ; clear AH
    test al, al                  ; check if AL == 0
    jnz .int_to_ascii_loop       ; repeat if not

    ret

section .bss
    buffer resb 10               ; buffer to hold ASCII representation
