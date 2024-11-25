section .data
    arr db 3, 5, 7, 9, 11     ; sample input array (replace with actual input logic)
    arr_len equ 5             ; length of the array

section .text
global _start

_start:
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
    ; Output reversed array here if needed (code omitted for brevity)

.exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
