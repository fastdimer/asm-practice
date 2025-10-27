section .data
width  equ 32
height equ 16
star db '*'
space db ' '
newline db 10
line db 256 dup(' ')

section .text
global _start

_start:
    xor r8, r8

row_loop:
    xor r9, r9
    lea rbx, [rel line]

col_loop:
    cmp r8, 0
    je set_star
    cmp r8, height-1
    je set_star
    cmp r9, 0
    je set_star
    cmp r9, width-1
    je set_star

    mov rax, r8
    dec rax
    cmp r9, rax
    je set_star

    mov rax, width
    sub rax, r8
    cmp r9, rax
    je set_star

    mov al, [space]
    jmp store

set_star:
    mov al, [star]

store:
    mov [rbx + r9], al
    inc r9
    cmp r9, width
    jl col_loop

    mov byte [rbx + r9], 10
    inc r9

    mov rax, 1
    mov rdi, 1
    lea rsi, [rel line]
    mov rdx, width
    inc rdx
    syscall

    inc r8
    cmp r8, height
    jl row_loop

    mov rax, 60
    xor rdi, rdi
    syscall