// SD card chip select pin connection
sbit Mmc_Chip_Select           at RD4_bit;
sbit Mmc_Chip_Select_Direction at TRISD4_bit;

// include __Lib_FAT32.h file (useful definitions)
#include "__Lib_FAT32.h"

// variable declarations
__HANDLE fileHandle;   // only one file can be opened
char buffer[114];
short i;

// prototypes
void logging_Init();
void ReadADC_and_Log();

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
     i = FAT32_Close(fileHandle);
}


void logging_Init(){
// initialize SPI1 module at lowest speed
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

  UART1_Init(9600);   // initialize UART1 module at 9600 baud

  UART1_Write_Text("\r\n\nInitialize FAT library ... ");
  delay_ms(2000);     // wait 2 secods

  // initialize FAT32 library (& SD card)
  i = FAT32_Init();
  if(i != 0)
  {  // if there was a problem while initializing the FAT32 library
    UART1_Write_Text("Error initializing FAT library!");
  }

  else
  {  // the FAT32 library (& SD card) was (were) initialized
    // re-initialize SPI1 module at highest speed
    SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
    UART1_Write_Text("FAT Library initialized");
    delay_ms(2000);     // wait 2 seconds

    // create a new folder with name 'Test Dir'
    UART1_Write_Text("\r\n\r\nCreate 'Test Dir' folder ... ");
    if(FAT32_MakeDir("Test Dir") == 0)
      UART1_Write_Text("OK");
    else
      UART1_Write_Text("error creating folder");

    delay_ms(2000);     // wait 2 seconds
    
    // create (or open if already exists) a text file 'Log.txt'
    UART1_Write_Text("\r\n\r\nCreate 'Log.txt' file ... ");
    fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
    if(fileHandle == 0)
      UART1_Write_Text("OK");
    else
      UART1_Write_Text("error creating file or file already exists!");

    delay_ms(2000);     // wait 2 seconds
    // write some thing to the text file
    UART1_Write_Text("\r\nWriting to the text file 'Log.txt' ... ");
    i = FAT32_Write(fileHandle, "Hello,\r\nThis is a text file created using PIC18F46K22 microcontroller and mikroC compiler.\r\nHave a nice day ...", 113);
    if(i == 0)
      UART1_Write_Text("OK");
    else
      UART1_Write_Text("writing error");

    delay_ms(2000);     // wait 2 seconds
    // now close the file (Log.txt)
    UART1_Write_Text("\r\nClosing the file 'Log.txt' ... ");
    i = FAT32_Close(fileHandle);
    if(i == 0)
      UART1_Write_Text("OK");
    else
      UART1_Write_Text("closing error");

    delay_ms(2000);     // wait 2 seconds
    // reading 'Log.txt' file
    UART1_Write_Text("\r\n\r\nReading 'Log.txt' file:");
    delay_ms(2000);     // wait 2 seconds

    // open 'Log.txt' file with read permission
    UART1_Write_Text("\r\nOpen 'Log.txt' file ... ");
    fileHandle = FAT32_Open("Log.txt", FILE_READ);
    if(fileHandle != 0)
      UART1_Write_Text("error opening file");
    else
    {  // open file OK
      UART1_Write_Text("OK");
      delay_ms(2000);     // wait 2 seconds
      // print the whole file
      UART1_Write_Text("\r\nPrint 'log.txt' file:\r\n\r");
      delay_ms(2000);     // wait 2 seconds
      // read 113 bytes from fileHandler (Log.txt)and store in buffer
      FAT32_Read(fileHandle, buffer, 113);
      // now print the whole buffer
      UART1_Write_Text(buffer);

      delay_ms(2000);     // wait 2 seconds
      // now close the file
      UART1_Write_Text("\r\n\r\nClosing the file 'log.txt' ... ");
      i = FAT32_Close(fileHandle);
      if(i == 0)
        UART1_Write_Text("OK");
      else
        UART1_Write_Text("closing error");
    }
  }

  delay_ms(2000);     // wait 2 seconds
  UART1_Write_Text("\r\n\r\n***** END *****\r\n\r\n");
}