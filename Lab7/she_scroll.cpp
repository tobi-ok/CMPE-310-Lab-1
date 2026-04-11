#include <iostream>
#include <unistd.h>
#include <cstdint>
using namespace std;
 
/*
    8255 Port addresses
    0x640 = Port A -> digit select (which display is active)
    0x641 = Port B -> segment data (which segments light up)
    0x643 = Control register

    Segment byte encoding (Table B):
    Bit:  7  6  5  4  3  2  1  0
    Seg:  X  g  f  e  d  c  b  a

    S = a,f,g,c,d -> 0110 1101 = 0x6D
    H = f,e,g,b,c -> 0111 0110 = 0x76
    E = a,f,g,e,d -> 0111 1001 = 0x79
*/
 
// Ports (uses uint8_t)
uint8_t portA = 0x00;
uint8_t portB = 0x00;
 
// Simulate the OUT instruction
void out_port(int address, uint8_t value) {
    if (address == 0x643) {
        cout << "[8255] Control word: 0x" << hex << (int)value
                  << " -> Mode 0, Port A output, Port B output\n" << dec;
    } else if (address == 0x640) {
        portA = value;  // digit select
    } else if (address == 0x641) {
        portB = value;  // segment data
    }
}
 
// Convert segment byte to display character
char seg_to_char(uint8_t seg) {
    switch (seg) {
        case 0x6D: return 'S';
        case 0x76: return 'H';
        case 0x79: return 'E';
        case 0x00: return ' ';
        default:   return '?';
    }
}
 
// Print the display state to terminal
void print_display(uint8_t frame[8]) {
    cout << "\r|";
    for (int i = 7; i >= 0; i--) {
        cout << seg_to_char(frame[i]) << "|";
    }
    cout << flush;
}
 
// Scroll frames: 11 frames x 8 bytes
// [dig7, dig6, dig5, dig4, dig3, dig2, dig1, dig0]
uint8_t scroll_frames[11][8] = {
    {0x00,0x00,0x00,0x00,0x00,0x79,0x76,0x6D},  // _____EHS
    {0x00,0x00,0x00,0x00,0x79,0x76,0x6D,0x00},  // ____EHS_
    {0x00,0x00,0x00,0x79,0x76,0x6D,0x00,0x00},  // ___EHS__
    {0x00,0x00,0x79,0x76,0x6D,0x00,0x00,0x00},  // __EHS___
    {0x00,0x79,0x76,0x6D,0x00,0x00,0x00,0x00},  // _EHS____
    {0x79,0x76,0x6D,0x00,0x00,0x00,0x00,0x00},  // EHS_____
    {0x00,0x79,0x76,0x6D,0x00,0x00,0x00,0x00},  // _EHS____
    {0x00,0x00,0x79,0x76,0x6D,0x00,0x00,0x00},  // __EHS___
    {0x00,0x00,0x00,0x79,0x76,0x6D,0x00,0x00},  // ___EHS__
    {0x00,0x00,0x00,0x00,0x79,0x76,0x6D,0x00},  // ____EHS_
    {0x00,0x00,0x00,0x00,0x00,0x79,0x76,0x6D},  // _____EHS
};
 
int main() {
    // Control word 0x80 = 1000 0000
    // Bit 7=1: mode set? always 1
    // Bit 4=0: Port A = output (digit select)
    // Bit 1=0: Port B = output (segment data)
    out_port(0x643, 0x80);
    cout << "\nDisplay (dig7 -> dig0):\n";
 
    // Run 3 cycles then exit
    for (int cycle = 0; cycle < 3; cycle++) {
        for (int frame = 0; frame < 11; frame++) {
 
            // Shift digits
            uint8_t digit_select = 0x01;  // start at dig0
            for (int digit = 0; digit < 8; digit++) {
                out_port(0x641, scroll_frames[frame][digit]); // Port B: segments
                out_port(0x640, digit_select);                // Port A: select digit
                digit_select <<= 1;  // shift left -> next digit
            }
 
            print_display(scroll_frames[frame]);

            sleep(1);
        }
    }
 
    cout << "\ndone.\n";
    return 0;
}