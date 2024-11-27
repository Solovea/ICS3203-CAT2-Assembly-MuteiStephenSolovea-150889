section .data
    sensor_val db 30              ; simulated sensor value (can be user-input)
    motor_status db 0             ; motor status (1 = on, 0 = off)
    alarm_status db 0             ; alarm status (1 = active, 0 = inactive)
    motor_on_msg db "Motor: ON", 0xA, 0
    motor_off_msg db "Motor: OFF", 0xA, 0
    alarm_active_msg db "Alarm: ACTIVE", 0xA, 0
    alarm_inactive_msg db "Alarm: INACTIVE", 0xA, 0

section .text
global _start

_start:
    mov al, [sensor_val]

    ; Check if sensor value requires alarm
    cmp al, 90
    jge .activate_alarm       ; high water level, trigger alarm

    cmp al, 50
    jge .stop_motor           ; moderate level, stop motor
    jmp .start_motor          ; low level, start motor

.activate_alarm:
    mov byte [alarm_status], 1
    jmp .display_status

.stop_motor:
    mov byte [motor_status], 0
    jmp .display_status

.start_motor:
    mov byte [motor_status], 1

.display_status:
    ; Print motor status
    mov al, [motor_status]
    cmp al, 1
    je .motor_on
    mov rsi, motor_off_msg
    jmp .print_msg

.motor_on:
    mov rsi, motor_on_msg

.print_msg:
    mov rax, 1                ; syscall for write
    mov rdi, 1                ; stdout
    mov rdx, 12               ; length of message
    syscall

    ; Print alarm status
    mov al, [alarm_status]
    cmp al, 1
    je .alarm_active
    mov rsi, alarm_inactive_msg
    jmp .print_alarm_msg

.alarm_active:
    mov rsi, alarm_active_msg

.print_alarm_msg:
    mov rax, 1                ; syscall for write
    mov rdi, 1                ; stdout
    mov rdx, 15               ; length of message
    syscall

.exit:
    ; Exit program
    mov eax, 60               ; syscall for exit
    xor edi, edi              ; status 0
    syscall
