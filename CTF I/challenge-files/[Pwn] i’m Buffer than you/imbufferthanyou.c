#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "flagprint.h"

void vuln() {
    int secret = 0x00000000;
    char buffer[16];

    printf("Address of buffer array:   %p\n",(void*)&buffer); // Memory address of buffer array
    printf("Address of secret integer: %p\n",(void*)&secret); // Memory address of secret integer

    printf("Input text into buffer: ");
    gets(buffer); // This may be a vulnerability...

    printf("New value of secret integer: 0x%x\n", secret);

    if(secret == 0x66667562) {
        printf("You found the flag!\n");
        print_flag();
    } else {
        printf("It looks like you didn't overwrite the secret variable or overwrote using the wrong data.");
    }

    exit(0);
}

int main() {
    vuln();
}