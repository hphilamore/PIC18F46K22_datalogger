
_MSB:

;USART_test.c,58 :: 		unsigned char MSB(unsigned char x)           //Display Most Significant Bit of BCD number
;USART_test.c,60 :: 		return ((x >> 4) + '0');
	MOVF        FARG_MSB_x+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       48
	ADDWF       R0, 1 
;USART_test.c,61 :: 		}
L_end_MSB:
	RETURN      0
; end of _MSB

_LSB:

;USART_test.c,63 :: 		unsigned char  LSB(unsigned char x)          //Display Least Significant Bit of BCD number
;USART_test.c,65 :: 		return ((x & 0x0F) + '0');
	MOVLW       15
	ANDWF       FARG_LSB_x+0, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 1 
;USART_test.c,66 :: 		}
L_end_LSB:
	RETURN      0
; end of _LSB

_main:

;USART_test.c,90 :: 		void main() {
;USART_test.c,92 :: 		OSCCON = 0b01110000;  // bit7: device enters SLEEP on sleep instruction[0]
	MOVLW       112
	MOVWF       OSCCON+0 
;USART_test.c,98 :: 		OSCTUNE = 0b00000000; // bit7:  device clock derived from the MFINTOSC or HFINTOSC source
	CLRF        OSCTUNE+0 
;USART_test.c,102 :: 		ANSELA = 0;      // configure all PORTA pins as analog for data logging
	CLRF        ANSELA+0 
;USART_test.c,103 :: 		ANSELC = 0;         // configure all PORTC pins as digital
	CLRF        ANSELC+0 
;USART_test.c,104 :: 		ANSELD = 0;         // configure all PORTD pins as digital
	CLRF        ANSELD+0 
;USART_test.c,109 :: 		ADC_Init_Advanced(_ADC_INTERNAL_VREFL | _ADC_INTERNAL_FVRH1);
	MOVLW       24
	MOVWF       FARG_ADC_Init_Advanced_reference+0 
	CALL        _ADC_Init_Advanced+0, 0
;USART_test.c,110 :: 		delay_ms(1000);     // wait a second
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
;USART_test.c,112 :: 		logging_Init();
	CALL        _logging_Init+0, 0
;USART_test.c,114 :: 		UART1_Write_Text("Initialising I2C \n");
	MOVLW       ?lstr1_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,116 :: 		I2C2_Init(100000); //RTC running at 100kHz
	MOVLW       40
	MOVWF       SSP2ADD+0 
	CALL        _I2C2_Init+0, 0
;USART_test.c,118 :: 		UART1_Write_Text("I2C setup\n");
	MOVLW       ?lstr2_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,119 :: 		I2C2_Start();  // begin I2C communications
	CALL        _I2C2_Start+0, 0
;USART_test.c,120 :: 		I2C2_Wr(0xA0);      // writing address
	MOVLW       160
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,121 :: 		I2C2_Wr( 0 );
	CLRF        FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,122 :: 		I2C2_Wr( 0x80 );
	MOVLW       128
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,123 :: 		I2C2_Wr( 0 );
	CLRF        FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,136 :: 		UART1_Write_Text("year\n");
	MOVLW       ?lstr3_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,137 :: 		year = 10 * (Date[6] - '0') + Date[7] - '0';
	MOVLW       48
	SUBWF       _date+6, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        _date+7, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       48
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	MOVWF       _year+0 
	MOVF        R1, 0 
	MOVWF       _year+1 
;USART_test.c,139 :: 		yr = (year % 4) << 2;
	MOVLW       4
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _yr+0 
	RLCF        _yr+0, 1 
	BCF         _yr+0, 0 
	RLCF        _yr+0, 1 
	BCF         _yr+0, 0 
;USART_test.c,142 :: 		UART1_Write_Text("convert to BDC\n");
	MOVLW       ?lstr4_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,145 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
;USART_test.c,147 :: 		UART1_Write_Text("enable counting\n");
	MOVLW       ?lstr5_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,148 :: 		I2C2_Start();
	CALL        _I2C2_Start+0, 0
;USART_test.c,149 :: 		I2C2_Wr(0xA0);      // writing address
	MOVLW       160
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,150 :: 		I2C2_Wr( 0 );
	CLRF        FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,151 :: 		I2C2_Wr( 0 );       // enable counting
	CLRF        FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,152 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
;USART_test.c,163 :: 		while(1){
L_main1:
;USART_test.c,165 :: 		ReadADC_and_Log();
	CALL        _ReadADC_and_Log+0, 0
;USART_test.c,187 :: 		}
	GOTO        L_main1
;USART_test.c,188 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_ReadADC_and_Log:

;USART_test.c,190 :: 		void ReadADC_and_Log(){
;USART_test.c,196 :: 		UART1_Write_Text("ADC\n");
	MOVLW       ?lstr6_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,197 :: 		R0 = ADC_Get_Sample(0);
	CLRF        FARG_ADC_Get_Sample_channel+0 
	CALL        _ADC_Get_Sample+0, 0
	MOVF        R0, 0 
	MOVWF       ReadADC_and_Log_R0_L0+0 
	MOVF        R1, 0 
	MOVWF       ReadADC_and_Log_R0_L0+1 
;USART_test.c,198 :: 		R1 = ADC_Get_Sample(1);
	MOVLW       1
	MOVWF       FARG_ADC_Get_Sample_channel+0 
	CALL        _ADC_Get_Sample+0, 0
	MOVF        R0, 0 
	MOVWF       ReadADC_and_Log_R1_L0+0 
	MOVF        R1, 0 
	MOVWF       ReadADC_and_Log_R1_L0+1 
;USART_test.c,199 :: 		WordToStr(R0, R0_);
	MOVF        ReadADC_and_Log_R0_L0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        ReadADC_and_Log_R0_L0+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       ReadADC_and_Log_R0__L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(ReadADC_and_Log_R0__L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;USART_test.c,200 :: 		WordToStr(R1, R1_);
	MOVF        ReadADC_and_Log_R1_L0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        ReadADC_and_Log_R1_L0+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       ReadADC_and_Log_R1__L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(ReadADC_and_Log_R1__L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;USART_test.c,202 :: 		Delay_ms(1000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_ReadADC_and_Log3:
	DECFSZ      R13, 1, 1
	BRA         L_ReadADC_and_Log3
	DECFSZ      R12, 1, 1
	BRA         L_ReadADC_and_Log3
	DECFSZ      R11, 1, 1
	BRA         L_ReadADC_and_Log3
	NOP
;USART_test.c,204 :: 		UART1_Write_Text("RTC\n");
	MOVLW       ?lstr7_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr7_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,205 :: 		I2C2_Start();
	CALL        _I2C2_Start+0, 0
;USART_test.c,206 :: 		I2C2_Wr(0xA0);
	MOVLW       160
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,207 :: 		I2C2_Wr(0x2 );
	MOVLW       2
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,208 :: 		I2C2_Start();           // begin I2C communications
	CALL        _I2C2_Start+0, 0
;USART_test.c,209 :: 		I2C2_Wr(0xA1);      // addresses for reading
	MOVLW       161
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,210 :: 		UART1_Write_Text("read RTC\n");
	MOVLW       ?lstr8_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr8_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,212 :: 		rtc = read_RTC(0);//
	CLRF        FARG_read_RTC_address+0 
	CALL        _read_RTC+0, 0
	MOVF        R0, 0 
	MOVWF       _rtc+0 
;USART_test.c,213 :: 		UART1_Write_Text("update time\n");
	MOVLW       ?lstr9_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr9_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,214 :: 		Time[6] = rtc>> + '0';
	CLRF        _time+6 
;USART_test.c,215 :: 		UART1_Write_Text("write time\n");
	MOVLW       ?lstr10_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr10_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,216 :: 		UART1_Write_Text(Time);
	MOVLW       _time+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_time+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,267 :: 		UART1_Write_Text("log to SD\n");
	MOVLW       ?lstr11_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr11_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,270 :: 		fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
	MOVLW       ?lstr12_USART_test+0
	MOVWF       FARG_FAT32_Open_fn+0 
	MOVLW       hi_addr(?lstr12_USART_test+0)
	MOVWF       FARG_FAT32_Open_fn+1 
	MOVLW       4
	MOVWF       FARG_FAT32_Open_mode+0 
	CALL        _FAT32_Open+0, 0
	MOVF        R0, 0 
	MOVWF       _fileHandle+0 
;USART_test.c,272 :: 		UART1_Write_Text("\n");
	MOVLW       ?lstr13_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr13_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,273 :: 		UART1_Write_Text(R0_);
	MOVLW       ReadADC_and_Log_R0__L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(ReadADC_and_Log_R0__L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,274 :: 		UART1_Write_Text("\t");
	MOVLW       ?lstr14_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr14_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,275 :: 		UART1_Write_Text(R1_);
	MOVLW       ReadADC_and_Log_R1__L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(ReadADC_and_Log_R1__L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,277 :: 		i = FAT32_Write(fileHandle, "\r\n", 6);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Write_fHandle+0 
	MOVLW       ?lstr15_USART_test+0
	MOVWF       FARG_FAT32_Write_wrBuf+0 
	MOVLW       hi_addr(?lstr15_USART_test+0)
	MOVWF       FARG_FAT32_Write_wrBuf+1 
	MOVLW       6
	MOVWF       FARG_FAT32_Write_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Write_len+1 
	CALL        _FAT32_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,278 :: 		i = FAT32_Write(fileHandle, R0_, 6);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Write_fHandle+0 
	MOVLW       ReadADC_and_Log_R0__L0+0
	MOVWF       FARG_FAT32_Write_wrBuf+0 
	MOVLW       hi_addr(ReadADC_and_Log_R0__L0+0)
	MOVWF       FARG_FAT32_Write_wrBuf+1 
	MOVLW       6
	MOVWF       FARG_FAT32_Write_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Write_len+1 
	CALL        _FAT32_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,280 :: 		i = FAT32_Write(fileHandle, R1_, 6);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Write_fHandle+0 
	MOVLW       ReadADC_and_Log_R1__L0+0
	MOVWF       FARG_FAT32_Write_wrBuf+0 
	MOVLW       hi_addr(ReadADC_and_Log_R1__L0+0)
	MOVWF       FARG_FAT32_Write_wrBuf+1 
	MOVLW       6
	MOVWF       FARG_FAT32_Write_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Write_len+1 
	CALL        _FAT32_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,288 :: 		i = FAT32_Close(fileHandle);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Close_fHandle+0 
	CALL        _FAT32_Close+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,291 :: 		delay_ms(5000);     // wait 5 seconds
	MOVLW       102
	MOVWF       R11, 0
	MOVLW       118
	MOVWF       R12, 0
	MOVLW       193
	MOVWF       R13, 0
L_ReadADC_and_Log4:
	DECFSZ      R13, 1, 1
	BRA         L_ReadADC_and_Log4
	DECFSZ      R12, 1, 1
	BRA         L_ReadADC_and_Log4
	DECFSZ      R11, 1, 1
	BRA         L_ReadADC_and_Log4
;USART_test.c,292 :: 		}
L_end_ReadADC_and_Log:
	RETURN      0
; end of _ReadADC_and_Log

_logging_Init:

;USART_test.c,295 :: 		void logging_Init(){
;USART_test.c,297 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       2
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;USART_test.c,299 :: 		UART1_Init(9600);   // initialize UART1 module at 9600 baud
	BSF         BAUDCON+0, 3, 0
	MOVLW       1
	MOVWF       SPBRGH+0 
	MOVLW       160
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;USART_test.c,301 :: 		UART1_Write_Text("\r\n\nInitialize FAT library ... ");
	MOVLW       ?lstr16_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr16_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,302 :: 		delay_ms(1000);     // wait 2 secods
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_logging_Init5:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init5
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init5
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init5
	NOP
;USART_test.c,305 :: 		i = FAT32_Init();
	CALL        _FAT32_Init+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,306 :: 		if(i != 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_logging_Init6
;USART_test.c,308 :: 		UART1_Write_Text("Error initializing FAT library (SD card missing?)!");
	MOVLW       ?lstr17_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr17_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,309 :: 		}
	GOTO        L_logging_Init7
L_logging_Init6:
;USART_test.c,314 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	CLRF        FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;USART_test.c,315 :: 		UART1_Write_Text("FAT Library initialized");
	MOVLW       ?lstr18_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr18_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,316 :: 		delay_ms(1000);     // wait 2 seconds
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_logging_Init8:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init8
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init8
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init8
	NOP
;USART_test.c,330 :: 		UART1_Write_Text("\r\n\r\nWrite test code to file :  This_is_a_text_file_created_using_PIC18F46K22_microcontroller");
	MOVLW       ?lstr19_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr19_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,331 :: 		fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
	MOVLW       ?lstr20_USART_test+0
	MOVWF       FARG_FAT32_Open_fn+0 
	MOVLW       hi_addr(?lstr20_USART_test+0)
	MOVWF       FARG_FAT32_Open_fn+1 
	MOVLW       4
	MOVWF       FARG_FAT32_Open_mode+0 
	CALL        _FAT32_Open+0, 0
	MOVF        R0, 0 
	MOVWF       _fileHandle+0 
;USART_test.c,342 :: 		i = FAT32_Write(fileHandle, "\r\nThis_is_a_text_file_created_using_PIC18F46K22_microcontroller_and_mikroC_compiler.\r\n", 113);
	MOVF        R0, 0 
	MOVWF       FARG_FAT32_Write_fHandle+0 
	MOVLW       ?lstr21_USART_test+0
	MOVWF       FARG_FAT32_Write_wrBuf+0 
	MOVLW       hi_addr(?lstr21_USART_test+0)
	MOVWF       FARG_FAT32_Write_wrBuf+1 
	MOVLW       113
	MOVWF       FARG_FAT32_Write_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Write_len+1 
	CALL        _FAT32_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,350 :: 		delay_ms(1000);     // wait 2 seconds
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_logging_Init9:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init9
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init9
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init9
	NOP
;USART_test.c,353 :: 		i = FAT32_Close(fileHandle);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Close_fHandle+0 
	CALL        _FAT32_Close+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,363 :: 		UART1_Write_Text("\r\n\r\nReading first line of file:");
	MOVLW       ?lstr22_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr22_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,364 :: 		delay_ms(1000);     // wait 2 seconds
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_logging_Init10:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init10
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init10
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init10
	NOP
;USART_test.c,367 :: 		UART1_Write_Text("\r\nOpen file ... ");
	MOVLW       ?lstr23_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr23_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,368 :: 		fileHandle = FAT32_Open("Log.txt", FILE_READ);
	MOVLW       ?lstr24_USART_test+0
	MOVWF       FARG_FAT32_Open_fn+0 
	MOVLW       hi_addr(?lstr24_USART_test+0)
	MOVWF       FARG_FAT32_Open_fn+1 
	MOVLW       1
	MOVWF       FARG_FAT32_Open_mode+0 
	CALL        _FAT32_Open+0, 0
	MOVF        R0, 0 
	MOVWF       _fileHandle+0 
;USART_test.c,369 :: 		if(fileHandle != 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_logging_Init11
;USART_test.c,370 :: 		UART1_Write_Text("error opening file");
	MOVLW       ?lstr25_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr25_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	GOTO        L_logging_Init12
L_logging_Init11:
;USART_test.c,376 :: 		UART1_Write_Text("\r\nPrint file:\r\n\r");
	MOVLW       ?lstr26_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr26_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,377 :: 		delay_ms(1000);     // wait 2 seconds
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_logging_Init13:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init13
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init13
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init13
	NOP
;USART_test.c,379 :: 		FAT32_Read(fileHandle, buffer, 113);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Read_fHandle+0 
	MOVLW       _buffer+0
	MOVWF       FARG_FAT32_Read_rdBuf+0 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FARG_FAT32_Read_rdBuf+1 
	MOVLW       113
	MOVWF       FARG_FAT32_Read_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Read_len+1 
	CALL        _FAT32_Read+0, 0
;USART_test.c,381 :: 		UART1_Write_Text(buffer);
	MOVLW       _buffer+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,383 :: 		delay_ms(1000);     // wait 2 seconds
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_logging_Init14:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init14
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init14
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init14
	NOP
;USART_test.c,385 :: 		UART1_Write_Text("\r\n\r\nClosing the file ... ");
	MOVLW       ?lstr27_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr27_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,386 :: 		i = FAT32_Close(fileHandle);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Close_fHandle+0 
	CALL        _FAT32_Close+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,395 :: 		}
L_logging_Init12:
;USART_test.c,396 :: 		}
L_logging_Init7:
;USART_test.c,398 :: 		delay_ms(1000);     // wait 2 seconds
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_logging_Init15:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init15
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init15
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init15
	NOP
;USART_test.c,399 :: 		UART1_Write_Text("\r\n\r\n***** END OF INITIALISATION *****\r\n\r\n");
	MOVLW       ?lstr28_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr28_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,400 :: 		}
L_end_logging_Init:
	RETURN      0
; end of _logging_Init

_read_RTC:

;USART_test.c,403 :: 		unsigned short read_RTC(unsigned short address)
;USART_test.c,406 :: 		I2C2_Start();
	CALL        _I2C2_Start+0, 0
;USART_test.c,407 :: 		I2C2_Wr(0xA0); // Address for writing
	MOVLW       160
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,408 :: 		I2C2_Wr(address);
	MOVF        FARG_read_RTC_address+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,409 :: 		I2C2_Repeated_Start();
	CALL        _I2C2_Repeated_Start+0, 0
;USART_test.c,410 :: 		I2C2_Wr(0xA1); // Address for reading
	MOVLW       161
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,411 :: 		read_data=I2C2_Rd(0);
	CLRF        FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       read_RTC_read_data_L0+0 
;USART_test.c,412 :: 		I2C2_Stop();
	CALL        _I2C2_Stop+0, 0
;USART_test.c,413 :: 		return(read_data);
	MOVF        read_RTC_read_data_L0+0, 0 
	MOVWF       R0 
;USART_test.c,414 :: 		}
L_end_read_RTC:
	RETURN      0
; end of _read_RTC
