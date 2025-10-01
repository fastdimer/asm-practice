section .data
num     dw 10
MSG_OK  db 'Number is OK',10
LEN_OK  equ $-MSG_OK
MSG_BAD db 'Number is NOT OK',10
LEN_BAD equ $-MSG_BAD

section .text
global main
global _start

main:
    mov ecx, 0
    movzx ecx, word [num]
    mov ebx, 1
.loop:
    inc ebx
    mov eax, ecx
    xor edx, edx
    div ebx
    test edx, edx
    jnz .loop
    cmp ebx, ecx
    je .isprime
    lea rsi, [MSG_BAD]
    mov edx, LEN_BAD
    jmp .write
.isprime:
    lea rsi, [MSG_OK]
    mov edx, LEN_OK
.write:
    mov rax, 1
    mov rdi, 1
    syscall
    mov eax, 0
    ret

_start:
    call main
    mov rdi, rax
    mov rax, 60
    syscall
