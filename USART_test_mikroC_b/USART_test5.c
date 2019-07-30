/* configuration bits dans   project ->  project
   MCU name          18F46K22
   internal Oscil Frequency  16MHz    No PLL
   MikroC pro 6.50

CONFIG1H : $300001 : 0x0028
CONFIG2L : $300002 : 0x001E
CONFIG2H : $300003 : 0x003C
CONFIG3H : $300005 : 0x0099
CONFIG4L : $300006 : 0x0080
CONFIG5L : $300008 : 0x000F
CONFIG5H : $300009 : 0x00C0
CONFIG6L : $30000A : 0x000F
CONFIG6H : $30000B : 0x00E0
CONFIG7L : $30000C : 0x000F
CONFIG7H : $30000D : 0x0040


 */
#define Version "02-09-2015"


#define TAB 9
#define CLS 12
#define CR 13
#define LF 10

#include "built_in.h"


sbit Led_Blanche at LATA4_bit ;     // RA4
sbit Led_Blanche_direction at TRISA4_bit ;

unsigned char TEXTE[80];
unsigned char *txt;

unsigned i,j,k;
unsigned long Freq;

void strConstRamCpy(char *dest, const char *source);
void UART1_Write_CText(const char *txt);
void CRLF(void);


void UART1_Write_CText(const char *txt1)
 {
   while (*txt1)
      UART1_Write(*txt1++);
}

// --- Copie le texte depuis ROM vers RAM
void strConstRamCpy(char *dest, const char *source) {
  while(*source) *dest++ = *source++ ;
  *dest = 0 ;    // terminateur
}

/*void CRLF()
{
 UART1_Write(CR);
 UART1_Write(LF);
}*/



  void main() {

    OSCCON = 0b01110000;  // bit7: device enters SLEEP on sleep instruction[0]
                                       // bit6-4: HFINTOSC 16MHz [111]
                                       // bit3: status bit [0]
                                       // bit2: status bit [0]
                                       // bit1-0: clock defined by CONFIG bits [00]

    OSCTUNE = 0b00000000; // bit7:  device clock derived from the MFINTOSC or HFINTOSC source
                                       // bit6: PLL disabled [0]
                                       // bit5-0: oscillator tuning [000000]
   ANSELC=0;
   Led_Blanche_direction=0; // output

   // checkin FOSC by Led
   Led_Blanche=1;     // do a chrono during led is ON
    Delay_ms(5000);
    Led_Blanche=0;


  UART1_Init(19200);
  UART1_Write(CLS);  // efface ecran si code 12 voir vbray
  Delay_ms(1000);

  UART1_Write('A');
  UART1_Write('B');
  UART1_Write('Z');
  UART1_Write('a');
  UART1_Write('b');
  UART1_Write('Z');
  //CRLF();

  // value of FOSC seeing by the program
  txt=&TEXTE[0]; // init pointeur sur table TEXTE
  Freq = Clock_kHz();
  //Freq=GetFosc();
  UART1_Write_CText(" Fosc =");
  //LongWordToStr(Freq, txt) ;
  //UART_Write_Text(txt);
  UART1_Write_CText(" KHz\r\n");

  UART1_Write_CText("18F46K22 40pins FOSC=16MHz test UART1 19200,8,N,1\r\n ");


    while(1){
             UART1_Write_Text("Hello");
             Delay_ms(1000);
             UART1_Write(13);
            Led_Blanche=!Led_Blanche;
    }
}