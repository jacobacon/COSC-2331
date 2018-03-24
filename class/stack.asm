SECTION .data
	msg db "Hello World",10
	msg_len equ $ - msg

	msg2 db "Test!", 10
	msg2_len equ $ - msg2

SECTION .bss

	dataBuffer resb 80
	dataReadLen resd 1

SECTION .text

	global _start


_start:

	push msg
	push dword msg_len
	call print

	push msg2
	push dword msg2_len
	call print

	jmp end


read:
	push ebp
	mov ebp, esp
	
	push ebx
	push ecx
	push edx

	


	ret 8


print:
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
	ret 4

end:
	mov ebx, 0			;0 Status code
	mov eax, 1			;sys exit
	int 80h				;interrupt
