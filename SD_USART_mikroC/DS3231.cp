#line 1 "//Mac/Home/Documents/Code/microC/PIC18F46K22_datalogger/SD_USART_mikroC/DS3231.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdint.h"




typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;



typedef signed char int_fast8_t;
typedef signed int int_fast16_t;
typedef signed long int int_fast32_t;


typedef unsigned char uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned long int uint_fast32_t;


typedef signed int intptr_t;
typedef unsigned int uintptr_t;


typedef signed long int intmax_t;
typedef unsigned long int uintmax_t;
#line 50 "//Mac/Home/Documents/Code/microC/PIC18F46K22_datalogger/SD_USART_mikroC/DS3231.c"
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



uint8_t bcd_to_decimal(uint8_t number);
uint8_t decimal_to_bcd(uint8_t number);
uint8_t alarm_cfg(uint8_t n, uint8_t i);
void RTC_Set(RTC_Time *time_t);
RTC_Time *RTC_Get();
void Alarm1_Set(RTC_Time *time_t, al1 _config);
RTC_Time *Alarm1_Get();
void Alarm1_Enable();
void Alarm1_Disable();
uint8_t Alarm1_IF_Check();
void Alarm1_IF_Reset();
uint8_t Alarm1_Status();
void Alarm2_Set(RTC_Time *time_t, al2 _config);
RTC_Time *Alarm2_Get();
void Alarm2_Enable();
void Alarm2_Disable();
uint8_t Alarm2_IF_Check();
void Alarm2_IF_Reset();
uint8_t Alarm2_Status();
void IntSqw_Set(INT_SQW _config);
void Enable_32kHZ();
void Disable_32kHZ();
void OSC_Start();
void OSC_Stop();
int16_t Get_Temperature();
uint8_t RTC_Read_Reg(uint8_t reg_address);
void RTC_Write_Reg(uint8_t reg_address, uint8_t reg_value);




uint8_t bcd_to_decimal(uint8_t number)
{
 return ( (number >> 4) * 10 + (number & 0x0F) );
}


uint8_t decimal_to_bcd(uint8_t number)
{
 return ( ((number / 10) << 4) + (number % 10) );
}


uint8_t alarm_cfg(uint8_t n, uint8_t i)
{
 if( n & (1 << i) )
 return 0x80;
 else
 return 0;
}


void RTC_Set(RTC_Time *time_t)
{

 time_t->day = decimal_to_bcd(time_t->day);
 time_t->month = decimal_to_bcd(time_t->month);
 time_t->year = decimal_to_bcd(time_t->year);
 time_t->hours = decimal_to_bcd(time_t->hours);
 time_t->minutes = decimal_to_bcd(time_t->minutes);
 time_t->seconds = decimal_to_bcd(time_t->seconds);



  I2C1_Start ();
  I2C1_Wr ( 0xD0 );
  I2C1_Wr ( 0x00 );
  I2C1_Wr (time_t->seconds);
  I2C1_Wr (time_t->minutes);
  I2C1_Wr (time_t->hours);
  I2C1_Wr (time_t->dow);
  I2C1_Wr (time_t->day);
  I2C1_Wr (time_t->month);
  I2C1_Wr (time_t->year);
  I2C1_Stop ();
}


RTC_Time *RTC_Get()
{
  I2C1_Start ();
  I2C1_Wr ( 0xD0 );
  I2C1_Wr ( 0x00 );
  I2C1_Repeated_Start ();
  I2C1_Wr ( 0xD0  | 0x01);
 c_time.seconds =  I2C1_Rd (1);
 c_time.minutes =  I2C1_Rd (1);
 c_time.hours =  I2C1_Rd (1);
 c_time.dow =  I2C1_Rd (1);
 c_time.day =  I2C1_Rd (1);
 c_time.month =  I2C1_Rd (1);
 c_time.year =  I2C1_Rd (0);
  I2C1_Stop ();


 c_time.seconds = bcd_to_decimal(c_time.seconds);
 c_time.minutes = bcd_to_decimal(c_time.minutes);
 c_time.hours = bcd_to_decimal(c_time.hours);
 c_time.day = bcd_to_decimal(c_time.day);
 c_time.month = bcd_to_decimal(c_time.month);
 c_time.year = bcd_to_decimal(c_time.year);


 return &c_time;
}


void Alarm1_Set(RTC_Time *time_t, al1 _config)
{

 time_t->day = decimal_to_bcd(time_t->day);
 time_t->hours = decimal_to_bcd(time_t->hours);
 time_t->minutes = decimal_to_bcd(time_t->minutes);
 time_t->seconds = decimal_to_bcd(time_t->seconds);



  I2C1_Start ();
  I2C1_Wr ( 0xD0 );
  I2C1_Wr ( 0x07 );
  I2C1_Wr ( time_t->seconds | alarm_cfg(_config, 0) );
  I2C1_Wr ( time_t->minutes | alarm_cfg(_config, 1) );
  I2C1_Wr ( time_t->hours | alarm_cfg(_config, 2) );
 if ( _config & 0x10 )
  I2C1_Wr ( time_t->dow | 0x40 | alarm_cfg(_config, 3) );
 else
  I2C1_Wr ( time_t->day | alarm_cfg(_config, 3) );
  I2C1_Stop ();
}


RTC_Time *Alarm1_Get()
{
  I2C1_Start ();
  I2C1_Wr ( 0xD0 );
  I2C1_Wr ( 0x07 );
  I2C1_Repeated_Start ();
  I2C1_Wr ( 0xD0  | 0x01);
 c_alarm1.seconds =  I2C1_Rd (1) & 0x7F;
 c_alarm1.minutes =  I2C1_Rd (1) & 0x7F;
 c_alarm1.hours =  I2C1_Rd (1) & 0x3F;
 c_alarm1.dow = c_alarm1.day =  I2C1_Rd (0) & 0x3F;
  I2C1_Stop ();


 c_alarm1.seconds = bcd_to_decimal(c_alarm1.seconds);
 c_alarm1.minutes = bcd_to_decimal(c_alarm1.minutes);
 c_alarm1.hours = bcd_to_decimal(c_alarm1.hours);
 c_alarm1.day = bcd_to_decimal(c_alarm1.day);


 return &c_alarm1;
}


void Alarm1_Enable()
{
 uint8_t ctrl_reg = RTC_Read_Reg( 0x0E );
 ctrl_reg |= 0x01;
 RTC_Write_Reg( 0x0E , ctrl_reg);
}


void Alarm1_Disable()
{
 uint8_t ctrl_reg = RTC_Read_Reg( 0x0E );
 ctrl_reg &= 0xFE;
 RTC_Write_Reg( 0x0E , ctrl_reg);
}


uint8_t Alarm1_IF_Check()
{
 uint8_t stat_reg = RTC_Read_Reg( 0x0F );
 if(stat_reg & 0x01)
 return 1;
 else
 return 0;
}


void Alarm1_IF_Reset()
{
 uint8_t stat_reg = RTC_Read_Reg( 0x0F );
 stat_reg &= 0xFE;
 RTC_Write_Reg( 0x0F , stat_reg);
}


uint8_t Alarm1_Status()
{
 uint8_t ctrl_reg = RTC_Read_Reg( 0x0E );
 if(ctrl_reg & 0x01)
 return 1;
 else
 return 0;
}


void Alarm2_Set(RTC_Time *time_t, al2 _config)
{

 time_t->day = decimal_to_bcd(time_t->day);
 time_t->hours = decimal_to_bcd(time_t->hours);
 time_t->minutes = decimal_to_bcd(time_t->minutes);



  I2C1_Start ();
  I2C1_Wr ( 0xD0 );
  I2C1_Wr ( 0x0B );
  I2C1_Wr ( (time_t->minutes) | alarm_cfg(_config, 1) );
  I2C1_Wr ( (time_t->hours) | alarm_cfg(_config, 2) );
 if ( _config & 0x10 )
  I2C1_Wr ( time_t->dow | 0x40 | alarm_cfg(_config, 3) );
 else
  I2C1_Wr ( time_t->day | alarm_cfg(_config, 3) );
  I2C1_Stop ();
}


RTC_Time *Alarm2_Get()
{
  I2C1_Start ();
  I2C1_Wr ( 0xD0 );
  I2C1_Wr ( 0x0B );
  I2C1_Repeated_Start ();
  I2C1_Wr ( 0xD0  | 0x01);
 c_alarm2.minutes =  I2C1_Rd (1) & 0x7F;
 c_alarm2.hours =  I2C1_Rd (1) & 0x3F;
 c_alarm2.dow = c_alarm2.day =  I2C1_Rd (0) & 0x3F;
  I2C1_Stop ();


 c_alarm2.minutes = bcd_to_decimal(c_alarm2.minutes);
 c_alarm2.hours = bcd_to_decimal(c_alarm2.hours);
 c_alarm2.day = bcd_to_decimal(c_alarm2.day);

 c_alarm2.seconds = 0;
 return &c_alarm2;
}


void Alarm2_Enable()
{
 uint8_t ctrl_reg = RTC_Read_Reg( 0x0E );
 ctrl_reg |= 0x02;
 RTC_Write_Reg( 0x0E , ctrl_reg);
}


void Alarm2_Disable()
{
 uint8_t ctrl_reg = RTC_Read_Reg( 0x0E );
 ctrl_reg &= 0xFD;
 RTC_Write_Reg( 0x0E , ctrl_reg);
}


uint8_t Alarm2_IF_Check()
{
 uint8_t stat_reg = RTC_Read_Reg( 0x0F );
 if(stat_reg & 0x02)
 return 1;
 else
 return 0;
}


void Alarm2_IF_Reset()
{
 uint8_t stat_reg = RTC_Read_Reg( 0x0F );
 stat_reg &= 0xFD;
 RTC_Write_Reg( 0x0F , stat_reg);
}


uint8_t Alarm2_Status()
{
 uint8_t ctrl_reg = RTC_Read_Reg( 0x0E );
 if(ctrl_reg & 0x02)
 return 1;
 else
 return 0;
}


void RTC_Write_Reg(uint8_t reg_address, uint8_t reg_value)
{
  I2C1_Start ();
  I2C1_Wr ( 0xD0 );
  I2C1_Wr (reg_address);
  I2C1_Wr (reg_value);
  I2C1_Stop ();
}


uint8_t RTC_Read_Reg(uint8_t reg_address)
{
 uint8_t reg_data;

  I2C1_Start ();
  I2C1_Wr ( 0xD0 );
  I2C1_Wr (reg_address);
  I2C1_Repeated_Start ();
  I2C1_Wr ( 0xD0  | 0x01);
 reg_data =  I2C1_Rd (0);
  I2C1_Stop ();

 return reg_data;
}


void IntSqw_Set(INT_SQW _config)
{
 uint8_t ctrl_reg = RTC_Read_Reg( 0x0E );
 ctrl_reg &= 0xA3;
 ctrl_reg |= _config;
 RTC_Write_Reg( 0x0E , ctrl_reg);
}


void Enable_32kHZ()
{
 uint8_t stat_reg = RTC_Read_Reg( 0x0F );
 stat_reg |= 0x08;
 RTC_Write_Reg( 0x0F , stat_reg);
}


void Disable_32kHZ()
{
 uint8_t stat_reg = RTC_Read_Reg( 0x0F );
 stat_reg &= 0xF7;
 RTC_Write_Reg( 0x0F , stat_reg);
}


void OSC_Start()
{
 uint8_t ctrl_reg = RTC_Read_Reg( 0x0E );
 ctrl_reg &= 0x7F;
 RTC_Write_Reg( 0x0E , ctrl_reg);
}


void OSC_Stop()
{
 uint8_t ctrl_reg = RTC_Read_Reg( 0x0E );
 ctrl_reg |= 0x80;
 RTC_Write_Reg( 0x0E , ctrl_reg);
}



int16_t Get_Temperature()
{
 uint8_t t_msb, t_lsb;
 uint16_t c_temp;
  I2C1_Start ();
  I2C1_Wr ( 0xD0 );
  I2C1_Wr ( 0x11 );
  I2C1_Repeated_Start ();
  I2C1_Wr ( 0xD0  | 0x01);
 t_msb =  I2C1_Rd (1);
 t_lsb =  I2C1_Rd (0);
  I2C1_Stop ();

 c_temp = (uint16_t)t_msb << 2 | t_lsb >> 6;

 if(t_msb & 0x80)
 c_temp |= 0xFC00;

 return c_temp * 25;
}
