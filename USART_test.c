/*


Data logger using PIC18F46K22 microcontroller,  and DS3231 RTC.

Configuration words     :     CONFIG1H : $300001 : 0x0028
                              CONFIG2L : $300002 : 0x0019
                              CONFIG2H : $300003 : 0x003C
                              CONFIG3H : $300005 : 0x00BF
                              CONFIG4L : $300006 : 0x0081
                              CONFIG5L : $300008 : 0x000F
                              CONFIG5H : $300009 : 0x00C0
                              CONFIG6L : $30000A : 0x000F
                              CONFIG6H : $30000B : 0x00E0



Internal Oscillator used @ 16 MHz

Example projects
https://simple-circuit.com/pic18f46k22-sd-card-fat32-mikroc/
https://simple-circuit.com/mikroc-dht22-data-logger-sd-card/
https://simple-circuit.com/pic18f46k22-bme280-data-logger-mikroc/

ADC to buffer
https://www.studentcompanion.co.za/temperature-logger-to-sd-card-with-menu-control-mikroc/

RTC
https://forum.mikroe.com/viewtopic.php?f=13&t=16343
https://www.ridgesolutions.ie/index.php/2017/07/25/i2c1_wr-i2c1_rd-functions-hang-with-mikroc-for-pic/
https://libstock.mikroe.com/projects/view/1209/ds1307-real-time-clock-and-pic-microcontroller
https://www.studentcompanion.co.za/interfacing-the-ds1307-real-time-clock-with-pic-microcontroller-mikroc/
https://www.studentcompanion.co.za/interfacing-the-pcf8583-real-time-clock-with-pic-microcontroller-mikroc/
https://simple-circuit.com/pic-mcu-ds1307-ds3231-i2c-lcd-mikroc/



*/
// SD card chip select pin connection
sbit Mmc_Chip_Select           at RD4_bit;
sbit Mmc_Chip_Select_Direction at TRISD4_bit;
unsigned short tI2C2_Rd(unsigned short ack);

// include __Lib_FAT32.h file (useful definitions)
#include "stdint.h"
#include "__Lib_FAT32.h"

// button definitions
#define button1      RA5_bit   // button B1 is connected to RA5 pin
#define button2      RA4_bit   // button B2 is connected to RA4 pin
#define I2C_READ_TIMEOUT_US 200

// variable declarations
__HANDLE fileHandle;   // only one file can be opened
char buffer[114];
short j;

// variables declaration
char  i, second, minute, hour, m_day, month, year;

// a small function for button1 (B1) debounce
char debounce ()
{
  char i, count = 0;
  for(i = 0; i < 5; i++)
  {
    if (button1 == 0)
      count++;
    delay_ms(10);
  }
  if(count > 2)  return 1;
  else           return 0;
}

// prototypes
void logging_Init();
void ReadADC_and_Log();
uint8_t bcd_to_decimal(uint8_t number);
uint8_t decimal_to_bcd(uint8_t number);
void RTC_display();
void delay();
char edit(char x, char y, char parameter);

void main() {

    OSCCON = 0b01110000;  // bit7: device enters SLEEP on sleep instruction[0]
                                       // bit6-4: HFINTOSC 16MHz [111]
                                       // bit3: status bit [0]
                                       // bit2: status bit [0]
                                       // bit1-0: clock defined by CONFIG bits [00]

    OSCTUNE = 0b00000000; // bit7:  device clock derived from the MFINTOSC or HFINTOSC source
                                       // bit6: PLL disabled [0]
                                       // bit5-0: oscillator tuning [000000]

    // ANSELA, ANSELB, ANSELC, ANSELD and ANSELE registers. 
    // Setting anANSx bit high will disable the associated digital input
    // buffer and cause all reads of that pin to return ‘0’ whileallowing 
    // analog functions of that pin to operate correctly.
    
    ANSELA = 0;      // configure all PORTA pins as analog for data logging
    //ANSELA = 0b00000000;      // configure all PORTA pins as analog for data logging
    ANSELC = 0;      // configure all PORTC pins as analog
    ANSELD = 0;      // configure all PORTD pins as analog
    
    // enable RA4 and RA5 internal pull ups for push-buttons
    //NOT_WPUEN_bit = 0;      // clear WPUEN bit (OPTION_REG.7)
    //WPUA          = 0x30;   // WPUA register = 0b00110000
    
    I2C2_Init(100000);   // initialize I2C bus with clock frequency of 100kHz

    // initialize ADC module with voltage references: VSS - FVR(4.096V)
    // ADC_Init_Advanced(_ADC_INTERNAL_VREFL | _ADC_INTERNAL_FVRH4);
    // initialize ADC module with voltage references: VSS - FVR(1.024V)
    ADC_Init_Advanced(_ADC_INTERNAL_VREFL | _ADC_INTERNAL_FVRH1);
    delay_ms(1000);     // wait a second

    logging_Init();
    
    i = 0;
    hour   = 1; //edit(7,  1, hour);
    minute = 2; //edit(10, 1, minute);
    m_day  = 3; //edit(7,  2, m_day);
    month  = 4; //edit(10, 2, month);
    year   = 5; //edit(15, 2, year);

    while(debounce());  // call debounce function (wait for button B1 to be released)

    // convert decimal to BCD
    minute = decimal_to_bcd(minute);
    hour   = decimal_to_bcd(hour);
    m_day  = decimal_to_bcd(m_day);
    month  = decimal_to_bcd(month);
    year   = decimal_to_bcd(year);
    // end conversion

    // write data to RTC chip
    I2C2_Start();      // start I2C
    I2C2_Wr(0xD0);     // RTC chip address
    I2C2_Wr(0);        // send register address
    I2C2_Wr(0);        // reset seconds and start oscillator
    I2C2_Wr(minute);   // write minute value to RTC chip
    I2C2_Wr(hour);     // write hour value to RTC chip
    I2C2_Wr(1);        // write day value (not used)
    I2C2_Wr(m_day);    // write date value to RTC chip
    I2C2_Wr(month);    // write month value to RTC chip
    I2C2_Wr(year);     // write year value to RTC chip
    I2C2_Stop();       // stop I2C
    
    // read current time and date from the RTC chip
    I2C2_Start();           // start I2C
    I2C2_Wr(0xD0);       // RTC chip address
    I2C2_Wr(0);          // send register address
    //I2C2_Restart();         // restart I2C
    I2C2_Repeated_Start();    // restart I2C
    I2C2_Wr(0xD1);       // initialize data read
    // second = I2C2_Rd(1);  // read seconds from register 0
    second = tI2C2_Rd(1);  // read seconds from register 0
    /*
    minute = I2C2_Rd(1);  // read minutes from register 1
    hour   = I2C2_Rd(1);  // read hour from register 2
    I2C_Read(1);           // read day from register 3 (not used)
    m_day  = I2C2_Rd(1);  // read date from register 4
    month  = I2C2_Rd(1);  // read month from register 5
    year   = I2C2_Rd(0);  // read year from register 6
    */
    I2C_Stop();
    
    second = bcd_to_decimal(second);
    UART1_Write_Text(second);


    while(1){

             ReadADC_and_Log();
             /*int R0;
             char R0_[6];
             R0 = ADC_Get_Sample(0);
             WordToStr(R0, R0_);
             //UART1_Write_Text(R0_);
             Delay_ms(1000);

             // open the file
             fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
             // write some thing to the text file
             UART1_Write_Text(R0_);
             UART1_Write_Text("\n");
             i = FAT32_Write(fileHandle, R0_, 6);
             i = FAT32_Write(fileHandle, "\n", 6);
             if(i != 0)
             UART1_Write_Text("writing error");
             //UART1_Write(13);

             // now close the file (Log.txt)
             i = FAT32_Close(fileHandle);*/

    }
}

void ReadADC_and_Log(){
     int R0;
     int R1;
     char R0_[6];
     char R1_[6];
     // read analog voltage in mV
     R0 = ADC_Get_Sample(0);
     R1 = ADC_Get_Sample(1);
     WordToStr(R0, R0_);
     WordToStr(R1, R1_);
     //UART1_Write_Text(R0_);
     Delay_ms(1000);

     // open the file
     //fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
     fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
     // write some thing to the text file
     UART1_Write_Text("\n");
     UART1_Write_Text(R0_);
     UART1_Write_Text("\t");
     UART1_Write_Text(R1_);

     j = FAT32_Write(fileHandle, "\r\n", 6);
     j = FAT32_Write(fileHandle, R0_, 6);
     //j = FAT32_Write(fileHandle, "\t", 6);
     j = FAT32_Write(fileHandle, R1_, 6);

     //if(j != 0)
     //UART1_Write_Text("writing error");
     //UART1_Write(13);

     // now close the file (Log.txt)
     j = FAT32_Close(fileHandle);
     
     // wait 30s before next data point
     delay_ms(5000);     // wait 5 seconds
}


void logging_Init(){
// initialize SPI1 module at lowest speed
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

  UART1_Init(9600);   // initialize UART1 module at 9600 baud

  UART1_Write_Text("\r\n\nInitialize FAT library ... ");
  delay_ms(1000);     // wait 2 secods

  // initialize FAT32 library (& SD card)
  j = FAT32_Init();
  if(j != 0)
  {  // if there was a problem while initializing the FAT32 library
    UART1_Write_Text("Error initializing FAT library (SD card missing?)!");
  }

  else
  {  // the FAT32 library (& SD card) was (were) initialized
    // re-initialize SPI1 module at highest speed
    SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
    UART1_Write_Text("FAT Library initialized");
    delay_ms(1000);     // wait 2 seconds

    // create a new folder with name 'Test Dir'
    /*
    UART1_Write_Text("\r\n\r\nCreate 'Test Dir' folder ... ");
    if(FAT32_MakeDir("Test Dir") == 0)
      UART1_Write_Text("OK");
    else
      UART1_Write_Text("error creating folder");

    delay_ms(2000);     // wait 2 seconds
    */

    // create (or open if already exists) a text file 'Log.txt'
    UART1_Write_Text("\r\n\r\nWrite test code to file :  This_is_a_text_file_created_using_PIC18F46K22_microcontroller");
    fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
    /*
    if(fileHandle == 0)
      UART1_Write_Text("OK");
    else
      UART1_Write_Text("error creating file or file already exists!");
    */

    //delay_ms(2000);     // wait 2 seconds
    // write some thing to the text file
    //UART1_Write_Text("\r\nWriting to the text file 'Log.txt' ... ");
    j = FAT32_Write(fileHandle, "\r\nThis_is_a_text_file_created_using_PIC18F46K22_microcontroller_and_mikroC_compiler.\r\n", 113);
    /*
    if(i == 0)
      UART1_Write_Text("OK");
    else
      UART1_Write_Text("writing error");
    */

    delay_ms(1000);     // wait 2 seconds
    // now close the file (Log.txt)
    //UART1_Write_Text("\r\nClosing the file 'Log.txt' ... ");
    j = FAT32_Close(fileHandle);
    /*
    if(j == 0)
      UART1_Write_Text("OK");
    else
      UART1_Write_Text("closing error");
    */

    //delay_ms(2000);     // wait 2 seconds
    // reading 'Log.txt' file
    UART1_Write_Text("\r\n\r\nReading first line of file:");
    delay_ms(1000);     // wait 2 seconds

    // open 'Log.txt' file with read permission
    UART1_Write_Text("\r\nOpen file ... ");
    fileHandle = FAT32_Open("Log.txt", FILE_READ);
    if(fileHandle != 0)
      UART1_Write_Text("error opening file");
    else
    {  // open file OK
      //UART1_Write_Text("OK");
      //delay_ms(1000);     // wait 2 seconds
      // print the whole file upto specified buffer length
      UART1_Write_Text("\r\nPrint file:\r\n\r");
      delay_ms(1000);     // wait 2 seconds
      // read 113 bytes from fileHandler (Log.txt)and store in buffer
      FAT32_Read(fileHandle, buffer, 113);
      // now print the whole buffer
      UART1_Write_Text(buffer);

      delay_ms(1000);     // wait 2 seconds
      // now close the file
      UART1_Write_Text("\r\n\r\nClosing the file ... ");
      j = FAT32_Close(fileHandle);
      /*
      if(j == 0)
        UART1_Write_Text("OK");
      else
        UART1_Write_Text("closing error");
        */
        
      //FAT32_Delete(Log.txt);
    }
  }

  delay_ms(1000);     // wait 2 seconds
  UART1_Write_Text("\r\n\r\n***** END OF INITIALISATION *****\r\n\r\n");
}


     
//********************* RTC functions *********************
// convert BCD to decimal function 

uint8_t bcd_to_decimal(uint8_t number)
{
  return((number >> 4) * 10 + (number & 0x0F));
}


// convert decimal to BCD function
uint8_t decimal_to_bcd(uint8_t number)
{
  return(((number / 10) << 4) + (number % 10));
}

// display time and date function
void RTC_display()
{
  // convert data from BCD format to decimal format
  second = bcd_to_decimal(second);
  minute = bcd_to_decimal(minute);
  hour   = bcd_to_decimal(hour);
  m_day  = bcd_to_decimal(m_day);
  month  = bcd_to_decimal(month);
  year   = bcd_to_decimal(year);
  // end conversion

  /*
  // print seconds
  LCD_Goto(13, 1);
  LCD_PutC( (second / 10) % 10 + '0');
  LCD_PutC(  second       % 10 + '0');
  // print minutes
  LCD_Goto(10, 1);
  LCD_PutC( (minute / 10) % 10 + '0');
  LCD_PutC(  minute       % 10 + '0');
  // print hours
  LCD_Goto(7, 1);
  LCD_PutC( (hour / 10) % 10 + '0');
  LCD_PutC(  hour       % 10 + '0');
  // print day of the month
  LCD_Goto(7, 2);
  LCD_PutC( (m_day / 10) % 10 + '0');
  LCD_PutC(  m_day       % 10 + '0');
  // print month
  LCD_Goto(10, 2);
  LCD_PutC( (month / 10) % 10 + '0');
  LCD_PutC(  month       % 10 + '0');
  // print year
  LCD_Goto(15, 2);
  LCD_PutC( (year / 10) % 10 + '0');
  LCD_PutC(  year       % 10 + '0');
  */

}



// make editing parameter blinks function
void delay()
{
  TMR1H = TMR1L = 0;   // reset Timer1
  TMR1ON_bit    = 1;   // enable Timer1 module
  // wait for 250ms or at least one button press
  while ( ((unsigned)(TMR1H << 8) | TMR1L) < 62500 && button1 && button2) ;
  TMR1ON_bit = 0;         // disable Timer1 module
}



// edit time and date function
char edit(char x, char y, char parameter)
{
  while(debounce());  // call debounce function (wait for B1 to be released)

  while(1) {

    while(!button2)    // if button B2 is pressed
    {
      parameter++;
      if(i == 0 && parameter > 23)   // if hours > 23 ==> hours = 0
        parameter = 0;
      if(i == 1 && parameter > 59)   // if minutes > 59 ==> minutes = 0
        parameter = 0;
      if(i == 2 && parameter > 31)   // if date > 31 ==> date = 1
        parameter = 1;
      if(i == 3 && parameter > 12)   // if month > 12 ==> month = 1
        parameter = 1;
      if(i == 4 && parameter > 99)   // if year > 99 ==> year = 0
        parameter = 0;

      /*
      LCD_Goto(x, y);    // move cursor to column x, row y
      LCD_PutC(parameter / 10 + '0');
      LCD_PutC(parameter % 10 + '0');
      delay_ms(200);
      */

    }

    /*
    LCD_Goto(x, y);   // move cursor to column x, row y
    LCD_Print("  ");  // print 2 spaces
    delay();

    LCD_Goto(x, y);
    LCD_PutC(parameter / 10 + '0');
    LCD_PutC(parameter % 10 + '0');
    delay();
    */

    if(!button1)     // if button B1 is pressed
    if(debounce())   // call debounce function (make sure B1 is pressed)
    {
      i++;   // increment 'i' for the next parameter
      return parameter;     // return parameter value and exit
    }

  }

}




unsigned short tI2C2_Rd(unsigned short ack) {

    unsigned short d = 0;
    const unsigned int delay = 2; // us
    unsigned int max_retry = I2C_READ_TIMEOUT_US / delay;
    unsigned int retry;

    if (max_retry == 0)
        max_retry = 1;

    // Interrupt Flag bit - Waiting to transmit/receive
    // 1 = The transmission/reception is complete (must be cleared by software)
    // 0 = Waiting to transmit/receive
    //
    PIR1.SSP1IF = 0;

    // Set receive mode
    // 1 = Enables Receive mode for I2C
    // 0 = Receive idle
    //
    SSP1CON2.RCEN = 1;

    // Wait for read completion
    // 1 = The transmission/reception is complete (must be cleared by software)
    // 0 = Waiting to transmit/receive
    //
    retry = max_retry;
    while (PIR1.SSP1IF == 0 && --retry > 0)
        delay_us(delay);

    // Still not complete, get out...
    if (PIR1.SSP1IF == 0)
        return 0;

    // grab the data
    d = (unsigned short)SSPBUF;

    // ACK required?
    if (ack == 0) {
        // No
        // 1 = Not Acknowledge
        // 0 = Acknowledge
        //
        SSP1CON2.ACKDT = 1;
    } else {
        // Yes
        SSP1CON2.ACKDT = 0;
    }

    // Interrupt Flag bit - Waiting to transmit/receive
    // 1 = The transmission/reception is complete (must be cleared by software)
    // 0 = Waiting to transmit/receive
    //
    PIR1.SSP1IF = 0;

    // Start Ack sequence
    // 1 = Initiate Acknowledge sequence on SDAx and SCLx pins, and transmit ACKDT data bit. Automatically cleared by hardware.
    // 0 = Acknowledge sequence idle
    //
    SSP1CON2.ACKEN = 1;

    // Wait for completion of ack sequence
    retry = max_retry;
    while (PIR1.SSP1IF == 0 && --retry > 0)
        delay_us(delay);

    return d;
}

