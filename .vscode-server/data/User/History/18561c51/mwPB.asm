section .data
    sensor_val db 80          ; simulated sensor value (can be user-input)
    motor_status db 0         ; motor status (1 = on, 0 = off)
    alarm_status db 0         ; alarm status (1 = active, 0 = inactive)

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
    mov [alarm_status], 1
    jmp .exit

.stop_motor:
    mov [motor_status], 0
    jmp .exit

.start_motor:
    mov [motor_status], 1

.exit:
    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80
