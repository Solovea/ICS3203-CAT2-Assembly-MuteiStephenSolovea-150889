section .data
    factorial_res db 1        ; store factorial result

section .text
global _start

_start:
    mov ecx, 5                ; calculate factorial of 5
    call factorial

factorial:
    push ecx                  ; save current ECX value on stack
    cmp ecx, 1
    jle .return_factorial     ; if ecx <= 1, base case reached

    dec ecx
    call factorial            ; recursive call with ecx - 1
    pop ecx                   ; restore original ECX
    mul ecx                   ; multiply AL with ECX

.return_factorial:
    ret
