# CTF I Writeup
This page will serve as a writeup for the CTF I competition problems.

## Cryptography ##
### ABC... It's as easy as 123... ###

>[25 Points] Gabe passes secret notes to Gabby in class without the teacher noticing, but I managed to intercept one. The problem is, there are no words! What does this mean?
6-12-1-7 { 5-1-19-25 _ 1-19 _ 15-14-5 _ 20-23-15 _  20-8-18-5-5 }

This flag is encrypted using an A1Z26 cipher. An A1Z26 cipher simply converts each letter into the number of its position in the alphabet. For example, A is 1, B is 2, C is 3, and Z is 26. We can tell that this flag uses an A1Z26 cipher because no numbers exceed 26 and the challenge name references letters and their number counterparts. After putting the flag in an online A1Z26 decryptor we get that the flag is **flag{easy_as_one_two_three}**.

### Ass Key ###

>[25 Points] I stole this straight off the server’s hard drive, but it doesn’t make any sense. Maybe these numbers mean something? 0110011001101100011000010110011101111011010000010101001101000011010010010100100101011111011010010111001101011111010001010101101001111101
Hint: Computers encode legible text as binary numbers using a certain format.

This flag is the binary representation of ASCII characters. We know that it is in binary because only 0s and 1s are used, and it's likely encoded using ASCII because ASCII is the most common way to encode text. The challenge name and hint also imply that it uses ASCII. We can simply put this into an online binary to ASCII converter and we get that the flag is **flag{ASCII_is_EZ}**.

### It's all about that base ###

>[75 Points] The CS I students are getting really good at base conversions! But this number doesn’t look like any of the bases they’ve seen before… why don’t you convert it to decimal so the students understand it: 888888888
Hint: Look at the largest digit in the provided number.

Quantities can be represented in different ways called bases. We are used to base 10, which includes the digits 0, 1, 2, 3, 4, 5, 6, 7, 8, and 9. However, there are many other bases. For example, computers use base 2, more commonly known as binary. Base 2 only includes the digits 0 and 1. We don't know the base that 888888888 is in, but the hint implies that it is in base 9 because base 9's largest digit is 8. When using an online tool to convert from base 9 to decimal (base 10), we get that the base 10 equivalent is **387420488**.

### Caesar Salad ###

>[50 Points] My letters got jumbled 3 times! Unjumble them please: iodj{glg_Mxolxv_Pdnh_Wklv_Vdodg}
Hint: The names of these challenges help…

This flag is encrypted using a Caesar cipher. This cipher shifts letters in the alphabet by a certain amount. For instance, encoding the message “hello” with a shift of 3 results in “khoor.” We know that this flag is encrypted using a Caesar cipher because the flag appears to already use letters and the challenge name references Caesar. We know that the shift is 3 because of the challenge description, but we can also brute force every possible shift if necessary. When using an online converter, we get that the flag is **flag{did_Julius_Make_This_Salad}**.

## Forensics ##
### Extension Cord ###

>[50 Points] My file isn’t working! Please fix it.
Hint: Computers need a way to tell different types of files apart.

The challenge also provides a file called extension_cord.txt.
When we try to open extension_cord.txt, we get a lot of gibberish. This definitely is not intended to be a text file. If we change the file extension, the computer might then know what to do with it. We can start by changing the file extension to .png because PNG is a common file format and there are some hints of the PNG file header in the file's hex. When we change the file name to extension_cord.png and open it up we can see this image:
![extension_cord.png](extension_cord.png "extension_cord.png image")
The flag is **flag{dot_png_bro}**.

### Stalker ###

>[25 Points] I want to find out where PewDiePie is hiding. I managed to get his IP address, will that help?
193.231.2.32
Hint: flag{USA_Allen}

This challenge is asking us to find a location using an IP Address. This can be done easily using an online tool. After putting the IP in an online tool that gets the location from an IP Address, we get that the country is Romania and the city is Bucharest. If we format the flag the way the hint says, we get that the flag is **flag{Romania_Bucharest}**.

### Unzip... Unzip... Unzip... Unzip... ###

>[175 Points] 1000 zips in a zip
1000 zips in a zip
Zip one out, check it out 
999 zips in a zip
Hint: Script the unzip

The challenge also provides a file called 1000.zip.

When examining 1000.zip, we find that it contains a file called 999.zip. If we continue to unzip these files, we find a pattern in which each zip file will contain another zip file with a name one number lower than the previous. Obviously, the goal is to unzip all the nested zip files until we reach 1.zip, which will likely contain the flag. Manually unzipping the files would take too long, so we should create a script. In this case, we made a Python script in Windows:
```python
import os

count = 1000
while count > 0:
    os.system("7z e " + str(count) + ".zip")
    os.system("del " + str(count) + ".zip")
    count -= 1
```
This script uses the 7zip program to unzip a file, then deletes the old file to avoid clutter. When the script finishes execution, we find a text file that contains **flag{look_at_all_those_zips}**.

## Reverse Engineering ##
### Swift Swiftly ###

>[75 Points] Aha! You know Swift, right? Try to hack into this for me.

The challenge also provides a file called swiftSwiftly.swift.

When we open up swiftSwiftly.swift, we get the following code:
```swift
print("Enter secret password: ")
let userInput : String = readLine()!
let startIndex = userInput.index(userInput.startIndex, offsetBy:"flag{".count)
let endIndex = userInput.index(userInput.endIndex, offsetBy: -2)
let input = userInput[startIndex...endIndex]
if (checkPassword(password:String(input))) {
    print("Access granted.")
} else {
    print("Access denied!")
}

// You'll never be able to crack this password! After all, I never typed it out...

func checkPassword(password:String) -> Bool {
    let arr = Array(password)
    return password.count ## 31 &&
      arr[0]  ## "s" &&
      arr[29] ## "o" &&
      arr[4]  ## "t" &&
      arr[2]  ## "i" &&
      arr[23] ## "r" &&
      arr[3]  ## "f" &&
      arr[17] ## "a" &&
      arr[1]  ## "w" &&
      arr[7]  ## "s" &&
      arr[10] ## "w" &&
      arr[5]  ## "_" &&
      arr[9]  ## "a" &&
      arr[11] ## "e" &&
      arr[15] ## "e" &&
      arr[8]  ## "_" &&
      arr[12] ## "s" &&
      arr[20] ## "_" &&
      arr[14] ## "m" &&
      arr[6]  ## "i" &&
      arr[24] ## "a" &&
      arr[18] ## "n" &&
      arr[13] ## "o" &&
      arr[19] ## "d" &&
      arr[21] ## "a" &&
      arr[16] ## "_" &&
      arr[27] ## "_" &&
      arr[30] ## "o" &&
      arr[25] ## "y" &&
      arr[22] ## "r" &&
      arr[28] ## "t" &&
      arr[26] ## "s"
}
```
The checkPassword function seems to hold the correct password in plaintext, only split into an array of its characters. We could manually reverse engineer the password by looking at the array elements one by one, or rewrite and rerun the code to print out the elements of the array. Either way, we get that the password is **swift_is_awesome_and_arrays_too**, which is the unformatted flag.

### Avengers Assemble ###

>[175 Points] Iron Man has developed some new code for his suit, and now he needs someone to test it. Assuming the “print” function prints the current contents of register ecx to standard output, what will the standard output be when running Iron Man’s code?
Hint: The flag will be a series of digits ( ex: flag{1234567890} )

The challenge also contains a file called avengersAssemble.asm.
avengersAssemble.asm contains this machine code:
```asm
section    .text
    global _start
    
func:
    xor ecx, ecx
    cmp ebx, 0x1
    je L1
    F1:
    cmp ebx, 0x2
    jne L2
    F2:
    cmp ebx, 0x0
    jl L3
    F3:
    cmp ebx, 0x0
    jg L4
    jmp L8
    L1:
    mov ecx, msg
    call print
    jmp F1
    L2:
    mov ecx, msg2
    call print
    jmp F2
    L3:
    mov ecx, msg3
    call print
    jmp F3
    L4:
    mov ecx, msg4
    call print
    L8:
    ret
    
_start:
    mov ebx,0x1
    call func
    mov eax, 1 ;sys_exit
    int 0x80 ;call kernel

section    .data

msg db '1', 0xa
len equ    $ - msg ;length of msg
msg2 db '2',0xa
msg3 db '3',0xa
msg4 db '4',0xa
```
The assembly program will begin in the _start section. It moves the value 0x1 into ebx and then calls func. Func contains four conditionals that may print out '1', '2', '3', or '4'. We start by using cmp to compare ebx to 0x1, and je (conditional jump if equal) will execute since 0x1 and ebx are equal. The jump will jump to L1, where we move '1' to ecx, print it out, and then return. The program will repeat this for the other three conditionals, and we find that the output is **124**.

## Binary Exploitation ##
### i'm Buffer than you ###

>[225 Points] What if the value you assign to a buffer is larger than the space allocated for it in memory? Hmm… I wonder if we could exploit this…
Hint: https://en.wikipedia.org/wiki/Buffer_overflow
Hint: If you think you are close but it’s not working, remember little endian.

The challenge also provides the files imbufferthanyou.c, imbufferthanyou.exe, and imbufferthanyou.elf. The c file contains all of the code except the print_flag function, and the exe and elf files are the executables for Windows and Linux respectively.

We can start by examining imbufferthanyou.c, which contains the following code:
```c
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

    if(secret ## 0x66667562) {
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
```
The vuln function appears to create two local variables, one of them an integer and the other a buffer of 16 characters. It then prints out the memory locations of these variables, which will be extremely useful. The gets function is used to put user input in the buffer, but this function is not secure because it doesn't check the bounds of the array, therefore allowing us to overflow it. It seems that we must overflow the buffer so that we override the value of the integer to be 0x66667562 and in turn run the print_flag function.

Let's run the executable. If you're using Linux make sure to make the elf file executable first using this command:
`chmod u+x imbufferthanyou.elf`
Then we can run the program using this command:
`./imbufferthanyou.elf`
We get the following output on Windows. Notice that we entered "testing" into the buffer:

>Address of buffer array:   000000000061FDD0
Address of secret integer: 000000000061FDEC
Input text into buffer: testing
New value of secret integer: 0x0
It looks like you didn't overwrite the secret variable or overwrote using the wrong data.

Note: On a Windows machine, we run an executable using .\ instead of ./

If we subtract the buffer address from the integer address, we get a difference of 28 bytes. That means that if we input 28 bytes into the program we will then be writing to the memory for the integer. After these bytes, we need to enter a value that equals 0x66667562. 0x66667562 in ASCII is "ffub". However, we may need to reverse this depending on the endianness of the host machine. Now that we know this, let's try running the program again on Windows but input the correct bytes.
`.\imbufferthanyou.exe`

>Address of buffer array:   000000000061FDD0
Address of secret integer: 000000000061FDEC
Input text into buffer: ddddddddddddddddddddddddddddbuff
New value of secret integer: 0x66667562
You found the flag!
flag{th@t_buff3r_aint_so_buff_n0w}

There we go! We overwrote the secret integer value to equal 0x66667562. The flag is **flag{th@t_buff3r_aint_so_buff_n0w}**.

This challenge had an unintended solution:
Since we are running the binary locally, that means the flag must be stored in it somewhere. The "strings" command on Linux can search for strings of text in any file. That being said, we can extract the flag string from the binary using the following command:
`strings imbufferthabyou.elf`
