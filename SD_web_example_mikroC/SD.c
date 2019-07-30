/**************************************************************************************

  Read and write files to and from SD card using PIC18F46K22 microcontroller.
  C Code for mikroC PRO for PIC compiler.
  Internal oscillator used @ 16MHz

  Configuration words: CONFIG1H = 0x0028
                       CONFIG2L = 0x0018
                       CONFIG2H = 0x003C
                       CONFIG3H = 0x0037
                       CONFIG4L = 0x0081
                       CONFIG5L = 0x000F
                       CONFIG5H = 0x00C0
                       CONFIG6L = 0x000F
                       CONFIG6H = 0x00E0
                       CONFIG7L = 0x000F
                       CONFIG7H = 0x0040

  This is a free software with NO WARRANTY.
  https://simple-circuit.com/

***************************************************************************************/




// SD card chip select pin connection
sbit Mmc_Chip_Select           at RD4_bit;
sbit Mmc_Chip_Select_Direction at TRISD4_bit;

// include __Lib_FAT32.h file (useful definitions)
#include "__Lib_FAT32.h"

// variable declarations
__HANDLE fileHandle;   // only one file can be opened
char buffer[114];
short i;

// main function
void main()
{
  OSCCON = 0x70;      // set internal oscillator to 16MHz
  ANSELC = 0;         // configure all PORTC pins as digital
  ANSELD = 0;         // configure all PORTD pins as digital
  delay_ms(1000);     // wait a second

  // initialize SPI1 module at lowest speed
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

  UART1_Init(9600);   // initialize UART1 module at 9600 baud
  UART1_Write_Text("\r\n\nInitialize FAT library ... ");
  delay_ms(2000);     // wait 2 seconds

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
  UART1_Write_Text("\r\n\r\n***** END *****");

  while(1) ;  // endless loop

}
// end of code.