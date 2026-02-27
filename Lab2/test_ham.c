#include <stdio.h>
#include <string.h>

char str1[256];
char str2[256];
int result = 0;

extern void start_task(void); // Link assembly function

int main() {
    printf("Enter first string: ");
    fgets(str1, 256, stdin);    // Get entire line
    printf("Enter second string: ");
    fgets(str2, 256, stdin); 

    // strip newline character from fgets
    str1[strcspn(str1, "\n")] = 0;
    str2[strcspn(str2, "\n")] = 0;

    start_task(); // Jump to assembly logic

    printf("Hamming Distance: %d\n", result);
    return 0;
}