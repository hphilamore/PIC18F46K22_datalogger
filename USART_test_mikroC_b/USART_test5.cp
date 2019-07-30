#line 1 "//Mac/Home/Documents/Code/microC/USART_test_copy_forum_uart/USART_test5.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/built_in.h"
#line 31 "//Mac/Home/Documents/Code/microC/USART_test_copy_forum_uart/USART_test5.c"
sbit Led_Blanche at LATA4_bit ;
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


void strConstRamCpy(char *dest, const char *source) {
 while(*source) *dest++ = *source++ ;
 *dest = 0 ;
}
#line 65 "//Mac/Home/Documents/Code/microC/USART_test_copy_forum_uart/USART_test5.c"
 void main() {

 OSCCON = 0b01110000;





 OSCTUNE = 0b00000000;


 ANSELC=0;
 Led_Blanche_direction=0;


 Led_Blanche=1;
 Delay_ms(5000);
 Led_Blanche=0;


 UART1_Init(19200);
 UART1_Write( 12 );
 Delay_ms(1000);

 UART1_Write('A');
 UART1_Write('B');
 UART1_Write('Z');
 UART1_Write('a');
 UART1_Write('b');
 UART1_Write('Z');



 txt=&TEXTE[0];
 Freq = Clock_kHz();

 UART1_Write_CText(" Fosc =");


 UART1_Write_CText(" KHz\r\n");

 UART1_Write_CText("18F46K22 40pins FOSC=16MHz test UART1 19200,8,N,1\r\n ");


 while(1){
 UART1_Write_Text("Hello");
 Delay_ms(1000);
 UART1_Write(13);
 Led_Blanche=!Led_Blanche;
 }
}
