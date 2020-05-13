section .text
global _start
 
_start:
push byte +0xb
pop eax
cdq
push edx
;push dword 0x20207473        ; push 'st  '
mov esi,0x10106463
add esi, 0x10101010
mov dword [esp-4], esi

;push dword 0x6f686c61        ; push 'alho'
mov esi, 0x5e575b50
add esi, 0x11111111
mov dword [esp-8], esi

;push dword 0x636f6c20        ; push ' loc'
mov esi,    0x626e6b10
add esi,    0x01010110
mov dword [esp-12], esi

;push dword 0x676e6970        ; push 'ping'
mov esi, 0x565d5860
add esi, 0x11111110
mov dword [esp-16], esi

sub esp, 16

mov esi,esp
push edx
push word 0x632d             ; push '-c'
mov ecx,esp
push edx
;push dword   0x68732f2f        ; push '//sh'
mov edi,      0x57621e1e
add edi,    0x11111111
mov dword [esp-4], edi

;push dword   0x6e69622f        ; push '/bin'
mov edi,      0x5e58611f
add edi,      0x10110110
mov dword [esp-8], edi

sub esp, 8

mov ebx,esp
push edx
push esi                     ; push address of 'ping...'
push ecx                     ; push address of '-c'
push ebx                     ; push address of '/bin//sh'
mov ecx,esp
int 0x80
