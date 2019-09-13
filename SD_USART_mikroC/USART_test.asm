
_debounce:

;USART_test.c,61 :: 		char debounce ()
;USART_test.c,63 :: 		char i, count = 0;
	CLRF        debounce_count_L0+0 
;USART_test.c,64 :: 		for(i = 0; i < 5; i++)
	CLRF        R1 
L_debounce0:
	MOVLW       5
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_debounce1
;USART_test.c,66 :: 		if (button1 == 0)
	BTFSC       RA5_bit+0, BitPos(RA5_bit+0) 
	GOTO        L_debounce3
;USART_test.c,67 :: 		count++;
	INCF        debounce_count_L0+0, 1 
L_debounce3:
;USART_test.c,68 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_debounce4:
	DECFSZ      R13, 1, 1
	BRA         L_debounce4
	DECFSZ      R12, 1, 1
	BRA         L_debounce4
	NOP
	NOP
;USART_test.c,64 :: 		for(i = 0; i < 5; i++)
	INCF        R1, 1 
;USART_test.c,69 :: 		}
	GOTO        L_debounce0
L_debounce1:
;USART_test.c,70 :: 		if(count > 2)  return 1;
	MOVF        debounce_count_L0+0, 0 
	SUBLW       2
	BTFSC       STATUS+0, 0 
	GOTO        L_debounce5
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_debounce
L_debounce5:
;USART_test.c,71 :: 		else           return 0;
	CLRF        R0 
;USART_test.c,72 :: 		}
L_end_debounce:
	RETURN      0
; end of _debounce

_main:

;USART_test.c,83 :: 		void main() {
;USART_test.c,85 :: 		OSCCON = 0b01110000;  // bit7: device enters SLEEP on sleep instruction[0]
	MOVLW       112
	MOVWF       OSCCON+0 
;USART_test.c,91 :: 		OSCTUNE = 0b00000000; // bit7:  device clock derived from the MFINTOSC or HFINTOSC source
	CLRF        OSCTUNE+0 
;USART_test.c,100 :: 		ANSELA = 0;      // configure all PORTA pins as analog for data logging
	CLRF        ANSELA+0 
;USART_test.c,102 :: 		ANSELC = 0;      // configure all PORTC pins as analog
	CLRF        ANSELC+0 
;USART_test.c,103 :: 		ANSELD = 0;      // configure all PORTD pins as analog
	CLRF        ANSELD+0 
;USART_test.c,109 :: 		I2C2_Init(100000);   // initialize I2C bus with clock frequency of 100kHz
	MOVLW       40
	MOVWF       SSP2ADD+0 
	CALL        _I2C2_Init+0, 0
;USART_test.c,114 :: 		ADC_Init_Advanced(_ADC_INTERNAL_VREFL | _ADC_INTERNAL_FVRH1);
	MOVLW       24
	MOVWF       FARG_ADC_Init_Advanced_reference+0 
	CALL        _ADC_Init_Advanced+0, 0
;USART_test.c,115 :: 		delay_ms(1000);     // wait a second
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	DECFSZ      R11, 1, 1
	BRA         L_main7
	NOP
;USART_test.c,117 :: 		logging_Init();
	CALL        _logging_Init+0, 0
;USART_test.c,119 :: 		i = 0;
	CLRF        _i+0 
;USART_test.c,120 :: 		hour   = 1; //edit(7,  1, hour);
	MOVLW       1
	MOVWF       _hour+0 
;USART_test.c,121 :: 		minute = 2; //edit(10, 1, minute);
	MOVLW       2
	MOVWF       _minute+0 
;USART_test.c,122 :: 		m_day  = 3; //edit(7,  2, m_day);
	MOVLW       3
	MOVWF       _m_day+0 
;USART_test.c,123 :: 		month  = 4; //edit(10, 2, month);
	MOVLW       4
	MOVWF       _month+0 
;USART_test.c,124 :: 		year   = 5; //edit(15, 2, year);
	MOVLW       5
	MOVWF       _year+0 
;USART_test.c,126 :: 		while(debounce());  // call debounce function (wait for button B1 to be released)
L_main8:
	CALL        _debounce+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main9
	GOTO        L_main8
L_main9:
;USART_test.c,129 :: 		minute = decimal_to_bcd(minute);
	MOVF        _minute+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVF        R0, 0 
	MOVWF       _minute+0 
;USART_test.c,130 :: 		hour   = decimal_to_bcd(hour);
	MOVF        _hour+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVF        R0, 0 
	MOVWF       _hour+0 
;USART_test.c,131 :: 		m_day  = decimal_to_bcd(m_day);
	MOVF        _m_day+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVF        R0, 0 
	MOVWF       _m_day+0 
;USART_test.c,132 :: 		month  = decimal_to_bcd(month);
	MOVF        _month+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVF        R0, 0 
	MOVWF       _month+0 
;USART_test.c,133 :: 		year   = decimal_to_bcd(year);
	MOVF        _year+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVF        R0, 0 
	MOVWF       _year+0 
;USART_test.c,137 :: 		I2C2_Start();      // start I2C
	CALL        _I2C2_Start+0, 0
;USART_test.c,138 :: 		I2C2_Wr(0xD0);     // RTC chip address
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,139 :: 		I2C2_Wr(0);        // send register address
	CLRF        FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,140 :: 		I2C2_Wr(0);        // reset seconds and start oscillator
	CLRF        FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,141 :: 		I2C2_Wr(minute);   // write minute value to RTC chip
	MOVF        _minute+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,142 :: 		I2C2_Wr(hour);     // write hour value to RTC chip
	MOVF        _hour+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,143 :: 		I2C2_Wr(1);        // write day value (not used)
	MOVLW       1
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,144 :: 		I2C2_Wr(m_day);    // write date value to RTC chip
	MOVF        _m_day+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,145 :: 		I2C2_Wr(month);    // write month value to RTC chip
	MOVF        _month+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,146 :: 		I2C2_Wr(year);     // write year value to RTC chip
	MOVF        _year+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,147 :: 		I2C2_Stop();       // stop I2C
	CALL        _I2C2_Stop+0, 0
;USART_test.c,150 :: 		I2C2_Start();           // start I2C
	CALL        _I2C2_Start+0, 0
;USART_test.c,151 :: 		I2C2_Wr(0xD0);       // RTC chip address
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,152 :: 		I2C2_Wr(0);          // send register address
	CLRF        FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,154 :: 		I2C2_Repeated_Start();    // restart I2C
	CALL        _I2C2_Repeated_Start+0, 0
;USART_test.c,155 :: 		I2C2_Wr(0xD1);       // initialize data read
	MOVLW       209
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,157 :: 		second = tI2C2_Rd(1);  // read seconds from register 0
	MOVLW       1
	MOVWF       FARG_tI2C2_Rd_ack+0 
	CALL        _tI2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _second+0 
;USART_test.c,166 :: 		I2C_Stop();
	CALL        _I2C_Stop+0, 0
;USART_test.c,168 :: 		second = bcd_to_decimal(second);
	MOVF        _second+0, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _second+0 
;USART_test.c,169 :: 		UART1_Write_Text(second);
	MOVF        R0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       0
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,172 :: 		while(1){
L_main10:
;USART_test.c,174 :: 		ReadADC_and_Log();
	CALL        _ReadADC_and_Log+0, 0
;USART_test.c,196 :: 		}
	GOTO        L_main10
;USART_test.c,197 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_ReadADC_and_Log:

;USART_test.c,199 :: 		void ReadADC_and_Log(){
;USART_test.c,205 :: 		R0 = ADC_Get_Sample(0);
	CLRF        FARG_ADC_Get_Sample_channel+0 
	CALL        _ADC_Get_Sample+0, 0
	MOVF        R0, 0 
	MOVWF       ReadADC_and_Log_R0_L0+0 
	MOVF        R1, 0 
	MOVWF       ReadADC_and_Log_R0_L0+1 
;USART_test.c,206 :: 		R1 = ADC_Get_Sample(1);
	MOVLW       1
	MOVWF       FARG_ADC_Get_Sample_channel+0 
	CALL        _ADC_Get_Sample+0, 0
	MOVF        R0, 0 
	MOVWF       ReadADC_and_Log_R1_L0+0 
	MOVF        R1, 0 
	MOVWF       ReadADC_and_Log_R1_L0+1 
;USART_test.c,207 :: 		WordToStr(R0, R0_);
	MOVF        ReadADC_and_Log_R0_L0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        ReadADC_and_Log_R0_L0+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       ReadADC_and_Log_R0__L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(ReadADC_and_Log_R0__L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;USART_test.c,208 :: 		WordToStr(R1, R1_);
	MOVF        ReadADC_and_Log_R1_L0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        ReadADC_and_Log_R1_L0+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       ReadADC_and_Log_R1__L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(ReadADC_and_Log_R1__L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;USART_test.c,210 :: 		Delay_ms(1000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_ReadADC_and_Log12:
	DECFSZ      R13, 1, 1
	BRA         L_ReadADC_and_Log12
	DECFSZ      R12, 1, 1
	BRA         L_ReadADC_and_Log12
	DECFSZ      R11, 1, 1
	BRA         L_ReadADC_and_Log12
	NOP
;USART_test.c,214 :: 		fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
	MOVLW       ?lstr1_USART_test+0
	MOVWF       FARG_FAT32_Open_fn+0 
	MOVLW       hi_addr(?lstr1_USART_test+0)
	MOVWF       FARG_FAT32_Open_fn+1 
	MOVLW       4
	MOVWF       FARG_FAT32_Open_mode+0 
	CALL        _FAT32_Open+0, 0
	MOVF        R0, 0 
	MOVWF       _fileHandle+0 
;USART_test.c,216 :: 		UART1_Write_Text("\n");
	MOVLW       ?lstr2_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,217 :: 		UART1_Write_Text(R0_);
	MOVLW       ReadADC_and_Log_R0__L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(ReadADC_and_Log_R0__L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,218 :: 		UART1_Write_Text("\t");
	MOVLW       ?lstr3_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,219 :: 		UART1_Write_Text(R1_);
	MOVLW       ReadADC_and_Log_R1__L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(ReadADC_and_Log_R1__L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,221 :: 		j = FAT32_Write(fileHandle, "\r\n", 6);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Write_fHandle+0 
	MOVLW       ?lstr4_USART_test+0
	MOVWF       FARG_FAT32_Write_wrBuf+0 
	MOVLW       hi_addr(?lstr4_USART_test+0)
	MOVWF       FARG_FAT32_Write_wrBuf+1 
	MOVLW       6
	MOVWF       FARG_FAT32_Write_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Write_len+1 
	CALL        _FAT32_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _j+0 
;USART_test.c,222 :: 		j = FAT32_Write(fileHandle, R0_, 6);
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
	MOVWF       _j+0 
;USART_test.c,224 :: 		j = FAT32_Write(fileHandle, R1_, 6);
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
	MOVWF       _j+0 
;USART_test.c,231 :: 		j = FAT32_Close(fileHandle);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Close_fHandle+0 
	CALL        _FAT32_Close+0, 0
	MOVF        R0, 0 
	MOVWF       _j+0 
;USART_test.c,234 :: 		delay_ms(5000);     // wait 5 seconds
	MOVLW       102
	MOVWF       R11, 0
	MOVLW       118
	MOVWF       R12, 0
	MOVLW       193
	MOVWF       R13, 0
L_ReadADC_and_Log13:
	DECFSZ      R13, 1, 1
	BRA         L_ReadADC_and_Log13
	DECFSZ      R12, 1, 1
	BRA         L_ReadADC_and_Log13
	DECFSZ      R11, 1, 1
	BRA         L_ReadADC_and_Log13
;USART_test.c,235 :: 		}
L_end_ReadADC_and_Log:
	RETURN      0
; end of _ReadADC_and_Log

_logging_Init:

;USART_test.c,238 :: 		void logging_Init(){
;USART_test.c,240 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       2
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;USART_test.c,242 :: 		UART1_Init(9600);   // initialize UART1 module at 9600 baud
	BSF         BAUDCON+0, 3, 0
	MOVLW       1
	MOVWF       SPBRGH+0 
	MOVLW       160
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;USART_test.c,244 :: 		UART1_Write_Text("\r\n\nInitialize FAT library ... ");
	MOVLW       ?lstr5_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,245 :: 		delay_ms(1000);     // wait 2 secods
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
;USART_test.c,248 :: 		j = FAT32_Init();
	CALL        _FAT32_Init+0, 0
	MOVF        R0, 0 
	MOVWF       _j+0 
;USART_test.c,249 :: 		if(j != 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_logging_Init15
;USART_test.c,251 :: 		UART1_Write_Text("Error initializing FAT library (SD card missing?)!");
	MOVLW       ?lstr6_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,252 :: 		}
	GOTO        L_logging_Init16
L_logging_Init15:
;USART_test.c,257 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	CLRF        FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;USART_test.c,258 :: 		UART1_Write_Text("FAT Library initialized");
	MOVLW       ?lstr7_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr7_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,259 :: 		delay_ms(1000);     // wait 2 seconds
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_logging_Init17:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init17
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init17
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init17
	NOP
;USART_test.c,273 :: 		UART1_Write_Text("\r\n\r\nWrite test code to file :  This_is_a_text_file_created_using_PIC18F46K22_microcontroller");
	MOVLW       ?lstr8_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr8_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,274 :: 		fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
	MOVLW       ?lstr9_USART_test+0
	MOVWF       FARG_FAT32_Open_fn+0 
	MOVLW       hi_addr(?lstr9_USART_test+0)
	MOVWF       FARG_FAT32_Open_fn+1 
	MOVLW       4
	MOVWF       FARG_FAT32_Open_mode+0 
	CALL        _FAT32_Open+0, 0
	MOVF        R0, 0 
	MOVWF       _fileHandle+0 
;USART_test.c,285 :: 		j = FAT32_Write(fileHandle, "\r\nThis_is_a_text_file_created_using_PIC18F46K22_microcontroller_and_mikroC_compiler.\r\n", 113);
	MOVF        R0, 0 
	MOVWF       FARG_FAT32_Write_fHandle+0 
	MOVLW       ?lstr10_USART_test+0
	MOVWF       FARG_FAT32_Write_wrBuf+0 
	MOVLW       hi_addr(?lstr10_USART_test+0)
	MOVWF       FARG_FAT32_Write_wrBuf+1 
	MOVLW       113
	MOVWF       FARG_FAT32_Write_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Write_len+1 
	CALL        _FAT32_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _j+0 
;USART_test.c,293 :: 		delay_ms(1000);     // wait 2 seconds
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_logging_Init18:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init18
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init18
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init18
	NOP
;USART_test.c,296 :: 		j = FAT32_Close(fileHandle);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Close_fHandle+0 
	CALL        _FAT32_Close+0, 0
	MOVF        R0, 0 
	MOVWF       _j+0 
;USART_test.c,306 :: 		UART1_Write_Text("\r\n\r\nReading first line of file:");
	MOVLW       ?lstr11_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr11_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,307 :: 		delay_ms(1000);     // wait 2 seconds
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_logging_Init19:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init19
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init19
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init19
	NOP
;USART_test.c,310 :: 		UART1_Write_Text("\r\nOpen file ... ");
	MOVLW       ?lstr12_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr12_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,311 :: 		fileHandle = FAT32_Open("Log.txt", FILE_READ);
	MOVLW       ?lstr13_USART_test+0
	MOVWF       FARG_FAT32_Open_fn+0 
	MOVLW       hi_addr(?lstr13_USART_test+0)
	MOVWF       FARG_FAT32_Open_fn+1 
	MOVLW       1
	MOVWF       FARG_FAT32_Open_mode+0 
	CALL        _FAT32_Open+0, 0
	MOVF        R0, 0 
	MOVWF       _fileHandle+0 
;USART_test.c,312 :: 		if(fileHandle != 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_logging_Init20
;USART_test.c,313 :: 		UART1_Write_Text("error opening file");
	MOVLW       ?lstr14_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr14_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	GOTO        L_logging_Init21
L_logging_Init20:
;USART_test.c,319 :: 		UART1_Write_Text("\r\nPrint file:\r\n\r");
	MOVLW       ?lstr15_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr15_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,320 :: 		delay_ms(1000);     // wait 2 seconds
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_logging_Init22:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init22
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init22
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init22
	NOP
;USART_test.c,322 :: 		FAT32_Read(fileHandle, buffer, 113);
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
;USART_test.c,324 :: 		UART1_Write_Text(buffer);
	MOVLW       _buffer+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,326 :: 		delay_ms(1000);     // wait 2 seconds
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_logging_Init23:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init23
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init23
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init23
	NOP
;USART_test.c,328 :: 		UART1_Write_Text("\r\n\r\nClosing the file ... ");
	MOVLW       ?lstr16_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr16_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,329 :: 		j = FAT32_Close(fileHandle);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Close_fHandle+0 
	CALL        _FAT32_Close+0, 0
	MOVF        R0, 0 
	MOVWF       _j+0 
;USART_test.c,338 :: 		}
L_logging_Init21:
;USART_test.c,339 :: 		}
L_logging_Init16:
;USART_test.c,341 :: 		delay_ms(1000);     // wait 2 seconds
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_logging_Init24:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init24
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init24
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init24
	NOP
;USART_test.c,342 :: 		UART1_Write_Text("\r\n\r\n***** END OF INITIALISATION *****\r\n\r\n");
	MOVLW       ?lstr17_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr17_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,343 :: 		}
L_end_logging_Init:
	RETURN      0
; end of _logging_Init

_bcd_to_decimal:

;USART_test.c,350 :: 		uint8_t bcd_to_decimal(uint8_t number)
;USART_test.c,352 :: 		return((number >> 4) * 10 + (number & 0x0F));
	MOVF        FARG_bcd_to_decimal_number+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       FARG_bcd_to_decimal_number+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	ADDWF       R0, 1 
;USART_test.c,353 :: 		}
L_end_bcd_to_decimal:
	RETURN      0
; end of _bcd_to_decimal

_decimal_to_bcd:

;USART_test.c,357 :: 		uint8_t decimal_to_bcd(uint8_t number)
;USART_test.c,359 :: 		return(((number / 10) << 4) + (number % 10));
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_decimal_to_bcd_number+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__decimal_to_bcd+0 
	RLCF        FLOC__decimal_to_bcd+0, 1 
	BCF         FLOC__decimal_to_bcd+0, 0 
	RLCF        FLOC__decimal_to_bcd+0, 1 
	BCF         FLOC__decimal_to_bcd+0, 0 
	RLCF        FLOC__decimal_to_bcd+0, 1 
	BCF         FLOC__decimal_to_bcd+0, 0 
	RLCF        FLOC__decimal_to_bcd+0, 1 
	BCF         FLOC__decimal_to_bcd+0, 0 
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_decimal_to_bcd_number+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        FLOC__decimal_to_bcd+0, 0 
	ADDWF       R0, 1 
;USART_test.c,360 :: 		}
L_end_decimal_to_bcd:
	RETURN      0
; end of _decimal_to_bcd

_RTC_display:

;USART_test.c,363 :: 		void RTC_display()
;USART_test.c,366 :: 		second = bcd_to_decimal(second);
	MOVF        _second+0, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _second+0 
;USART_test.c,367 :: 		minute = bcd_to_decimal(minute);
	MOVF        _minute+0, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _minute+0 
;USART_test.c,368 :: 		hour   = bcd_to_decimal(hour);
	MOVF        _hour+0, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _hour+0 
;USART_test.c,369 :: 		m_day  = bcd_to_decimal(m_day);
	MOVF        _m_day+0, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _m_day+0 
;USART_test.c,370 :: 		month  = bcd_to_decimal(month);
	MOVF        _month+0, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _month+0 
;USART_test.c,371 :: 		year   = bcd_to_decimal(year);
	MOVF        _year+0, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _year+0 
;USART_test.c,401 :: 		}
L_end_RTC_display:
	RETURN      0
; end of _RTC_display

_delay:

;USART_test.c,406 :: 		void delay()
;USART_test.c,408 :: 		TMR1H = TMR1L = 0;   // reset Timer1
	CLRF        TMR1L+0 
	MOVF        TMR1L+0, 0 
	MOVWF       TMR1H+0 
;USART_test.c,409 :: 		TMR1ON_bit    = 1;   // enable Timer1 module
	BSF         TMR1ON_bit+0, BitPos(TMR1ON_bit+0) 
;USART_test.c,411 :: 		while ( ((unsigned)(TMR1H << 8) | TMR1L) < 62500 && button1 && button2) ;
L_delay25:
	MOVF        TMR1H+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        TMR1L+0, 0 
	IORWF       R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVLW       0
	IORWF       R3, 1 
	MOVLW       244
	SUBWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delay82
	MOVLW       36
	SUBWF       R2, 0 
L__delay82:
	BTFSC       STATUS+0, 0 
	GOTO        L_delay26
	BTFSS       RA5_bit+0, BitPos(RA5_bit+0) 
	GOTO        L_delay26
	BTFSS       RA4_bit+0, BitPos(RA4_bit+0) 
	GOTO        L_delay26
L__delay66:
	GOTO        L_delay25
L_delay26:
;USART_test.c,412 :: 		TMR1ON_bit = 0;         // disable Timer1 module
	BCF         TMR1ON_bit+0, BitPos(TMR1ON_bit+0) 
;USART_test.c,413 :: 		}
L_end_delay:
	RETURN      0
; end of _delay

_edit:

;USART_test.c,418 :: 		char edit(char x, char y, char parameter)
;USART_test.c,420 :: 		while(debounce());  // call debounce function (wait for B1 to be released)
L_edit29:
	CALL        _debounce+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_edit30
	GOTO        L_edit29
L_edit30:
;USART_test.c,422 :: 		while(1) {
L_edit31:
;USART_test.c,424 :: 		while(!button2)    // if button B2 is pressed
L_edit33:
	BTFSC       RA4_bit+0, BitPos(RA4_bit+0) 
	GOTO        L_edit34
;USART_test.c,426 :: 		parameter++;
	INCF        FARG_edit_parameter+0, 1 
;USART_test.c,427 :: 		if(i == 0 && parameter > 23)   // if hours > 23 ==> hours = 0
	MOVF        _i+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_edit37
	MOVF        FARG_edit_parameter+0, 0 
	SUBLW       23
	BTFSC       STATUS+0, 0 
	GOTO        L_edit37
L__edit71:
;USART_test.c,428 :: 		parameter = 0;
	CLRF        FARG_edit_parameter+0 
L_edit37:
;USART_test.c,429 :: 		if(i == 1 && parameter > 59)   // if minutes > 59 ==> minutes = 0
	MOVF        _i+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_edit40
	MOVF        FARG_edit_parameter+0, 0 
	SUBLW       59
	BTFSC       STATUS+0, 0 
	GOTO        L_edit40
L__edit70:
;USART_test.c,430 :: 		parameter = 0;
	CLRF        FARG_edit_parameter+0 
L_edit40:
;USART_test.c,431 :: 		if(i == 2 && parameter > 31)   // if date > 31 ==> date = 1
	MOVF        _i+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_edit43
	MOVF        FARG_edit_parameter+0, 0 
	SUBLW       31
	BTFSC       STATUS+0, 0 
	GOTO        L_edit43
L__edit69:
;USART_test.c,432 :: 		parameter = 1;
	MOVLW       1
	MOVWF       FARG_edit_parameter+0 
L_edit43:
;USART_test.c,433 :: 		if(i == 3 && parameter > 12)   // if month > 12 ==> month = 1
	MOVF        _i+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_edit46
	MOVF        FARG_edit_parameter+0, 0 
	SUBLW       12
	BTFSC       STATUS+0, 0 
	GOTO        L_edit46
L__edit68:
;USART_test.c,434 :: 		parameter = 1;
	MOVLW       1
	MOVWF       FARG_edit_parameter+0 
L_edit46:
;USART_test.c,435 :: 		if(i == 4 && parameter > 99)   // if year > 99 ==> year = 0
	MOVF        _i+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_edit49
	MOVF        FARG_edit_parameter+0, 0 
	SUBLW       99
	BTFSC       STATUS+0, 0 
	GOTO        L_edit49
L__edit67:
;USART_test.c,436 :: 		parameter = 0;
	CLRF        FARG_edit_parameter+0 
L_edit49:
;USART_test.c,445 :: 		}
	GOTO        L_edit33
L_edit34:
;USART_test.c,458 :: 		if(!button1)     // if button B1 is pressed
	BTFSC       RA5_bit+0, BitPos(RA5_bit+0) 
	GOTO        L_edit50
;USART_test.c,459 :: 		if(debounce())   // call debounce function (make sure B1 is pressed)
	CALL        _debounce+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_edit51
;USART_test.c,461 :: 		i++;   // increment 'i' for the next parameter
	INCF        _i+0, 1 
;USART_test.c,462 :: 		return parameter;     // return parameter value and exit
	MOVF        FARG_edit_parameter+0, 0 
	MOVWF       R0 
	GOTO        L_end_edit
;USART_test.c,463 :: 		}
L_edit51:
L_edit50:
;USART_test.c,465 :: 		}
	GOTO        L_edit31
;USART_test.c,467 :: 		}
L_end_edit:
	RETURN      0
; end of _edit

_tI2C2_Rd:

;USART_test.c,472 :: 		unsigned short tI2C2_Rd(unsigned short ack) {
;USART_test.c,474 :: 		unsigned short d = 0;
	CLRF        tI2C2_Rd_d_L0+0 
	MOVLW       100
	MOVWF       tI2C2_Rd_max_retry_L0+0 
	MOVLW       0
	MOVWF       tI2C2_Rd_max_retry_L0+1 
;USART_test.c,479 :: 		if (max_retry == 0)
	MOVLW       0
	XORWF       tI2C2_Rd_max_retry_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__tI2C2_Rd85
	MOVLW       0
	XORWF       tI2C2_Rd_max_retry_L0+0, 0 
L__tI2C2_Rd85:
	BTFSS       STATUS+0, 2 
	GOTO        L_tI2C2_Rd52
;USART_test.c,480 :: 		max_retry = 1;
	MOVLW       1
	MOVWF       tI2C2_Rd_max_retry_L0+0 
	MOVLW       0
	MOVWF       tI2C2_Rd_max_retry_L0+1 
L_tI2C2_Rd52:
;USART_test.c,486 :: 		PIR1.SSP1IF = 0;
	BCF         PIR1+0, 3 
;USART_test.c,492 :: 		SSP1CON2.RCEN = 1;
	BSF         SSP1CON2+0, 3 
;USART_test.c,498 :: 		retry = max_retry;
	MOVF        tI2C2_Rd_max_retry_L0+0, 0 
	MOVWF       R1 
	MOVF        tI2C2_Rd_max_retry_L0+1, 0 
	MOVWF       R2 
;USART_test.c,499 :: 		while (PIR1.SSP1IF == 0 && --retry > 0)
L_tI2C2_Rd53:
	BTFSC       PIR1+0, 3 
	GOTO        L_tI2C2_Rd54
	MOVLW       1
	SUBWF       R1, 1 
	MOVLW       0
	SUBWFB      R2, 1 
	MOVLW       0
	MOVWF       R0 
	MOVF        R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__tI2C2_Rd86
	MOVF        R1, 0 
	SUBLW       0
L__tI2C2_Rd86:
	BTFSC       STATUS+0, 0 
	GOTO        L_tI2C2_Rd54
L__tI2C2_Rd73:
;USART_test.c,500 :: 		delay_us(delay);
	MOVLW       2
	MOVWF       R13, 0
L_tI2C2_Rd57:
	DECFSZ      R13, 1, 1
	BRA         L_tI2C2_Rd57
	NOP
	GOTO        L_tI2C2_Rd53
L_tI2C2_Rd54:
;USART_test.c,503 :: 		if (PIR1.SSP1IF == 0)
	BTFSC       PIR1+0, 3 
	GOTO        L_tI2C2_Rd58
;USART_test.c,504 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_tI2C2_Rd
L_tI2C2_Rd58:
;USART_test.c,507 :: 		d = (unsigned short)SSPBUF;
	MOVF        SSPBUF+0, 0 
	MOVWF       tI2C2_Rd_d_L0+0 
;USART_test.c,510 :: 		if (ack == 0) {
	MOVF        FARG_tI2C2_Rd_ack+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_tI2C2_Rd59
;USART_test.c,515 :: 		SSP1CON2.ACKDT = 1;
	BSF         SSP1CON2+0, 5 
;USART_test.c,516 :: 		} else {
	GOTO        L_tI2C2_Rd60
L_tI2C2_Rd59:
;USART_test.c,518 :: 		SSP1CON2.ACKDT = 0;
	BCF         SSP1CON2+0, 5 
;USART_test.c,519 :: 		}
L_tI2C2_Rd60:
;USART_test.c,525 :: 		PIR1.SSP1IF = 0;
	BCF         PIR1+0, 3 
;USART_test.c,531 :: 		SSP1CON2.ACKEN = 1;
	BSF         SSP1CON2+0, 4 
;USART_test.c,534 :: 		retry = max_retry;
	MOVF        tI2C2_Rd_max_retry_L0+0, 0 
	MOVWF       R1 
	MOVF        tI2C2_Rd_max_retry_L0+1, 0 
	MOVWF       R2 
;USART_test.c,535 :: 		while (PIR1.SSP1IF == 0 && --retry > 0)
L_tI2C2_Rd61:
	BTFSC       PIR1+0, 3 
	GOTO        L_tI2C2_Rd62
	MOVLW       1
	SUBWF       R1, 1 
	MOVLW       0
	SUBWFB      R2, 1 
	MOVLW       0
	MOVWF       R0 
	MOVF        R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__tI2C2_Rd87
	MOVF        R1, 0 
	SUBLW       0
L__tI2C2_Rd87:
	BTFSC       STATUS+0, 0 
	GOTO        L_tI2C2_Rd62
L__tI2C2_Rd72:
;USART_test.c,536 :: 		delay_us(delay);
	MOVLW       2
	MOVWF       R13, 0
L_tI2C2_Rd65:
	DECFSZ      R13, 1, 1
	BRA         L_tI2C2_Rd65
	NOP
	GOTO        L_tI2C2_Rd61
L_tI2C2_Rd62:
;USART_test.c,538 :: 		return d;
	MOVF        tI2C2_Rd_d_L0+0, 0 
	MOVWF       R0 
;USART_test.c,539 :: 		}
L_end_tI2C2_Rd:
	RETURN      0
; end of _tI2C2_Rd
