SECTION .data

msg db "The Sum is:",0xA,0xD
len equ $ - msg


SECTION .bss

sum resb 1



SECTION .text

global _start


_start:
	mov eax, 3
	mov ebx, 4
	add eax, ebx

	add eax, '0'
	mov [sum], eax

	mov ecx, msg
	mov edx, len
	mov eax, 4
	mov ebx, 1
	int 80h

	mov ecx, sum
	mov edx, 1
	mov eax, 4
	mov ebx, 1
	int 80h

	mov eax, 1
	int 80h

