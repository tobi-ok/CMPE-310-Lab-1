#include <stdio.h>

extern unsigned char ram[]; // RAM declared in
extern void loop_start(void); // Assembly function

int main() {
    loop_start(); // Run assembly code

    unsigned char sum = ram[0x50];

    printf("Results:\n");
    printf("%d\n", sum);

    return 0;
}