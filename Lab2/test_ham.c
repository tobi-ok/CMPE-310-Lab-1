#include <stdio.h>

extern unsigned char ram[]; // RAM declared in
extern void start_task(void); // Assembly function

int main()
{
    start_task(); // Run assembly code    
    return 0;
}