section .data
    factorial_res dd 1        ; store factorial result (32-bit to handle larger numbers)

section .text
global _start

_start:
    mov ecx, 5                ; calculate factorial of 5
    call factorial            ; call factorial subroutine

    ; Store the result in factorial_res
    mov [factorial_res], eax  ; store the result in factorial_res

.exit:
    mov eax, 1                ; syscall number for exit
    xor ebx, ebx              ; return 0
    int 0x80

factorial:
    cmp ecx, 1
    jle .base_case            ; if ecx <= 1, base case reached

    ; Recursive case
    push ecx                  ; save current ECX value on the stack
    dec ecx                   ; decrement ECX
    call factorial            ; recursive call

    pop ecx                   ; restore ECX
    mul ecx                   ; multiply EAX (result) with ECX
    ret

.base_case:
    mov eax, 1                ; base case: factorial(1) = 1
    ret
