section .data
    msg1 db "input n = 5",10
    len1 equ $ - msg1
    msg2 db "factorial = ",0
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

    mov rdi, 5
    call fact_rec
    mov rax, rdi

    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, len2
    syscall

    mov rdi, rax
    mov rsi, buf
    call int_to_str

    mov rax, 1
    mov rdi, 1
    mov rsi, buf
    mov rdx, 20
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

fact_rec:
    cmp rdi, 1
    jle .done
    push rdi
    dec rdi
    call fact_rec
    pop rbx
    imul rdi, rbx
.done:
    ret

int_to_str:
    mov rcx, 10
    add rsi, 19
    mov byte [rsi], 10
    dec rsi
.next:
    xor rdx, rdx
    div rcx
    add dl, '0'
    mov [rsi], dl
    dec rsi
    test rax, rax
    jnz .next
    inc rsi
    ret
