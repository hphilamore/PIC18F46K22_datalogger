
_main:

;USART_test.c,17 :: 		void main() {
;USART_test.c,19 :: 		OSCCON = 0b01110000;  // bit7: device enters SLEEP on sleep instruction[0]
	MOVLW       112
	MOVWF       OSCCON+0 
;USART_test.c,25 :: 		OSCTUNE = 0b00000000; // bit7:  device clock derived from the MFINTOSC or HFINTOSC source
	CLRF        OSCTUNE+0 
;USART_test.c,29 :: 		ANSELA = 0;      // configure all PORTA pins as analog for data logging
	CLRF        ANSELA+0 
;USART_test.c,30 :: 		ANSELC = 0;         // configure all PORTC pins as digital
	CLRF        ANSELC+0 
;USART_test.c,31 :: 		ANSELD = 0;         // configure all PORTD pins as digital
	CLRF        ANSELD+0 
;USART_test.c,36 :: 		ADC_Init_Advanced(_ADC_INTERNAL_VREFL | _ADC_INTERNAL_FVRH1);
	MOVLW       24
	MOVWF       FARG_ADC_Init_Advanced_reference+0 
	CALL        _ADC_Init_Advanced+0, 0
;USART_test.c,37 :: 		delay_ms(1000);     // wait a second
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
;USART_test.c,39 :: 		logging_Init();
	CALL        _logging_Init+0, 0
;USART_test.c,42 :: 		while(1){
L_main1:
;USART_test.c,44 :: 		ReadADC_and_Log();
	CALL        _ReadADC_and_Log+0, 0
;USART_test.c,66 :: 		}
	GOTO        L_main1
;USART_test.c,67 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_ReadADC_and_Log:

;USART_test.c,69 :: 		void ReadADC_and_Log(){
;USART_test.c,75 :: 		R0 = ADC_Get_Sample(0);
	CLRF        FARG_ADC_Get_Sample_channel+0 
	CALL        _ADC_Get_Sample+0, 0
	MOVF        R0, 0 
	MOVWF       ReadADC_and_Log_R0_L0+0 
	MOVF        R1, 0 
	MOVWF       ReadADC_and_Log_R0_L0+1 
;USART_test.c,76 :: 		R1 = ADC_Get_Sample(1);
	MOVLW       1
	MOVWF       FARG_ADC_Get_Sample_channel+0 
	CALL        _ADC_Get_Sample+0, 0
	MOVF        R0, 0 
	MOVWF       ReadADC_and_Log_R1_L0+0 
	MOVF        R1, 0 
	MOVWF       ReadADC_and_Log_R1_L0+1 
;USART_test.c,77 :: 		WordToStr(R0, R0_);
	MOVF        ReadADC_and_Log_R0_L0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        ReadADC_and_Log_R0_L0+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       ReadADC_and_Log_R0__L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(ReadADC_and_Log_R0__L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;USART_test.c,78 :: 		WordToStr(R1, R1_);
	MOVF        ReadADC_and_Log_R1_L0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        ReadADC_and_Log_R1_L0+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       ReadADC_and_Log_R1__L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(ReadADC_and_Log_R1__L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;USART_test.c,80 :: 		Delay_ms(1000);
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
;USART_test.c,83 :: 		fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
	MOVLW       ?lstr1_USART_test+0
	MOVWF       FARG_FAT32_Open_fn+0 
	MOVLW       hi_addr(?lstr1_USART_test+0)
	MOVWF       FARG_FAT32_Open_fn+1 
	MOVLW       4
	MOVWF       FARG_FAT32_Open_mode+0 
	CALL        _FAT32_Open+0, 0
	MOVF        R0, 0 
	MOVWF       _fileHandle+0 
;USART_test.c,85 :: 		UART1_Write_Text(R0_);
	MOVLW       ReadADC_and_Log_R0__L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(ReadADC_and_Log_R0__L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,86 :: 		UART1_Write_Text("\t");
	MOVLW       ?lstr2_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,87 :: 		UART1_Write_Text(R1_);
	MOVLW       ReadADC_and_Log_R1__L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(ReadADC_and_Log_R1__L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,88 :: 		UART1_Write_Text("\n");
	MOVLW       ?lstr3_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,89 :: 		i = FAT32_Write(fileHandle, R0_, 6);
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
;USART_test.c,90 :: 		i = FAT32_Write(fileHandle, "\t", 6);
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
	MOVWF       _i+0 
;USART_test.c,91 :: 		i = FAT32_Write(fileHandle, R1_, 6);
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
;USART_test.c,92 :: 		i = FAT32_Write(fileHandle, "\n", 6);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Write_fHandle+0 
	MOVLW       ?lstr5_USART_test+0
	MOVWF       FARG_FAT32_Write_wrBuf+0 
	MOVLW       hi_addr(?lstr5_USART_test+0)
	MOVWF       FARG_FAT32_Write_wrBuf+1 
	MOVLW       6
	MOVWF       FARG_FAT32_Write_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Write_len+1 
	CALL        _FAT32_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,93 :: 		if(i != 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_ReadADC_and_Log4
;USART_test.c,94 :: 		UART1_Write_Text("writing error");
	MOVLW       ?lstr6_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
L_ReadADC_and_Log4:
;USART_test.c,98 :: 		i = FAT32_Close(fileHandle);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Close_fHandle+0 
	CALL        _FAT32_Close+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,99 :: 		}
L_end_ReadADC_and_Log:
	RETURN      0
; end of _ReadADC_and_Log

_logging_Init:

;USART_test.c,102 :: 		void logging_Init(){
;USART_test.c,104 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       2
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;USART_test.c,106 :: 		UART1_Init(9600);   // initialize UART1 module at 9600 baud
	BSF         BAUDCON+0, 3, 0
	MOVLW       1
	MOVWF       SPBRGH+0 
	MOVLW       160
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;USART_test.c,108 :: 		UART1_Write_Text("\r\n\nInitialize FAT library ... ");
	MOVLW       ?lstr7_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr7_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,109 :: 		delay_ms(2000);     // wait 2 secods
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_logging_Init5:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init5
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init5
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init5
;USART_test.c,112 :: 		i = FAT32_Init();
	CALL        _FAT32_Init+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,113 :: 		if(i != 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_logging_Init6
;USART_test.c,115 :: 		UART1_Write_Text("Error initializing FAT library!");
	MOVLW       ?lstr8_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr8_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,116 :: 		}
	GOTO        L_logging_Init7
L_logging_Init6:
;USART_test.c,121 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	CLRF        FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;USART_test.c,122 :: 		UART1_Write_Text("FAT Library initialized");
	MOVLW       ?lstr9_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr9_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,123 :: 		delay_ms(2000);     // wait 2 seconds
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_logging_Init8:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init8
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init8
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init8
;USART_test.c,126 :: 		UART1_Write_Text("\r\n\r\nCreate 'Test Dir' folder ... ");
	MOVLW       ?lstr10_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr10_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,127 :: 		if(FAT32_MakeDir("Test Dir") == 0)
	MOVLW       ?lstr11_USART_test+0
	MOVWF       FARG_FAT32_MakeDir_dname+0 
	MOVLW       hi_addr(?lstr11_USART_test+0)
	MOVWF       FARG_FAT32_MakeDir_dname+1 
	CALL        _FAT32_MakeDir+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_logging_Init9
;USART_test.c,128 :: 		UART1_Write_Text("OK");
	MOVLW       ?lstr12_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr12_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	GOTO        L_logging_Init10
L_logging_Init9:
;USART_test.c,130 :: 		UART1_Write_Text("error creating folder");
	MOVLW       ?lstr13_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr13_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
L_logging_Init10:
;USART_test.c,132 :: 		delay_ms(2000);     // wait 2 seconds
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_logging_Init11:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init11
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init11
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init11
;USART_test.c,135 :: 		UART1_Write_Text("\r\n\r\nCreate 'Log.txt' file ... ");
	MOVLW       ?lstr14_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr14_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,136 :: 		fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
	MOVLW       ?lstr15_USART_test+0
	MOVWF       FARG_FAT32_Open_fn+0 
	MOVLW       hi_addr(?lstr15_USART_test+0)
	MOVWF       FARG_FAT32_Open_fn+1 
	MOVLW       4
	MOVWF       FARG_FAT32_Open_mode+0 
	CALL        _FAT32_Open+0, 0
	MOVF        R0, 0 
	MOVWF       _fileHandle+0 
;USART_test.c,137 :: 		if(fileHandle == 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_logging_Init12
;USART_test.c,138 :: 		UART1_Write_Text("OK");
	MOVLW       ?lstr16_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr16_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	GOTO        L_logging_Init13
L_logging_Init12:
;USART_test.c,140 :: 		UART1_Write_Text("error creating file or file already exists!");
	MOVLW       ?lstr17_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr17_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
L_logging_Init13:
;USART_test.c,142 :: 		delay_ms(2000);     // wait 2 seconds
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_logging_Init14:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init14
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init14
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init14
;USART_test.c,144 :: 		UART1_Write_Text("\r\nWriting to the text file 'Log.txt' ... ");
	MOVLW       ?lstr18_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr18_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,145 :: 		i = FAT32_Write(fileHandle, "This is a text file created using PIC18F46K22 microcontroller and mikroC compiler.\r\n", 113);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Write_fHandle+0 
	MOVLW       ?lstr19_USART_test+0
	MOVWF       FARG_FAT32_Write_wrBuf+0 
	MOVLW       hi_addr(?lstr19_USART_test+0)
	MOVWF       FARG_FAT32_Write_wrBuf+1 
	MOVLW       113
	MOVWF       FARG_FAT32_Write_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Write_len+1 
	CALL        _FAT32_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,147 :: 		if(i == 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_logging_Init15
;USART_test.c,148 :: 		UART1_Write_Text("OK");
	MOVLW       ?lstr20_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr20_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	GOTO        L_logging_Init16
L_logging_Init15:
;USART_test.c,150 :: 		UART1_Write_Text("writing error");
	MOVLW       ?lstr21_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr21_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
L_logging_Init16:
;USART_test.c,152 :: 		delay_ms(2000);     // wait 2 seconds
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_logging_Init17:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init17
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init17
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init17
;USART_test.c,154 :: 		UART1_Write_Text("\r\nClosing the file 'Log.txt' ... ");
	MOVLW       ?lstr22_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr22_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,155 :: 		i = FAT32_Close(fileHandle);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Close_fHandle+0 
	CALL        _FAT32_Close+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,156 :: 		if(i == 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_logging_Init18
;USART_test.c,157 :: 		UART1_Write_Text("OK");
	MOVLW       ?lstr23_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr23_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	GOTO        L_logging_Init19
L_logging_Init18:
;USART_test.c,159 :: 		UART1_Write_Text("closing error");
	MOVLW       ?lstr24_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr24_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
L_logging_Init19:
;USART_test.c,161 :: 		delay_ms(2000);     // wait 2 seconds
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_logging_Init20:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init20
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init20
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init20
;USART_test.c,163 :: 		UART1_Write_Text("\r\n\r\nReading 'Log.txt' file:");
	MOVLW       ?lstr25_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr25_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,164 :: 		delay_ms(2000);     // wait 2 seconds
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_logging_Init21:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init21
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init21
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init21
;USART_test.c,167 :: 		UART1_Write_Text("\r\nOpen 'Log.txt' file ... ");
	MOVLW       ?lstr26_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr26_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,168 :: 		fileHandle = FAT32_Open("Log.txt", FILE_READ);
	MOVLW       ?lstr27_USART_test+0
	MOVWF       FARG_FAT32_Open_fn+0 
	MOVLW       hi_addr(?lstr27_USART_test+0)
	MOVWF       FARG_FAT32_Open_fn+1 
	MOVLW       1
	MOVWF       FARG_FAT32_Open_mode+0 
	CALL        _FAT32_Open+0, 0
	MOVF        R0, 0 
	MOVWF       _fileHandle+0 
;USART_test.c,169 :: 		if(fileHandle != 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_logging_Init22
;USART_test.c,170 :: 		UART1_Write_Text("error opening file");
	MOVLW       ?lstr28_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr28_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	GOTO        L_logging_Init23
L_logging_Init22:
;USART_test.c,173 :: 		UART1_Write_Text("OK");
	MOVLW       ?lstr29_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr29_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,174 :: 		delay_ms(2000);     // wait 2 seconds
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_logging_Init24:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init24
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init24
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init24
;USART_test.c,176 :: 		UART1_Write_Text("\r\nPrint 'log.txt' file:\r\n\r");
	MOVLW       ?lstr30_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr30_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,177 :: 		delay_ms(2000);     // wait 2 seconds
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_logging_Init25:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init25
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init25
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init25
;USART_test.c,179 :: 		FAT32_Read(fileHandle, buffer, 113);
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
;USART_test.c,181 :: 		UART1_Write_Text(buffer);
	MOVLW       _buffer+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,183 :: 		delay_ms(2000);     // wait 2 seconds
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_logging_Init26:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init26
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init26
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init26
;USART_test.c,185 :: 		UART1_Write_Text("\r\n\r\nClosing the file 'log.txt' ... ");
	MOVLW       ?lstr31_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr31_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,186 :: 		i = FAT32_Close(fileHandle);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Close_fHandle+0 
	CALL        _FAT32_Close+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,187 :: 		if(i == 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_logging_Init27
;USART_test.c,188 :: 		UART1_Write_Text("OK");
	MOVLW       ?lstr32_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr32_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	GOTO        L_logging_Init28
L_logging_Init27:
;USART_test.c,190 :: 		UART1_Write_Text("closing error");
	MOVLW       ?lstr33_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr33_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
L_logging_Init28:
;USART_test.c,191 :: 		}
L_logging_Init23:
;USART_test.c,192 :: 		}
L_logging_Init7:
;USART_test.c,194 :: 		delay_ms(2000);     // wait 2 seconds
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_logging_Init29:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init29
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init29
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init29
;USART_test.c,195 :: 		UART1_Write_Text("\r\n\r\n***** END *****\r\n\r\n");
	MOVLW       ?lstr34_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr34_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,196 :: 		}
L_end_logging_Init:
	RETURN      0
; end of _logging_Init
