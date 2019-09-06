#line 1 "//Mac/Home/Documents/Code/microC/PIC18F46K22_datalogger/SD_USART_mikroC/USART_test.c"

sbit Mmc_Chip_Select at RD4_bit;
sbit Mmc_Chip_Select_Direction at TRISD4_bit;
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/fat32 library/uses/__lib_fat32.h"
#line 29 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/fat32 library/uses/__lib_fat32.h"
typedef unsigned short uint8;
typedef signed short int8;
typedef unsigned int uint16;
typedef signed int int16;
typedef unsigned long uint32;
typedef signed long int32;
typedef unsigned long long uint64;
typedef signed long long int64;

static const uint16 SECTOR_SIZE = 512;









static const uint8
 FILE_READ = 0x01,
 FILE_WRITE = 0x02,
 FILE_APPEND = 0x04;






static const uint8
 ATTR_NONE = 0x00,
 ATTR_READ_ONLY = 0x01,
 ATTR_HIDDEN = 0x02,
 ATTR_SYSTEM = 0x04,
 ATTR_VOLUME_ID = 0x08,
 ATTR_DIRECTORY = 0x10,
 ATTR_ARCHIVE = 0x20,
 ATTR_DEVICE = 0x40,

 ATTR_RESERVED = 0x80;

static const uint8
 ATTR_LONG_NAME = ATTR_READ_ONLY |
 ATTR_HIDDEN |
 ATTR_SYSTEM |
 ATTR_VOLUME_ID;

static const uint8
 ATTR_FILE_MASK = ATTR_READ_ONLY |
 ATTR_HIDDEN |
 ATTR_SYSTEM |
 ATTR_ARCHIVE,

 ATTR_LONG_NAME_MASK = ATTR_READ_ONLY |
 ATTR_HIDDEN |
 ATTR_SYSTEM |
 ATTR_VOLUME_ID |
 ATTR_DIRECTORY |
 ATTR_ARCHIVE;






static const int8



 OK = 0,
 ERROR = -1,
 FOUND = 1,



 E_READ = -1,
 E_WRITE = -2,
 E_INIT_CARD = -3,
 E_BOOT_SIGN = -4,
 E_BOOT_REC = -5,
 E_FILE_SYS_INFO = -6,
 E_DEVICE_SIZE = -7,
 E_FAT_TYPE = -8,
 E_VOLUME_LABEL = -9,



 E_LAST_ENTRY = -10,
 E_FREE_ENTRY = -11,
 E_CLUST_NUM = -12,
 E_NO_SWAP_SPACE = -13,
 E_NO_SPACE = -14,
 E_LAST_CLUST = -15,



 E_DIR_NAME = -20,
 E_ISNT_DIR = -21,
 E_DIR_EXISTS = -22,
 E_DIR_NOTFOUND = -23,
 E_DIR_NOTEMPTY = -24,
 E_DIR_SIZE = -25,



 E_FILE_NAME = -30,
 E_ISNT_FILE = -31,
 E_FILE_EXISTS = -32,
 E_FILE_NOTFOUND = -33,
 E_FILE_NOTEMPTY = -34,
 E_MAX_FILES = -35,
 E_FILE_NOTOPENED = -36,
 E_FILE_EOF = -37,
 E_FILE_READ = -38,
 E_FILE_WRITE = -39,
 E_FILE_HANDLE = -40,
 E_FILE_READ_ONLY = -41,
 E_FILE_OPENED = -42,



 E_TIME_YEAR = -50,
 E_TIME_MONTH = -51,
 E_TIME_DAY = -52,
 E_TIME_HOUR = -53,
 E_TIME_MINUTE = -54,
 E_TIME_SECOND = -55,



 E_NAME_NULL = -60,
 E_CHAR_UNALLOWED = -61,
 E_LFN_ORD = -62,
 E_LFN_CHK = -63,
 E_LFN_ATTR = -64,
 E_LFN_MAX_SINONIM = -65,
 E_NAME_TOLONG = -66,
 E_NAME_EXIST = -67,



 E_PARAM = -80,
 E_REAPCK = -81,
 E_DELETE = -82,
 E_DELETE_NUM = -83,
 E_ATTR = -84;



typedef struct
{
 uint8 State[1];
 uint8 __1[3];
 uint8 Type[1];
 uint8 __2[3];
 uint8 Boot[4];
 uint8 Size[4];
}
FAT32_PART;



typedef struct
{
 uint8 __1[446];
 FAT32_PART Part[4];
 uint8 BootSign[2];
}
FAT32_MBR;



typedef struct
{
 uint8 JmpCode[3];
 uint8 __1[8];
 uint8 BytesPSect[2];
 uint8 SectsPClust[1];
 uint8 Reserved[2];
 uint8 FATCopies[1];
 uint8 RootEntries[2];
 uint8 __2[2];
 uint8 MediaDesc[1];
 uint8 __3[10];
 uint8 Sects[4];
 uint8 SectsPFAT[4];
 uint8 Flags[2];
 uint8 __4[2];
 uint8 RootClust[4];
 uint8 FSISect[2];
 uint8 BootBackup[2];
 uint8 __5[14];
 uint8 ExtSign[1];
 uint8 __6[4];
 uint8 VolName[11];
 uint8 FATName[8];
 uint8 __7[420];
 uint8 BootSign[2];
}
FAT32_BR;



typedef struct
{
 uint8 LeadSig[4];
 uint8 __1[480];
 uint8 StrucSig[4];
 uint8 FreeCount[4];
 uint8 NextFree[4];
 uint8 __2[14];
 uint8 TrailSig[2];
}
FAT32_FSI;


typedef struct
{
 uint8 Entry[4];
}
FAT32_FATENT;



typedef struct
{
 uint8 NameExt[11];
 uint8 Attrib[1];
 uint8 NT[1];
 uint8 __1[1];
 uint8 CTime[2];
 uint8 CDate[2];
 uint8 ATime[2];
 uint8 HiClust[2];
 uint8 MTime[2];
 uint8 MDate[2];
 uint8 LoClust[2];
 uint8 Size[4];
}
FAT32_DIRENT;



typedef struct
{
 uint8 OrdField[1];
 uint8 UC0[2];
 uint8 UC1[2];
 uint8 UC2[2];
 uint8 UC3[2];
 uint8 UC4[2];
 uint8 Attrib[1];
 uint8 __1[1];
 uint8 Checksum[1];
 uint8 UC5[2];
 uint8 UC6[2];
 uint8 UC7[2];
 uint8 UC8[2];
 uint8 UC9[2];
 uint8 UC10[2];
 uint8 __2[2];
 uint8 UC11[2];
 uint8 UC12[2];
}
FAT32_LFNENT;



typedef uint32 __CLUSTER;
typedef uint32 __SECTOR;
typedef uint32 __ENTRY;

typedef int8 __HANDLE;



typedef struct
{
 uint16 Year;
 uint8 Month;
 uint8 Day;
 uint8 Hour;
 uint8 Minute;
 uint8 Second;
}
__TIME;



typedef struct
{
 uint8 State;
 uint8 Type;
 __SECTOR Boot;
 uint32 Size;
}
__PART;



typedef struct
{
 __PART Part[1];
 uint16 BytesPSect;
 uint8 SectsPClust;
 uint16 Reserved;
 uint8 FATCopies;
 uint32 SectsPFAT;
 uint16 Flags;
 __SECTOR FAT;
 __CLUSTER Root;
 uint16 RootEntries;
 __SECTOR Data;
 __SECTOR FSI;
 uint32 ClFreeCount;
 __CLUSTER ClNextFree;
}
__INFO;

typedef struct
{
 char Path[270];
 uint16 Length;
}
__PATH;


typedef struct
{
 char NameExt[255];
 uint8 Attrib;

 uint32 Size;
 __CLUSTER _1stClust;

 __CLUSTER EntryClust;
 __ENTRY Entry;
}
__DIR;


typedef struct
{
 __CLUSTER _1stClust;
 __CLUSTER CurrClust;

 __CLUSTER EntryClust;
 __ENTRY Entry;

 uint32 Cursor;
 uint32 Length;

 uint8 Mode;
 uint8 Attr;
}
__FILE;
#line 389 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/fat32 library/uses/__lib_fat32.h"
typedef struct
{
 __SECTOR fSectNum;
 char fSect[SECTOR_SIZE];
}
__RAW_SECTOR;


extern const char CRLF_F32[];
extern const uint8 FAT32_MAX_FILES;
extern const uint8 f32_fsi_template[SECTOR_SIZE];
extern const uint8 f32_br_template[SECTOR_SIZE];
extern __FILE fat32_fdesc[];
extern __RAW_SECTOR f32_sector;


extern int8 FAT32_Dev_Init (void);
extern int8 FAT32_Dev_Read_Sector (__SECTOR sc, char* buf);
extern int8 FAT32_Dev_Write_Sector (__SECTOR sc, char* buf);
extern int8 FAT32_Dev_Multi_Read_Stop();
extern int8 FAT32_Dev_Multi_Read_Sector(char* buf);
extern int8 FAT32_Dev_Multi_Read_Start(__SECTOR sc);
extern int8 FAT32_Put_Char (char ch);


int8 FAT32_Init (void);
int8 FAT32_Format (char *devLabel);
int8 FAT32_ScanDisk (uint32 *totClust, uint32 *freeClust, uint32 *badClust);
int8 FAT32_GetFreeSpace(uint32 *freeClusts, uint16 *bytesPerClust);

int8 FAT32_ChangeDir (char *dname);
int8 FAT32_MakeDir (char *dname);
int8 FAT32_Dir (void);
int8 FAT32_FindFirst (__DIR *pDE);
int8 FAT32_FindNext (__DIR *pDE);
int8 FAT32_Delete (char *fn);
int8 FAT32_DeleteRec (char *fn);
int8 FAT32_Exists (char *name);
int8 FAT32_Rename (char *oldName, char *newName);
int8 FAT32_Open (char *fn, uint8 mode);
int8 FAT32_Eof (__HANDLE fHandle);
int8 FAT32_Read (__HANDLE fHandle, char* rdBuf, uint16 len);
int8 FAT32_Write (__HANDLE fHandle, char* wrBuf, uint16 len);
int8 FAT32_Seek (__HANDLE fHandle, uint32 pos);
int8 FAT32_Tell (__HANDLE fHandle, uint32 *pPos);
int8 FAT32_Close (__HANDLE fHandle);
int8 FAT32_Size (char *fname, uint32 *pSize);
int8 FAT32_GetFileHandle(char *fname, __HANDLE *handle);

int8 FAT32_SetTime (__TIME *pTM);
int8 FAT32_IncTime (uint32 Sec);

int8 FAT32_GetCTime (char *fname, __TIME *pTM);
int8 FAT32_GetMTime (char *fname, __TIME *pTM);

int8 FAT32_SetAttr (char *fname, uint8 attr);
int8 FAT32_GetAttr (char *fname, uint8* attr);

int8 FAT32_GetError (void);

int8 FAT32_MakeSwap (char *name, __SECTOR nSc, __CLUSTER *pCl);
int8 FAT32_ReadSwap (__HANDLE fHandle, char* rdBuf, uint16 len);
int8 FAT32_WriteSwap (__HANDLE fHandle, char* wrBuf, uint16 len);
int8 FAT32_SeekSwap (__HANDLE fHandle, uint32 pos);

const char* FAT32_getVersion();
uint8* FAT32_GetCurrentPath( void );

__CLUSTER FAT32_SectToClust(__SECTOR sc);
__SECTOR FAT32_ClustToSect(__CLUSTER cl);
#line 9 "//Mac/Home/Documents/Code/microC/PIC18F46K22_datalogger/SD_USART_mikroC/USART_test.c"
__HANDLE fileHandle;
char buffer[114];
short i;


void logging_Init();
void ReadADC_and_Log();

void main() {

 OSCCON = 0b01110000;





 OSCTUNE = 0b00000000;



 ANSELA = 0;
 ANSELC = 0;
 ANSELD = 0;




 ADC_Init_Advanced(_ADC_INTERNAL_VREFL | _ADC_INTERNAL_FVRH1);
 delay_ms(1000);

 logging_Init();


 while(1){

 ReadADC_and_Log();
#line 66 "//Mac/Home/Documents/Code/microC/PIC18F46K22_datalogger/SD_USART_mikroC/USART_test.c"
 }
}

void ReadADC_and_Log(){
 int R0;
 int R1;
 char R0_[6];
 char R1_[6];

 R0 = ADC_Get_Sample(0);
 R1 = ADC_Get_Sample(1);
 WordToStr(R0, R0_);
 WordToStr(R1, R1_);

 Delay_ms(1000);



 fileHandle = FAT32_Open("Log.txt", FILE_APPEND);

 UART1_Write_Text("\n");
 UART1_Write_Text(R0_);
 UART1_Write_Text("\t");
 UART1_Write_Text(R1_);

 i = FAT32_Write(fileHandle, "\r\n", 6);
 i = FAT32_Write(fileHandle, R0_, 6);

 i = FAT32_Write(fileHandle, R1_, 6);






 i = FAT32_Close(fileHandle);


 delay_ms(5000);
}


void logging_Init(){

 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

 UART1_Init(9600);

 UART1_Write_Text("\r\n\nInitialize FAT library ... ");
 delay_ms(1000);


 i = FAT32_Init();
 if(i != 0)
 {
 UART1_Write_Text("Error initializing FAT library (SD card missing?)!");
 }

 else
 {

 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
 UART1_Write_Text("FAT Library initialized");
 delay_ms(1000);
#line 143 "//Mac/Home/Documents/Code/microC/PIC18F46K22_datalogger/SD_USART_mikroC/USART_test.c"
 UART1_Write_Text("\r\n\r\nWrite test code to file :  This_is_a_text_file_created_using_PIC18F46K22_microcontroller");
 fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
#line 155 "//Mac/Home/Documents/Code/microC/PIC18F46K22_datalogger/SD_USART_mikroC/USART_test.c"
 i = FAT32_Write(fileHandle, "\r\nThis_is_a_text_file_created_using_PIC18F46K22_microcontroller_and_mikroC_compiler.\r\n", 113);
#line 163 "//Mac/Home/Documents/Code/microC/PIC18F46K22_datalogger/SD_USART_mikroC/USART_test.c"
 delay_ms(1000);


 i = FAT32_Close(fileHandle);
#line 176 "//Mac/Home/Documents/Code/microC/PIC18F46K22_datalogger/SD_USART_mikroC/USART_test.c"
 UART1_Write_Text("\r\n\r\nReading first line of file:");
 delay_ms(1000);


 UART1_Write_Text("\r\nOpen file ... ");
 fileHandle = FAT32_Open("Log.txt", FILE_READ);
 if(fileHandle != 0)
 UART1_Write_Text("error opening file");
 else
 {



 UART1_Write_Text("\r\nPrint file:\r\n\r");
 delay_ms(1000);

 FAT32_Read(fileHandle, buffer, 113);

 UART1_Write_Text(buffer);

 delay_ms(1000);

 UART1_Write_Text("\r\n\r\nClosing the file ... ");
 i = FAT32_Close(fileHandle);
#line 208 "//Mac/Home/Documents/Code/microC/PIC18F46K22_datalogger/SD_USART_mikroC/USART_test.c"
 }
 }

 delay_ms(1000);
 UART1_Write_Text("\r\n\r\n***** END OF INITIALISATION *****\r\n\r\n");
}
