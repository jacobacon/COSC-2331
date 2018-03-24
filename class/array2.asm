SECTION .data
numArray db 1,2
array_len equ 2

newLine db 10


section .bss
sum resb 1

SECTION .text
global _start


_start:

	mov eax, numArray
	mov ebx, 0
	mov ecx, array_len

	addOneByte:
	mov edx, [eax + ebx * 4]
	add byte [sum], dl
	inc ebx
	loop addOneByte
	
	mov byte al, [sum]
	add al, '0'
	mov byte [sum], al
	
	mov edx, 1
	mov ecx, sum
	mov ebx, 1
	mov eax, 4
	int 80h

	mov edx, 1
	mov ecx, newLine
	mov ebx, 1
	mov eax, 4
	int 80h

	mov eax,1
	int 80h

