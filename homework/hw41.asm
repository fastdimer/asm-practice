section .data
    msg1 db "input n = 5", 10
    len1 equ $ - msg1
    msg2 db "factorial = ", 0
    len2 equ $ - msg2
    buf db 20 dup(0)

section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg1
    mov rdx, len1
    syscall

    mov rcx, 5
    mov rbx, 1
.loop:
    test rcx, rcx
    jz .done
    imul rbx, rcx
    dec rcx
    jmp .loop
.done:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, len2
    syscall

    mov rax, rbx
    mov rdi, buf
    call int_to_str

    mov rax, 1
    mov rdi, 1
    mov rsi, buf
    mov rdx, 20
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

int_to_str:
    mov rcx, 10
    mov rbx, rdi
    add rbx, 19
    mov byte [rbx], 10
    dec rbx
.next:
    xor rdx, rdx
    div rcx
    add dl, '0'
    mov [rbx], dl
    dec rbx
    test rax, rax
    jnz .next
    inc rbx
    mov rsi, rbx
    ret
