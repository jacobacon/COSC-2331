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

	mov ecx, input

	mov dword [counter], input_len
	call toUpper

	call print

	mov dword [counter], input_len

	call toLower
	call print

	call end


toUpper:
	mov al, [ecx]

	cmp al, 64
	jle nextUpper

	;cmp al, 123
	;jge nextUpper

	cmp al, 97
	jge makeUpper

	ret


toLower:
	mov al, [ecx]

	cmp al, 64
	jle nextLower

	cmp al, 123
	jge nextLower

	cmp al, 90
	jle makeLower

	ret
	

done:
	ret

end:
	mov ebx, 0			;0 Status code
	mov eax, 1			;sys exit
	int 80h				;interrupt

print:  
	sub byte [input_len], 3
	mov ecx, input     		;what to print
        mov edx, [input_len]           	;length of string to be printed
        mov ebx, 1
        mov eax, 4
        int 80h

	ret

nextUpper:
	inc ecx
	dec byte [counter]
	jz done
	jnz toUpper

makeUpper:
	sub byte [ecx], 32
	inc ecx
	dec byte [counter]
	jz done
	jnz toUpper

nextLower:
	inc ecx
	dec byte [counter]
	jz done
	jnz toLower

makeLower:
	add byte [ecx], 32
	inc ecx
	dec byte [counter]
	jz done
	jnz toLower
