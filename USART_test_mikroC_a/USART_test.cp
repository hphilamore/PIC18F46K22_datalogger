#line 1 "//Mac/Home/Documents/Code/microC/USART_test/USART_test.c"
void main() {

 OSCCON = 0b01110000;





 OSCTUNE = 0b00000000;



 UART1_Init(19200);

 while(1){
 UART1_Write_Text("Hello");
 Delay_ms(1000);
 UART1_Write(13);
 }
}
