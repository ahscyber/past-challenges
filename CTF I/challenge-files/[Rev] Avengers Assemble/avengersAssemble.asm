section	.text
	global _start
	
func:
    xor ecx, ecx
    cmp ebx, 0x1
    je L1
    F1:
    cmp ebx, 0x2
    jne L2
    F2:
    cmp ebx, 0x0
    jl L3
    F3:
    cmp ebx, 0x0
    jg L4
    jmp L8
    L1:
    mov ecx, msg
    call print
    jmp F1
    L2:
    mov ecx, msg2
    call print
    jmp F2
    L3:
    mov ecx, msg3
    call print
    jmp F3
    L4:
    mov ecx, msg4
    call print
    L8:
    ret
	
_start:
    mov ebx,0x1
    call func
    mov eax, 1 ;sys_exit
	int 0x80 ;call kernel

section	.data

msg db '1', 0xa
len	equ	$ - msg ;length of msg
msg2 db '2',0xa
msg3 db '3',0xa
msg4 db '4',0xa