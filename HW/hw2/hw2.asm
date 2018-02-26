SECTION .data
	;Setup Output Strings
	msg db "Enter a String of 50 Characters Max: "
	msg_len equ $-msg

	msgtwo db "Your Original Message: "
	msgtwo_len equ $-msgtwo

	msgupper db "Your Message Uppercase: "
	msgupper_len equ $-msgupper

	msglower db "Your Message Lowercase: "
	msglower_len equ $-msglower 
SECTION .bss
	;Create a buffer for input
	input resb 51
	input_len resw 1
	counter resw 1

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

	mov edx, msgtwo_len		;Set Message Two Length
	mov ecx, msgtwo			;Set Message Two
	mov ebx, 1			;STDOUT
	mov eax, 4			;sys write
	int 80h				;interrupt

	mov edx, [input_len]		;set length of message
	mov ecx, input			;recall input
	mov ebx, 1			;STDOUT
	mov eax, 4			;syswrite
	int 80h				;interrupt

	
	;	--------MAKE ALL UPPERCASE-
	
	mov dword [counter], input_len

	mov edx, msgupper_len		;set length of message
	mov ecx, msgupper		;recall input
	mov ebx, 1			;STDOUT
	mov eax, 4			;syswrite
	int 80h				;interrupt	

	;make everything uppercase

	mov esi, msg
	upperloop:

	mov edi, esi			;Get the current character
	;inc esi				;Move esi

	cmp byte [esi], 64
	jle upperskip
	
	cmp byte [esi], 123
	jge upperskip

	cmp byte [esi], 90
	jle upperskip
	
	cmp byte [esi], 97
	jge upper
	
	
	
	dec byte [counter]
	jnz upperloop
	jz end				;

	
	;	--------MAKE ALL LOWERCASE-
	
	;mov dword [counter], input_len

	;mov edx, msglower_len		;set length of message
	;mov ecx, msglower		;recall input
	;mov ebx, 1			;STDOUT
	;mov eax, 4			;syswrite
	;int 80h				;interrupt

	;lowerloop:
	
	

	;	--------SKIP CHARACTER-----
	upperskip:
	inc esi
	dec byte [counter]		;dec counter
	jz end				;If = 0, end
	jnz upperloop			;Otherwise continue the loop


	;	--------SKIP CHARACTER-----
	;lowerskip:
	inc esi
	;dec byte [counter]		;dec counter
	;jz end				;If = 0, end
	;jnz lowerloop			;Otherwise continue the loop


	;	--------MAKE LOWERCASE-----
	;lower:

	;Add 32 to make lowercase

	;add byte [edi], 32
	

	;Print for testing
	;mov edx, 1			;set input message length
	;mov ecx, edi			;set message to input
	;mov ebx, 1			;STDOUT
	;mov eax, 4			;sys write
	;int 80h				;interrupt
	
	;dec byte [counter]		;dec counter
	;jz end				;If = 0, end
	;jnz lowerloop			;Otherwise continue the loop




	;	--------MAKE UPPER---------
	upper:				

	sub byte [esi], 32
	;inc esi

	;Print for testing
	mov edx, 1			;set input message length
	mov ecx, [esi]			;set message to input
	mov ebx, 1			;STDOUT
	mov eax, 4			;sys write
	int 80h				;interrupt
	
	inc esi

	dec byte [counter]		;dec counter
	jz end				;If = 0, end
	jnz upperloop			;Otherwise continue the loop

	

	end:

	
			;Print for testing

	;sub esi, [input_len]	
	
	mov edx, 10			;set input message length
	mov ecx, esi			;set message to input
	mov ebx, 1			;STDOUT
	mov eax, 4			;sys write
	int 80h				;interrupt

	mov ebx, 0			;0 Status code
	mov eax, 1			;sys exit
	int 80h				;interrupt




		

