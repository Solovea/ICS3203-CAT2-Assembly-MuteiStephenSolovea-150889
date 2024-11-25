section .data
    arr db 3, 5, 7, 9, 11     ; sample input array (can be replaced with actual input logic)
    arr_len equ 5             ; length of the array
    msg db "Reversed Array: ", 0

section .text
global _start

_start:
    ; Print the message
    mov eax, 4                 ; syscall number for write
    mov ebx, 1                 ; file descriptor for stdout
    mov ecx, msg               ; message to display
    mov edx, msg_len           ; length of the message
    int 0x80

    ; Reverse the array
    mov esi, 0                ; start index
    mov edi, arr_len - 1      ; end index

.reverse_loop:
    cmp esi, edi
    jge .end_reverse          ; if indices meet or cross, stop

    mov al, [arr + esi]       ; load element at start index
    xchg al, [arr + edi]      ; swap with end index
    mov [arr + esi], al       ; store swapped element back

    inc esi                   ; move start index forward
    dec edi                   ; move end index backward
    jmp .reverse_loop

.end_reverse:
    ; Display the reversed array
    mov ecx, arr              ; pointer to the start of the array
    mov edx, arr_len          ; length of the array
    call print_array

.exit:
    mov eax, 1                ; syscall number for exit
    xor ebx, ebx              ; exit code 0
    int 0x80

; Helper function to print the array
print_array:
    push edx                  ; save edx (array length)
    print_loop:
        mov eax, 4            ; syscall number for write
        mov ebx, 1            ; file descriptor for stdout
        mov edx, 1            ; print one byte at a time
        int 0x80

        add ecx, 1            ; move to next byte
        dec edx               ; decrease counter
        jnz print_loop        ; continue if array is not fully printed

    pop edx                   ; restore edx
    ret

section .data
    msg_len equ $ - msg        ; calculate message length
