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

	
	input resb 51			;Create a buffer for input
	input_len resw 1		;Create a buffer for input length
	counter resw 1			;Create a buffer for counter


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

	mov ecx, input			;Set ECX to Input so we can modify it quicly

	mov dword [counter], input_len	;Set counter to input length
	call toUpper			;Call to upper

	call print			;Print

	mov ecx, input			;Reset ecx
	mov dword [counter], input_len	;Reset counter

	call toLower			;Call to lower
	call print			;Print

	jmp end				;Go to the end


toUpper:
	mov al, [ecx]			;Get the current character

	cmp al, 64			
	jle nextUpper			;Make sure the character is in range

	cmp al, 123			;Make sure the character is in range
	jge nextUpper

	cmp al, 97			;Make a lowercase character uppercase
	jge makeUpper

	ret


toLower:
	mov al, [ecx]			;Get the current character

	cmp al, 64			;Make sure the character is in range
	jle nextLower

	cmp al, 123			;Make sure the character is in range
	jge nextLower

	cmp al, 90			;Make an uppercase character lowercase
	jle makeLower

	ret
	

done:
	ret

end:
	mov ebx, 0			;0 Status code
	mov eax, 1			;sys exit
	int 80h				;interrupt

print:  
	;sub byte [input_len], 3
	mov ecx, input     		;what to print
        mov edx, [input_len]           	;length of string to be printed
        mov ebx, 1
        mov eax, 4
        int 80h

	ret

nextUpper:
	inc ecx				;Move ecx
	dec byte [counter]		;Dec counter
	jz done				;If the counter is 0, end
	jnz toUpper			;Otherwise go back to Upper

makeUpper:
	sub byte [ecx], 32		;Subtract 32 from the character
	inc ecx				;Move ecx
	dec byte [counter]		;Dec counter
	jz done				;If the counter is 0, end
	jnz toUpper			;Otherwise go back to Upper

nextLower:
	inc ecx				;Move ecx
	dec byte [counter]		;Dec counter
	jz done				;If the counter is 0, end
	jnz toLower			;Otherwise go back to Lower

makeLower:
	add byte [ecx], 32		;Add 32 to the character
	inc ecx				;Move ecx
	dec byte [counter]		;Dec counter
	jz done				;If the counter is 0, end
	jnz toLower			;Otherwise go back to Lower
