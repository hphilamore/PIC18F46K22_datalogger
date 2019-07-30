#line 1 "//Mac/Home/Documents/Code/microC/speed_test/Blink2.c"
void main()

{

OSCCON = 0b01110000;





OSCTUNE = 0b00000000;




 TRISD = 0;


 ANSELD = 0;

 do

 {


 LATD = 0;

 Delay_ms(1000);


 LATD = 1;

 Delay_ms(1000);

 }

 while(1);

}
