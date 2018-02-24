SECTION .data
	;Setup Output Strings
	msg db "Enter a String of 50 Characters Max: "
	msg_len equ $-msg

	msgtwo db "Your Message: "
	msgtwo_len equ $-msgtwo
SECTION .bss
	;Create a buffer for input
	input resb 51
	input_len resw 1

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
	mov edx, 51			;read 51 in
	int 80h				;interrupt

	mov dword [input_len], eax	;Put msg length into ecx

	mov al, [input+1]

	mov edx, 2			;set input message length
	mov ecx, dword al			;set message to input
	mov ebx, 1			;STDOUT
	mov eax, 4			;sys write
	int 80h				;interrupt

	
	
	;mov edx, 51			;set length of message
	;mov ecx, input			;recall input
	;mov ebx, 1			;STDOUT
	;mov eax, 4			;syswrite
	;int 80h			;interrupt

	mov edx, msgtwo_len		;Set Message Two Length
	mov ecx, msgtwo			;Set Message Two
	mov ebx, 1			;STDOUT
	mov eax, 4			;sys write
	int 80h				;interrupt

	;add dword [input_len], 48

	;mov edx, 80
	;mov ecx, input_len
	;mov ebx, 1
	;mov eax, 4
	;int 80h

	loop:				;start loop
	
	mov edx, 51			;set input message length
	mov ecx, input			;set message to input
	mov ebx, 1			;STDOUT
	mov eax, 4			;sys write
	int 80h				;interrupt

	
	
	

	
	dec dword [input_len]		;dec input_len
	jnz loop			;cont. loop until 0


	mov ebx, 0			;0 Status code
	mov eax, 1			;sys exit
	int 80h				;interrupt




		

