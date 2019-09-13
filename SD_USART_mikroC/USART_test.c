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





https://simple-circuit.com/pic18f46k22-sd-card-fat32-mikroc/
https://simple-circuit.com/mikroc-dht22-data-logger-sd-card/
https://simple-circuit.com/pic18f46k22-bme280-data-logger-mikroc/


ADC to buffer
https://www.studentcompanion.co.za/temperature-logger-to-sd-card-with-menu-control-mikroc/


TODO : load ADC string conversion into buffer of correct length to see if UART overspill text problem is solved. Then you can addback in UART text if you want to

*/



// SD card chip select pin connection
sbit Mmc_Chip_Select           at RD4_bit;
sbit Mmc_Chip_Select_Direction at TRISD4_bit;

#define DS3231_I2C2    // use hardware I2C2 moodule (MSSP2) for DS3231 RTC
//#include "DS3231.c"    // include DS3231 RTC driver source file



// include __Lib_FAT32.h file (useful definitions)
#include "__Lib_FAT32.h"

// variable declarations
__HANDLE fileHandle;   // only one file can be opened
char buffer[114];
short i;




#ifdef DS3231_SOFT_I2C
#define RTC_I2C_START    Soft_I2C_Start
#define RTC_I2C_RESTART  Soft_I2C_Start
#define RTC_I2C_WRITE    Soft_I2C_Write
#define RTC_I2C_READ     Soft_I2C_Read
#define RTC_I2C_STOP     Soft_I2C_Stop

#else
#ifdef  DS3231_I2C2
#define RTC_I2C_START    I2C2_Start
#define RTC_I2C_RESTART  I2C2_Repeated_Start
#define RTC_I2C_WRITE    I2C2_Wr
#define RTC_I2C_READ     I2C2_Rd
#define RTC_I2C_STOP     I2C2_Stop

#else
#define RTC_I2C_START    I2C1_Start
#define RTC_I2C_RESTART  I2C1_Repeated_Start
#define RTC_I2C_WRITE    I2C1_Wr
#define RTC_I2C_READ     I2C1_Rd
#define RTC_I2C_STOP     I2C1_Stop
#endif
#endif

#include <stdint.h>

#define DS3231_ADDRESS       0xD0
#define DS3231_REG_SECONDS   0x00
#define DS3231_REG_AL1_SEC   0x07
#define DS3231_REG_AL2_MIN   0x0B
#define DS3231_REG_CONTROL   0x0E
#define DS3231_REG_STATUS    0x0F
#define DS3231_REG_TEMP_MSB  0x11

typedef enum
{
  SUNDAY = 1,
  MONDAY,
  TUESDAY,
  WEDNESDAY,
  THURSDAY,
  FRIDAY,
  SATURDAY
} RTC_DOW;

typedef enum
{
  JANUARY = 1,
  FEBRUARY,
  MARCH,
  APRIL,
  MAY,
  JUNE,
  JULY,
  AUGUST,
  SEPTEMBER,
  OCTOBER,
  NOVEMBER,
  DECEMBER
} RTC_Month;

typedef struct rtc_tm
{
  uint8_t seconds;
  uint8_t minutes;
  uint8_t hours;
  RTC_DOW dow;
  uint8_t day;
  RTC_Month month;
  uint8_t year;
} RTC_Time;

typedef enum
{
  ONCE_PER_SECOND = 0x0F,
  SECONDS_MATCH = 0x0E,
  MINUTES_SECONDS_MATCH = 0x0C,
  HOURS_MINUTES_SECONDS_MATCH = 0x08,
  DATE_HOURS_MINUTES_SECONDS_MATCH = 0x0,
  DAY_HOURS_MINUTES_SECONDS_MATCH = 0x10
} al1;

typedef enum
{
  ONCE_PER_MINUTE = 0x0E,
  MINUTES_MATCH = 0x0C,
  HOURS_MINUTES_MATCH = 0x08,
  DATE_HOURS_MINUTES_MATCH = 0x0,
  DAY_HOURS_MINUTES_MATCH = 0x10
} al2;

typedef enum
{
  OUT_OFF = 0x00,
  OUT_INT = 0x04,
  OUT_1Hz = 0x40,
  OUT_1024Hz = 0x48,
  OUT_4096Hz = 0x50,
  OUT_8192Hz = 0x58
} INT_SQW;

RTC_Time c_time, c_alarm1, c_alarm2;

///////////////////////// All Functions /////////////////////////
                                                               //
uint8_t bcd_to_decimal(uint8_t number);                        //
uint8_t decimal_to_bcd(uint8_t number);                        //
uint8_t alarm_cfg(uint8_t n, uint8_t i);                       //
void RTC_Set(RTC_Time *time_t);                                //
RTC_Time *RTC_Get();                                           //
void Alarm1_Set(RTC_Time *time_t, al1 _config);                //
RTC_Time *Alarm1_Get();                                        //
void Alarm1_Enable();                                          //
void Alarm1_Disable();                                         //
uint8_t Alarm1_IF_Check();                                     //
void Alarm1_IF_Reset();                                        //
uint8_t Alarm1_Status();                                       //
void Alarm2_Set(RTC_Time *time_t, al2 _config);                //
RTC_Time *Alarm2_Get();                                        //
void Alarm2_Enable();                                          //
void Alarm2_Disable();                                         //
uint8_t Alarm2_IF_Check();                                     //
void Alarm2_IF_Reset();                                        //
uint8_t Alarm2_Status();                                       //
void IntSqw_Set(INT_SQW _config);                              //
void Enable_32kHZ();                                           //
void Disable_32kHZ();                                          //
void OSC_Start();                                              //
void OSC_Stop();                                               //
int16_t Get_Temperature();                                     //
uint8_t RTC_Read_Reg(uint8_t reg_address);                     //
void RTC_Write_Reg(uint8_t reg_address, uint8_t reg_value);    //
                                                               //
/////////////////////////////////////////////////////////////////

// converts BCD to decimal
uint8_t bcd_to_decimal(uint8_t number)
{
  return ( (number >> 4) * 10 + (number & 0x0F) );
}

// converts decimal to BCD
uint8_t decimal_to_bcd(uint8_t number)
{
  return ( ((number / 10) << 4) + (number % 10) );
}

// test configuration bits (for alarm1 and alarm2 only)
uint8_t alarm_cfg(uint8_t n, uint8_t i)
{
  if( n & (1 << i) )
    return 0x80;
  else
    return 0;
}

// sets time and date
void RTC_Set(RTC_Time *time_t)
{
  // convert decimal to BCD
  time_t->day     = decimal_to_bcd(time_t->day);
  time_t->month   = decimal_to_bcd(time_t->month);
  time_t->year    = decimal_to_bcd(time_t->year);
  time_t->hours   = decimal_to_bcd(time_t->hours);
  time_t->minutes = decimal_to_bcd(time_t->minutes);
  time_t->seconds = decimal_to_bcd(time_t->seconds);
  // end conversion

  // write data to the RTC chip
  RTC_I2C_START();
  RTC_I2C_WRITE(DS3231_ADDRESS);
  RTC_I2C_WRITE(DS3231_REG_SECONDS);
  RTC_I2C_WRITE(time_t->seconds);
  RTC_I2C_WRITE(time_t->minutes);
  RTC_I2C_WRITE(time_t->hours);
  RTC_I2C_WRITE(time_t->dow);
  RTC_I2C_WRITE(time_t->day);
  RTC_I2C_WRITE(time_t->month);
  RTC_I2C_WRITE(time_t->year);
  RTC_I2C_STOP();
}

// reads time and date
RTC_Time *RTC_Get()
{
  RTC_I2C_START();
  RTC_I2C_WRITE(DS3231_ADDRESS);
  RTC_I2C_WRITE(DS3231_REG_SECONDS);
  RTC_I2C_RESTART();
  RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
  c_time.seconds = RTC_I2C_READ(1);
  c_time.minutes = RTC_I2C_READ(1);
  c_time.hours   = RTC_I2C_READ(1);
  c_time.dow   = RTC_I2C_READ(1);
  c_time.day   = RTC_I2C_READ(1);
  c_time.month = RTC_I2C_READ(1);
  c_time.year  = RTC_I2C_READ(0);
  RTC_I2C_STOP();

  // convert BCD to decimal
  c_time.seconds = bcd_to_decimal(c_time.seconds);
  c_time.minutes = bcd_to_decimal(c_time.minutes);
  c_time.hours   = bcd_to_decimal(c_time.hours);
  c_time.day     = bcd_to_decimal(c_time.day);
  c_time.month   = bcd_to_decimal(c_time.month);
  c_time.year    = bcd_to_decimal(c_time.year);
  // end conversion

  return &c_time;
}

// sets alarm1 details
void Alarm1_Set(RTC_Time *time_t, al1 _config)
{
  // convert decimal to BCD
  time_t->day     = decimal_to_bcd(time_t->day);
  time_t->hours   = decimal_to_bcd(time_t->hours);
  time_t->minutes = decimal_to_bcd(time_t->minutes);
  time_t->seconds = decimal_to_bcd(time_t->seconds);
  // end conversion

  // write data to the RTC chip
  RTC_I2C_START();
  RTC_I2C_WRITE(DS3231_ADDRESS);
  RTC_I2C_WRITE(DS3231_REG_AL1_SEC);
  RTC_I2C_WRITE( time_t->seconds | alarm_cfg(_config, 0) );
  RTC_I2C_WRITE( time_t->minutes | alarm_cfg(_config, 1) );
  RTC_I2C_WRITE( time_t->hours   | alarm_cfg(_config, 2) );
  if ( _config & 0x10 )
    RTC_I2C_WRITE( time_t->dow | 0x40 | alarm_cfg(_config, 3) );
  else
    RTC_I2C_WRITE( time_t->day | alarm_cfg(_config, 3) );
  RTC_I2C_STOP();
}

// reads alarm1 details
RTC_Time *Alarm1_Get()
{
  RTC_I2C_START();
  RTC_I2C_WRITE(DS3231_ADDRESS);
  RTC_I2C_WRITE(DS3231_REG_AL1_SEC);
  RTC_I2C_RESTART();
  RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
  c_alarm1.seconds = RTC_I2C_READ(1) & 0x7F;
  c_alarm1.minutes = RTC_I2C_READ(1) & 0x7F;
  c_alarm1.hours   = RTC_I2C_READ(1) & 0x3F;
  c_alarm1.dow = c_alarm1.day = RTC_I2C_READ(0) & 0x3F;
  RTC_I2C_STOP();

  // convert BCD to decimal
  c_alarm1.seconds = bcd_to_decimal(c_alarm1.seconds);
  c_alarm1.minutes = bcd_to_decimal(c_alarm1.minutes);
  c_alarm1.hours   = bcd_to_decimal(c_alarm1.hours);
  c_alarm1.day     = bcd_to_decimal(c_alarm1.day);
  // end conversion

  return &c_alarm1;
}

// enables alarm1
void Alarm1_Enable()
{
  uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
  ctrl_reg |= 0x01;
  RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
}

// disables alarm1
void Alarm1_Disable()
{
  uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
  ctrl_reg &= 0xFE;
  RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
}

// checks if alarm1 occurred, returns 1 if yes and 0 if no
uint8_t Alarm1_IF_Check()
{
  uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
  if(stat_reg & 0x01)
    return 1;
  else
    return 0;
}

// resets alarm1 flag bit
void Alarm1_IF_Reset()
{
  uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
  stat_reg &= 0xFE;
  RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
}

// returns TRUE (1) if alarm1 is enabled and FALSE (0) if disabled
uint8_t Alarm1_Status()
{
  uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
  if(ctrl_reg & 0x01)
    return 1;
  else
    return 0;
}

// sets alarm2 details
void Alarm2_Set(RTC_Time *time_t, al2 _config)
{
  // convert decimal to BCD
  time_t->day     = decimal_to_bcd(time_t->day);
  time_t->hours   = decimal_to_bcd(time_t->hours);
  time_t->minutes = decimal_to_bcd(time_t->minutes);
  // end conversion

  // write data to the RTC chip
  RTC_I2C_START();
  RTC_I2C_WRITE(DS3231_ADDRESS);
  RTC_I2C_WRITE(DS3231_REG_AL2_MIN);
  RTC_I2C_WRITE( (time_t->minutes) | alarm_cfg(_config, 1) );
  RTC_I2C_WRITE( (time_t->hours) | alarm_cfg(_config, 2) );
  if ( _config & 0x10 )
    RTC_I2C_WRITE( time_t->dow | 0x40 | alarm_cfg(_config, 3) );
  else
    RTC_I2C_WRITE( time_t->day | alarm_cfg(_config, 3) );
  RTC_I2C_STOP();
}

// reads alarm2 details
RTC_Time *Alarm2_Get()
{
  RTC_I2C_START();
  RTC_I2C_WRITE(DS3231_ADDRESS);
  RTC_I2C_WRITE(DS3231_REG_AL2_MIN);
  RTC_I2C_RESTART();
  RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
  c_alarm2.minutes = RTC_I2C_READ(1) & 0x7F;
  c_alarm2.hours   = RTC_I2C_READ(1) & 0x3F;
  c_alarm2.dow = c_alarm2.day = RTC_I2C_READ(0) & 0x3F;
  RTC_I2C_STOP();

  // convert BCD to decimal
  c_alarm2.minutes = bcd_to_decimal(c_alarm2.minutes);
  c_alarm2.hours   = bcd_to_decimal(c_alarm2.hours);
  c_alarm2.day     = bcd_to_decimal(c_alarm2.day);
  // end conversion
  c_alarm2.seconds = 0;
  return &c_alarm2;
}

// enables alarm2
void Alarm2_Enable()
{
  uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
  ctrl_reg |= 0x02;
  RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
}

//disables alarm2
void Alarm2_Disable()
{
  uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
  ctrl_reg &= 0xFD;
  RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
}

// checks if alarm2 occurred, returns 1 if yes and 0 if no
uint8_t Alarm2_IF_Check()
{
  uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
  if(stat_reg & 0x02)
    return 1;
  else
    return 0;
}

// resets alarm2 flag bit
void Alarm2_IF_Reset()
{
  uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
  stat_reg &= 0xFD;
  RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
}

// returns TRUE (1) if alarm2 is enabled and FALSE (0) if disabled
uint8_t Alarm2_Status()
{
  uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
  if(ctrl_reg & 0x02)
    return 1;
  else
    return 0;
}

// writes 'reg_value' to register of address 'reg_address'
void RTC_Write_Reg(uint8_t reg_address, uint8_t reg_value)
{
  RTC_I2C_START();
  RTC_I2C_WRITE(DS3231_ADDRESS);
  RTC_I2C_WRITE(reg_address);
  RTC_I2C_WRITE(reg_value);
  RTC_I2C_STOP();
}

// returns the value stored in register of address 'reg_address'
uint8_t RTC_Read_Reg(uint8_t reg_address)
{
  uint8_t reg_data;

  RTC_I2C_START();
  RTC_I2C_WRITE(DS3231_ADDRESS);
  RTC_I2C_WRITE(reg_address);
  RTC_I2C_RESTART();
  RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
  reg_data = RTC_I2C_READ(0);
  RTC_I2C_STOP();

  return reg_data;
}

// sets INT/SQW pin configuration
void IntSqw_Set(INT_SQW _config)
{
  uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
  ctrl_reg &= 0xA3;
  ctrl_reg |= _config;
  RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
}

// enables 32kHz (pin 32kHz)
void Enable_32kHZ()
{
  uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
  stat_reg |= 0x08;
  RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
}

// disables 32kHz (pin 32kHz)
void Disable_32kHZ()
{
  uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
  stat_reg &= 0xF7;
  RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
}

// starts RTC oscillator
void OSC_Start()
{
  uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
  ctrl_reg &= 0x7F;
  RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
}

// stops RTC oscillator
void OSC_Stop()
{
  uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
  ctrl_reg |= 0x80;
  RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
}

// returns chip temperature
// Temperature is stored in hundredths C (output value of "3125" equals 31.25 ?C).
int16_t Get_Temperature()
{
  uint8_t t_msb, t_lsb;
  uint16_t c_temp;
  RTC_I2C_START();
  RTC_I2C_WRITE(DS3231_ADDRESS);
  RTC_I2C_WRITE(DS3231_REG_TEMP_MSB);
  RTC_I2C_RESTART();
  RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
  t_msb = RTC_I2C_READ(1);
 }

RTC_Time *mytime;      // DS3231 library variable

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
  ANSELB = 0;         // configure all PORTB pins as digital
  ANSELC = 0;         // configure all PORTC pins as digital
  ANSELD = 0;         // configure all PORTD pins as digital
  T0CON  = 0x04;      // configure Timer0 module (16-bit timer & prescaler = 32)

  // initialize ADC module with voltage references: VSS - FVR(4.096V)
  // ADC_Init_Advanced(_ADC_INTERNAL_VREFL | _ADC_INTERNAL_FVRH4);
  // initialize ADC module with voltage references: VSS - FVR(1.024V)
  ADC_Init_Advanced(_ADC_INTERNAL_VREFL | _ADC_INTERNAL_FVRH1);
  delay_ms(1000);     // wait a second
  
  // initialize I2C2 module with clock frequency of 400KHz
  I2C2_Init(400000);

  logging_Init();
  
  mytime->day   = '1' ;
  mytime->month = '2'  ;
  mytime->year  = '3' ;
  mytime->hours   = '1' ;
  mytime->minutes = '2'  ;
  mytime->seconds  = '3' ;
  RTC_Set(mytime);



    while(1){

             ReadADC_and_Log();
             mytime = RTC_Get();
             UART1_Write_Text(mytime->hours);
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

     i = FAT32_Write(fileHandle, "\r\n", 6);
     i = FAT32_Write(fileHandle, R0_, 6);
     //i = FAT32_Write(fileHandle, "\t", 6);
     i = FAT32_Write(fileHandle, R1_, 6);

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