SECTION .data
	count db 5
	msg db "Hello World",0Ah
	msg_len equ $-msg

SECTION .text

	global _start


_start:

printhello:

	mov eax, msg
	mov byte [eax], "J"

	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, msg_len
	int 80h

	dec byte [count]
	jz end
	
end:
mov eax, 1
int 80h
