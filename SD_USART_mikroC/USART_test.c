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

SD logging
https://simple-circuit.com/pic18f46k22-sd-card-fat32-mikroc/
https://simple-circuit.com/mikroc-dht22-data-logger-sd-card/
https://simple-circuit.com/pic18f46k22-bme280-data-logger-mikroc/

ADC to buffer
https://www.studentcompanion.co.za/temperature-logger-to-sd-card-with-menu-control-mikroc/

RTC
https://libstock.mikroe.com/projects/view/1209/ds1307-real-time-clock-and-pic-microcontroller
https://www.studentcompanion.co.za/interfacing-the-ds1307-real-time-clock-with-pic-microcontroller-mikroc/
https://www.studentcompanion.co.za/interfacing-the-pcf8583-real-time-clock-with-pic-microcontroller-mikroc/

TODO : load ADC string conversion into buffer of correct length to see if UART overspill text problem is solved. Then you can addback in UART text if you want to

*/



// SD card chip select pin connection
sbit Mmc_Chip_Select           at RD4_bit;
sbit Mmc_Chip_Select_Direction at TRISD4_bit;

// include __Lib_FAT32.h file (useful definitions)
#include "__Lib_FAT32.h"
#define ConvertToBCD(x,y) (((x-'0') << 4) + y - '0')  // BCD = binary coded decimal
#define HigherBit(x) ((x >>) + '0')
#define LowerBit(x) ((x & 0x0F) + '0')



__HANDLE fileHandle;   // only one file can be opened

// variable declarations
char buffer[114];
//char Time[8] = {'1', '7', ':', '5', '3', ':', '0', '0'};
//char Date[8] = {'1', '9', ':', '0', '9', ':', '1', '2'};
short i;
unsigned char rtc, yr;
//unsigned char second, minute, hour, yr;
unsigned char MSB(unsigned char x)           //Display Most Significant Bit of BCD number
{
  return ((x >> 4) + '0');
}

unsigned char  LSB(unsigned char x)          //Display Least Significant Bit of BCD number
{
  return ((x & 0x0F) + '0');
}

//Global Variables:
int second;
int minute;
int hour;
int hr;
int day;
int dday;
int month;
int year;
int ap;

char time[] = "00:00:00 PM";
char date[] = "00-00-00";


// prototypes
void logging_Init();
void ReadADC_and_Log();
unsigned short read_RTC(unsigned short address);



void main() {

    OSCCON = 0b01110000;  // bit7: device enters SLEEP on sleep instruction[0]
                                       // bit6-4: HFINTOSC 16MHz [111]
                                       // bit3: status bit [0]
                                       // bit2: status bit [0]
                                       // bit1-0: clock defined by CONFIG bits [00]

    OSCTUNE = 0b00000000; // bit7:  device clock derived from the MFINTOSC or HFINTOSC source
                                       // bit6: PLL disabled [0]
                                       // bit5-0: oscillator tuning [000000]

    ANSELA = 0;      // configure all PORTA pins as analog for data logging
    ANSELC = 0;         // configure all PORTC pins as digital
    ANSELD = 0;         // configure all PORTD pins as digital

    // initialize ADC module with voltage references: VSS - FVR(4.096V)
    // ADC_Init_Advanced(_ADC_INTERNAL_VREFL | _ADC_INTERNAL_FVRH4);
    // initialize ADC module with voltage references: VSS - FVR(1.024V)
    ADC_Init_Advanced(_ADC_INTERNAL_VREFL | _ADC_INTERNAL_FVRH1);
    delay_ms(1000);     // wait a second

    logging_Init();
    
    UART1_Write_Text("Initialising I2C \n");
    //Time =   '174900';
    I2C2_Init(100000); //RTC running at 100kHz

    UART1_Write_Text("I2C setup\n");
    I2C2_Start();  // begin I2C communications
    I2C2_Wr(0xA0);      // writing address
    I2C2_Wr( 0 );
    I2C2_Wr( 0x80 );
    I2C2_Wr( 0 );
    /*
    I2C2_Wr( ConvertToBCD(Time[6], Time[7])); // write Seconds
    I2C2_Wr( ConvertToBCD(Time[3], Time[4])); // write Minutes
    I2C2_Wr( ConvertToBCD(Time[0], Time[1])); // write Hours
    ConvertToBCD(x,y) ((x-'0') << 4) + y - '0'
    */
    /*
    I2C2_Wr( ((Time[6]-'0') << 4) + (Time[7] - '0' ) ); // write Seconds
    I2C2_Wr( ((Time[3]-'0') << 4) + (Time[4] - '0' ) );// write Minutes
    I2C2_Wr( ((Time[0]-'0') << 4) + (Time[1] - '0' ) ); // write Hours
    */

    UART1_Write_Text("year\n");
    year = 10 * (Date[6] - '0') + Date[7] - '0';
    //EEPROM_Write(0, year)             // write year to EEPROM adress 0
    yr = (year % 4) << 2;
    //Date[0] = Date[0] + yr;

    UART1_Write_Text("convert to BDC\n");
    //I2C2_Wr( ConvertToBCD(Date[0], Date[1])); // write Day
    //I2C2_Wr( ConvertToBCD(Date[3], Date[4])); // write Month
    I2C2_Stop();
    
    UART1_Write_Text("enable counting\n");
    I2C2_Start();
    I2C2_Wr(0xA0);      // writing address
    I2C2_Wr( 0 );
    I2C2_Wr( 0 );       // enable counting
    I2C2_Stop();

    /*
    I2C2_Init(100000); //DS1307 runing at 100kHz
    I2C2_Start();      // begin I2C communications
    I2C2_Wr(0xD0);      // addresses the chip
    
    I2C2_Wr(0b00010011);      // write value into minutes register
    I2C2_Stop();
    */

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
     UART1_Write_Text("ADC\n");
     R0 = ADC_Get_Sample(0);
     R1 = ADC_Get_Sample(1);
     WordToStr(R0, R0_);
     WordToStr(R1, R1_);
     //UART1_Write_Text(R0_);
     Delay_ms(1000);
     
     UART1_Write_Text("RTC\n"); 
     I2C2_Start();
     I2C2_Wr(0xA0);
     I2C2_Wr(0x2 );
     I2C2_Start();           // begin I2C communications
     I2C2_Wr(0xA1);      // addresses for reading
     UART1_Write_Text("read RTC\n");
     //rtc = I2C1_Rd(1);    // read seconds
     rtc = read_RTC(0);//
     UART1_Write_Text("update time\n");
     Time[6] = rtc>> + '0';
     UART1_Write_Text("write time\n");
     UART1_Write_Text(Time);
     /*
     I2C2_Start();           // begin I2C communications
     I2C2_Wr(0xA0);      // addresses the chip
     I2C2_Wr(0x2 );  
     I2C2_Start();           // begin I2C communications
     I2C2_Wr(0xA1);      // addresses for reading
     rtc = I2C2_Rd(1);    // read seconds
     Time[6] = HigherBit(rtc);
     Time[7] = LowerBit(rtc);
     UART1_Write_Text(Time);
     */
     
     
     
     /*
     second = read_RTC(0);
     minute = read_RTC(1);
     hour = read_RTC(2);
     hr = hour & 0b00011111;
     ap = hour & 0b00100000;
     dday = read_RTC(3);
     day = read_RTC(4);
     month = read_RTC(5);
     year = read_RTC(6);
     */
     /*
     UART1_Write_Text("time\n");
     time[0] = MSB(hr);
     time[1] = LSB(hr);
     time[3] = MSB(minute);
     time[4] = LSB(minute);
     time[6] = MSB(second);
     time[7] = LSB(second);
     date[0] = MSB(day);
     date[1] = LSB(day);
     date[3] = MSB(month);
     date[4] = LSB(month);
     date[6] = MSB(year);
     date[7] = LSB(year);
     if(ap)
     {
        time[9] = 'P';
        time[10] = 'M';
     }
     else
     {
        time[9] = 'A';
        time[10] = 'M';
     }
     */
     UART1_Write_Text("log to SD\n");
     // open the file
     //fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
     fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
     // write some thing to the text file
     UART1_Write_Text("\n");
     UART1_Write_Text(R0_);
     UART1_Write_Text("\t");
     UART1_Write_Text(R1_);

     i = FAT32_Write(fileHandle, "\r\n", 6);
     i = FAT32_Write(fileHandle, R0_, 6);
     //i = FAT32_Write(fileHandle, "\t", 6);
     i = FAT32_Write(fileHandle, R1_, 6);
     //i = FAT32_Write(fileHandle, time, 11);

     //if(i != 0)
     //UART1_Write_Text("writing error");
     //UART1_Write(13);

     // now close the file (Log.txt)
     i = FAT32_Close(fileHandle);
     
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
  i = FAT32_Init();
  if(i != 0)
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
    i = FAT32_Write(fileHandle, "\r\nThis_is_a_text_file_created_using_PIC18F46K22_microcontroller_and_mikroC_compiler.\r\n", 113);
    /*
    if(i == 0)
      UART1_Write_Text("OK");
    else
      UART1_Write_Text("writing error");
    */

    delay_ms(1000);     // wait 2 seconds
    // now close the file (Log.txt)
    //UART1_Write_Text("\r\nClosing the file 'Log.txt' ... ");
    i = FAT32_Close(fileHandle);
    /*
    if(i == 0)
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
      i = FAT32_Close(fileHandle);
      /*
      if(i == 0)
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


unsigned short read_RTC(unsigned short address)
{
  unsigned short read_data;
  I2C2_Start();
  I2C2_Wr(0xA0); // Address for writing
  I2C2_Wr(address);
  I2C2_Repeated_Start();
  I2C2_Wr(0xA1); // Address for reading
  read_data=I2C2_Rd(0);
  I2C2_Stop();
  return(read_data);
}