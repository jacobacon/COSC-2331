SECTION .data

	msg_isDivisible db "Yes! It is divisible!",10
	msg_is_len equ $ - msg_isDivisible

	msg_isNotDivisible db "No! It is not divisible!",10
	msg_not_len equ $ - msg_isNotDivisible

	val1 db 125
	val2 db 6 

SECTION .text

	global _start			;Start	


	_start:				;Start

	push dword [val1]		;Push var1
	push dword [val2]		;Push var2
	call isDivisible		;Check if isDivisible
	cmp eax, 1			;If it is divisible, print
	je printIsDivisible		;Jump to print if it is divisible

					;Otherwise it isn't divisivle
	push msg_isNotDivisible		;push message
	push msg_not_len		;push length
	call writeString		;print message

	
	jmp exit			;exit


isDivisible:				;int isDivisible(int number 1, int number 2)

	push ebp			;Save ebp
	mov ebp, esp			;setup stack frame
	
	xor eax, eax			;Zero eax
	push ebx			;Save registers
	push ecx
	push edx
	

	mov eax, [ebp + 12]		;Get value 1
	mov ebx, [ebp + 8]		;Get value 2

	div ebx				;Divide val1 / val2

	cmp edx, 0			;Check the remainder if it is 0
	je setDivisible			;If it is, then it is divisible
	
	mov eax, 0			;Set return status to false
	
	pop edx				;Reset registers
	pop ecx	
	pop ebx

	pop ebp				;Reset Stack

	ret 8				;Return to the calling point


setDivisible:
	mov eax, 1			;Set return status to true

	pop edx				;Reset registers
	pop ecx
	pop ebx
	
	pop ebp				;Reset stack
	ret 8				;return to calling point

printIsDivisible:
	push msg_isDivisible
	push msg_is_len
	call writeString

	jmp exit			;Exit

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
	pop ebp				;Reset stack
	ret 8				;Return


exit:
	mov ebx, 0			;Status
	mov eax, 1			;SysExit
	int 80h				;Exit
	
