///////////////////////////////////////////////////////////////////////////
////                                                                   ////
////                             DS3231.h                              ////
////                                                                   ////
////                     Driver for mikroC compiler                    ////
////                                                                   ////
////     Driver for Maxim DS3231 serial I2C real-time clock (RTC).     ////
////                                                                   ////
///////////////////////////////////////////////////////////////////////////
////                                                                   ////
////                     https://simple-circuit.com/                   ////
////                                                                   ////
///////////////////////////////////////////////////////////////////////////


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