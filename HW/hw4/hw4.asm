SECTION .data

	array db 5,6,7,8,9,2,1,0,2,4,8,6,3,9,7
	array_len db 15
	newline db 10

	msg db "Test"
	msg_len equ $-msg


SECTION .bss
	outstring resw 4


SECTION .text
	global _start

	_start:


	mov eax, array			;Store Array
	mov ebx, array_len		;Store Array_Len
	mov ecx, outstring
	call printAll			;Call PrintAll Subroutine

	push outstring
	push 30
	call writeString	
	
	;mov eax, [array]
	;mov ebx, array_len
	;mov ecx, outstring
	;call printEven

	
	call exit



printAll:
	
	mov bl, [eax]
	mov [ecx], bl
	inc eax
	inc ecx


	dec byte [array_len]
	jnz printAll
	

	ret



printEven:




printOdd:




writeString:

	push ebp
	mov ebp, esp
	pushad				;Push all 32 Bit Registers to save values.

	mov eax, 4			;SYSWRITE
	mov ebx, 1			;STDOUT
	mov ecx, [ebp+12]		;Set to output string
	mov edx, [ebp+8]		;Length of the output
	int 80h				;Interrupt

	popad				;Pop all 32 Bit Registers to Original Values.
	pop ebp
	ret 8




exit:
	mov ebx, 0			;0 Status code
	mov eax, 1			;sys exit
	int 80h				;interrupt


