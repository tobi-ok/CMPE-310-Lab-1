#include <stdio.h>

char str1[256];
char str2[256];
int result = 0;

extern void start_task(void); // Link assembly function

int main() {
    printf("Enter first string: ");
    scanf("%s", str1);
    printf("Enter second string: ");
    scanf("%s", str2);

    start_task(); // Jump to assembly logic

    printf("Hamming Distance: %d\n", result);
    return 0;
}