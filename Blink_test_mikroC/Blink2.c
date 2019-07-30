void main()

{

OSCCON = 0b01110000;  // bit7: device enters SLEEP on sleep instruction[0]
                        // bit6-4: HFINTOSC 16MHz [111]
                        // bit3: status bit [0]
                        // bit2: status bit [0]
                        // bit1-0: clock defined by CONFIG bits [00]

OSCTUNE = 0b00000000; // bit7:  device clock derived from the MFINTOSC or HFINTOSC source
                        // bit6: PLL disabled [0]
                        // bit5-0: oscillator tuning [000000]

 //TRISB0_bit = 0; //set pin B0 as output
 TRISD = 0; //set pin B0 as output

 //ANSELB = 0; //set port as Digital
 ANSELD = 0; //set port as Digital

 do

 {

 //LATD.B0 = 0; //write the pin B0 with 0 value
 LATD = 0;

 Delay_ms(1000); //Delay of 1 second

 //LATB.B0 = 1; //write the pin B0 with 1 value
 LATD = 1;

 Delay_ms(1000); //Delay of 1 second

 }

 while(1); //Keep the loop running

}