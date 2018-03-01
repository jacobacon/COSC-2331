SECTION .data

	number dw 0x000F
	count db 16
	newline db 10

SECTION .bss

	outstring resb 4

SECTION .text

	global _start


_start:

	mov eax, [number]		;Get the number
	mov ebx, 0x8000			;Set the comparison mask to ebx
	mov edx, outstring		;Set the output string to edx

loop:
	test eax, ebx			;Test current bit is 1, 0
	jz write_zero			;If its a zero, write zero
	jnz write_one			;If its a one, write a one


write_zero:
	mov byte [edx], '0'		;Move a zero to current location in outstring (edx)
	inc edx				;Move edx
	shr ebx, 1			;Bitshift the mask

	dec byte [count]		;Dec count
	jnz loop			;If (count != 0) -> loop
	jz print			;If (count == 0) -> print

write_one:
	mov byte [edx], '1'		;Move a one to current location in outstring (edx)
	inc edx				;Move edx
	shr ebx, 1			;Bitshift the mask

	dec byte [count]		;Dec count
	jnz loop			;If (count != 0) -> loop
	jz print			;If (count == 0) -> print

print:
	mov eax, 4			;SYSWRITE
	mov ebx, 1			;STDOUT
	mov ecx, outstring		;Set to output string
	mov edx, 16			;Length of the output
	int 80h				;Interrupt

	mov eax, 4			;SYSWRITE
	mov ebx, 1			;STDOUT
	mov ecx, newline		;Set to newline
	mov edx, 1			;Length of the output
	int 80h				;Interrupt

	mov ebx, 0			;0 Status code
	mov eax, 1			;sys exit
	int 80h				;interrupt
