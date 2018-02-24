SECTION .data	
	count db 26
	letter db 65
	letter_len equ $-letter

	newline db 0Ah
	newline_len equ $-newline

SECTION .text

	global _start


_start:

printhello:

	mov eax, 4
	mov ebx, 1
	mov ecx, letter
	mov edx, letter_len
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, newline_len
	int 80h

	inc byte [letter]
	dec byte [count]
	jz end
	
	jmp printhello
	
end:
mov eax, 1
int 80h
