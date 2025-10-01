section .bss
buffer resb 32

section .text
global _start

int2str:
    push rbx
    push rcx
    push rdx
    xor rcx, rcx
.loop1:
    xor rdx, rdx
    mov rbx, 10
    div rbx
    add dl, '0'
    push rdx
    inc rcx
    test rax, rax
    jnz .loop1
    mov r8, rcx
.loop2:
    pop rdx
    mov [rsi], dl
    inc rsi
    loop .loop2
    mov byte [rsi], 0
    pop rdx
    pop rcx
    pop rbx
    ret

_start:
    mov rax, 1234567
    lea rsi, [buffer]
    call int2str
    mov rdx, r8
    lea rsi, [buffer]
    mov rdi, 1
    mov rax, 1
    syscall
    mov rax, 60
    xor rdi, rdi
    syscall
