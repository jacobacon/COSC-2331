	SECTION .data

	msg db "@He!ll6o"
	msg_len db $-msg


	SECTION .bss

	counter resd 1

	char resb 1





	SECTION .text

	global _start:



	_start:

	mov dword [counter], 8		;Set the counter
	mov esi, msg			;Set ESI to msg


	;	--------START OF LOOP--------
	loop:				;Start the loop

	
	mov edi, esi			;Get the current character
	inc esi				;Move esi

	
	cmp byte [edi], 64
	jle skip
	
	cmp byte [edi], 123
	jge skip

	cmp byte [edi], 90
	jle lower
	
	cmp byte [edi], 97
	jge upper


	;	--------END OF LOOP--------
	

	
	;	--------SKIP CHARACTER-----
	skip:
	dec byte [counter]		;dec counter
	jz end				;If = 0, end
	jnz loop			;Oetherwise continue the loop


	;	--------MAKE LOWERCASE-----
	lower:

	;Add 32 to make lowercase

	add byte [edi], 32
	;mov byte [edi], "J"

	;Print for testing
	mov edx, 1			;set input message length
	mov ecx, edi			;set message to input
	mov ebx, 1			;STDOUT
	mov eax, 4			;sys write
	int 80h				;interrupt
	
	dec byte [counter]		;dec counter
	jz end				;If = 0, end
	jnz loop			;Otherwise continue the loop




	;	--------MAKE UPPER---------
	upper:				

	sub byte [edi], 32

	;Print for testing
	mov edx, 1			;set input message length
	mov ecx, edi			;set message to input
	mov ebx, 1			;STDOUT
	mov eax, 4			;sys write
	int 80h				;interrupt
	

	dec byte [counter]		;dec counter
	jz end				;If = 0, end
	jnz loop			;Otherwise continue the loop

	

	end:
	mov ebx, 0			;0 Status code
	mov eax, 1			;sys exit
	int 80h				;interrupt
