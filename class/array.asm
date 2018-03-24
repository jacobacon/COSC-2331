SECTION .data
array TIMES 4 db 'a'
;array db 'a','a','a','a'
array_len equ 4

newLine db 10
count db 0

section .bss
newMsg resb 6

SECTION .text
global _start


_start:

	mov eax, array
	mov ebx, 0
	mov ecx, array_len

	checkOneByte:
	mov edx, [eax + ebx]
	cmp dl, 'a'
	jnz skipCount
	inc byte [count]

	skipCount:
	inc ebx
	loop checkOneByte
	
	mov byte al, [count]
	add al, '0'
	mov byte [count], al
	
	mov edx, 1
	mov ecx, count
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

