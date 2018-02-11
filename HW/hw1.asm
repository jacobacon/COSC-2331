SECTION .data
	;Setup Output Strings
	msg db "Enter Your Goals For COSC2331 in 80 characters: "
	msg_len equ $-msg

	msgtwo db "So, Your Goal Is, "
	msgtwo_len equ $-msgtwo
SECTION .bss
	;Create a buffer for input
	input resb 80

SECTION .text

	global _start
_start:
	mov edx, msg_len		;Set message length
	mov ecx, msg			;Set message
	mov ebx, 1			;STDOUT
	mov eax, 4			;sys write
	int 80h				;Interrupt

	mov eax, 3			;sys in
	mov ebx, 0			;STDIN
	mov ecx, input			;store in input
	mov edx, 80			;read 80 in
	int 80h				;interrupt

	mov edx, msgtwo_len		;Set Message Two Length
	mov ecx, msgtwo			;Set Message Two
	mov ebx, 1			;STDOUT
	mov eax, 4			;sys write
	int 80h				;interrupt

	mov edx, 80			;set length of message
	mov ecx, input			;recall input
	mov ebx, 1			;STDOUT
	mov eax, 4			;syswrite
	int 80h				;interrupt

	mov eax, 1			;sys exit
	int 80h				;interrupt
