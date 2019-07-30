///* 
// * File:   newmain.c
// * Author: hemma
// *
// * Created on July 29, 2019, 1:20 PM
// */
//
//#include <stdio.h>
//#include <stdlib.h>
//
///*
// * 
// */
//int main(int argc, char** argv) {
//
//    return (EXIT_SUCCESS);
//}

//  T11.c

//#pragma config FOSC = INTIO7    // Oscillator Selection bits (Internal oscillator block, CLKOUT function on OSC2)
//
//int main(void){
//
//    while(1);
//}



//  T12.c

//#include <pic18f46k22.h>
//#pragma config FOSC = INTIO7    // Oscillator Selection bits (Internal oscillator block, CLKOUT function on OSC2)
//
//int main(void){
//    LATD = 0x53;        // Port D output = 0101 0011  
//    TRISD = 0x00;        // Port D all outputs 
//    while(1);
//}  


//  T14.c

//#include <pic18f46k22.h>
//#include <htc.h>
//#pragma config FOSC = INTIO7    // Oscillator Selection bits (Internal oscillator block, CLKOUT function on OSC2)
//#define _XTAL_FREQ 8000000             // Used in __delay_ms() functions
//
//int main(void){
//    int i;
//    LATD = 0x53;        // Port D output = 0101 0011  
//    TRISD = 0x00;        // Port D all outputs 
//    while(1){
//        for(i=0;i<=1000;i++);
//        LATD++;
//        __delay_ms(50);
//    } 
//}



//  T15.c

#include <pic18f46k22.h>
#include <htc.h>
#pragma config FOSC = INTIO7    // Oscillator Selection bits (Internal oscillator block, CLKOUT function on OSC2, LED on pin14 dimly lit)
#define _XTAL_FREQ 8000000             // Used in __delay_ms() functions
//#define LED LATD.D0 //write the pin B0 with 1 value //bit 1 of PORTD

main(void)
{
 OSCCON = 0b01100000;  // bit7: device enters SLEEP on sleep instruction[0]
                        // bit6-4: HFINTOSC 16MHz [111]
                        // bit3: status bit [0]
                        // bit2: status bit [0]
                        // bit1-0: clock defined by CONFIG bits [00]

OSCTUNE = 0b00000000; // bit7:  device clock derived from the MFINTOSC or HFINTOSC source
                        // bit6: PLL disabled [0]
                        // bit5-0: oscillator tuning [000000]

 TRISD = 0;  /* all PORTD bits are output */
while(1){
  LATDbits.LATD0 = 1;  /* turn RD0 ON*/
  
  __delay_ms(1000);
 
  LATDbits.LATD0 = 0;  /* turn RD0 OFF*/
  
  __delay_ms(1000);
}
}