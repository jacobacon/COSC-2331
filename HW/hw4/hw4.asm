SECTION .data

	array dd 5,6,7,8,9,2,1,0,2,4,8,6,3,9,7
	array_len db 15
	newline db 10

	msg_all db "Printing all: "
	msg_all_len equ $-msg_all

	msg_odd db "Printing odd: "
	msg_odd_len equ $-msg_odd

	msg_even db "Printing even: "
	msg_even_len equ $-msg_even


SECTION .bss
	num resd 4
	count resd 1


SECTION .text
	global _start

	_start:

	push msg_all			;Push The Output Message
	push msg_all_len		;Push the length
	call writeString		;Print the message


	mov eax, array			;Store Array
	mov ecx, 15			;Counter
	mov edx, 0
	call printAll			;Call PrintAll Subroutine

	push newline			;Push a newline
	push 1				;Length
	call writeString		;Print a newline


	
	push msg_even
	push msg_even_len
	call writeString

	

	mov eax, array
	mov ecx, 8
	mov edx, 0
	call printEven

	push newline
	push 1
	call writeString

	push msg_odd
	push msg_odd_len
	call writeString

	

	mov eax, array
	mov ecx, 7
	mov edx, 1
	call printOdd

	push newline
	push 1
	call writeString



	
	call exit



printAll:
	mov ebx, [eax + edx*4]
	add ebx, '0'
	mov [num], ebx
	push num
	push dword 1

	call writeString

	inc edx

	;dec byte [ecx]
	;jnz printAll
	loop printAll

	ret



printEven:

	mov ebx, [eax + edx*4]
	add ebx, '0'
	mov [num], ebx
	push num
	push dword 1

	call writeString

	add edx, 2

	loop printEven

	ret


printOdd:

	mov ebx, [eax + edx*4]
	add ebx, '0'
	mov [num], ebx
	push num
	push dword 1

	call writeString

	add edx, 2

	loop printOdd

	ret


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


