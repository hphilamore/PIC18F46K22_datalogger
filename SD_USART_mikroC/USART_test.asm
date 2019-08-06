
_main:

;USART_test.c,16 :: 		void main() {
;USART_test.c,18 :: 		OSCCON = 0b01110000;  // bit7: device enters SLEEP on sleep instruction[0]
	MOVLW       112
	MOVWF       OSCCON+0 
;USART_test.c,24 :: 		OSCTUNE = 0b00000000; // bit7:  device clock derived from the MFINTOSC or HFINTOSC source
	CLRF        OSCTUNE+0 
;USART_test.c,28 :: 		ANSELA = 0;      // configure all PORTA pins as analog for data logging
	CLRF        ANSELA+0 
;USART_test.c,29 :: 		ANSELC = 0;         // configure all PORTC pins as digital
	CLRF        ANSELC+0 
;USART_test.c,30 :: 		ANSELD = 0;         // configure all PORTD pins as digital
	CLRF        ANSELD+0 
;USART_test.c,33 :: 		ADC_Init_Advanced(_ADC_INTERNAL_VREFL | _ADC_INTERNAL_FVRH4);
	MOVLW       56
	MOVWF       FARG_ADC_Init_Advanced_reference+0 
	CALL        _ADC_Init_Advanced+0, 0
;USART_test.c,34 :: 		delay_ms(1000);     // wait a second
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
;USART_test.c,36 :: 		logging_Init();
	CALL        _logging_Init+0, 0
;USART_test.c,132 :: 		while(1){
L_main1:
;USART_test.c,138 :: 		R0 = ADC_Get_Sample(0);
	CLRF        FARG_ADC_Get_Sample_channel+0 
	CALL        _ADC_Get_Sample+0, 0
;USART_test.c,139 :: 		WordToStr(R0, R0_);
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       main_R0__L1+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(main_R0__L1+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;USART_test.c,141 :: 		Delay_ms(1000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
;USART_test.c,144 :: 		fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
	MOVLW       ?lstr1_USART_test+0
	MOVWF       FARG_FAT32_Open_fn+0 
	MOVLW       hi_addr(?lstr1_USART_test+0)
	MOVWF       FARG_FAT32_Open_fn+1 
	MOVLW       4
	MOVWF       FARG_FAT32_Open_mode+0 
	CALL        _FAT32_Open+0, 0
	MOVF        R0, 0 
	MOVWF       _fileHandle+0 
;USART_test.c,146 :: 		UART1_Write_Text(R0_);
	MOVLW       main_R0__L1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(main_R0__L1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,147 :: 		i = FAT32_Write(fileHandle, R0_, 6);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Write_fHandle+0 
	MOVLW       main_R0__L1+0
	MOVWF       FARG_FAT32_Write_wrBuf+0 
	MOVLW       hi_addr(main_R0__L1+0)
	MOVWF       FARG_FAT32_Write_wrBuf+1 
	MOVLW       6
	MOVWF       FARG_FAT32_Write_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Write_len+1 
	CALL        _FAT32_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,148 :: 		i = FAT32_Write(fileHandle, "\n", 6);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Write_fHandle+0 
	MOVLW       ?lstr2_USART_test+0
	MOVWF       FARG_FAT32_Write_wrBuf+0 
	MOVLW       hi_addr(?lstr2_USART_test+0)
	MOVWF       FARG_FAT32_Write_wrBuf+1 
	MOVLW       6
	MOVWF       FARG_FAT32_Write_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Write_len+1 
	CALL        _FAT32_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,149 :: 		if(i == 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
;USART_test.c,150 :: 		UART1_Write_Text("OK");
	MOVLW       ?lstr3_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	GOTO        L_main5
L_main4:
;USART_test.c,152 :: 		UART1_Write_Text("writing error");
	MOVLW       ?lstr4_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
L_main5:
;USART_test.c,155 :: 		i = FAT32_Close(fileHandle);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Close_fHandle+0 
	CALL        _FAT32_Close+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,159 :: 		}
	GOTO        L_main1
;USART_test.c,160 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_logging_Init:

;USART_test.c,162 :: 		void logging_Init(){
;USART_test.c,164 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       2
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;USART_test.c,166 :: 		UART1_Init(9600);   // initialize UART1 module at 9600 baud
	BSF         BAUDCON+0, 3, 0
	MOVLW       1
	MOVWF       SPBRGH+0 
	MOVLW       160
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;USART_test.c,168 :: 		UART1_Write_Text("\r\n\nInitialize FAT library ... ");
	MOVLW       ?lstr5_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,169 :: 		delay_ms(2000);     // wait 2 secods
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_logging_Init6:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init6
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init6
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init6
;USART_test.c,172 :: 		i = FAT32_Init();
	CALL        _FAT32_Init+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,173 :: 		if(i != 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_logging_Init7
;USART_test.c,175 :: 		UART1_Write_Text("Error initializing FAT library!");
	MOVLW       ?lstr6_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,176 :: 		}
	GOTO        L_logging_Init8
L_logging_Init7:
;USART_test.c,181 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	CLRF        FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;USART_test.c,182 :: 		UART1_Write_Text("FAT Library initialized");
	MOVLW       ?lstr7_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr7_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,183 :: 		delay_ms(2000);     // wait 2 seconds
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_logging_Init9:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init9
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init9
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init9
;USART_test.c,186 :: 		UART1_Write_Text("\r\n\r\nCreate 'Test Dir' folder ... ");
	MOVLW       ?lstr8_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr8_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,187 :: 		if(FAT32_MakeDir("Test Dir") == 0)
	MOVLW       ?lstr9_USART_test+0
	MOVWF       FARG_FAT32_MakeDir_dname+0 
	MOVLW       hi_addr(?lstr9_USART_test+0)
	MOVWF       FARG_FAT32_MakeDir_dname+1 
	CALL        _FAT32_MakeDir+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_logging_Init10
;USART_test.c,188 :: 		UART1_Write_Text("OK");
	MOVLW       ?lstr10_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr10_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	GOTO        L_logging_Init11
L_logging_Init10:
;USART_test.c,190 :: 		UART1_Write_Text("error creating folder");
	MOVLW       ?lstr11_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr11_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
L_logging_Init11:
;USART_test.c,192 :: 		delay_ms(2000);     // wait 2 seconds
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_logging_Init12:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init12
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init12
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init12
;USART_test.c,195 :: 		UART1_Write_Text("\r\n\r\nCreate 'Log.txt' file ... ");
	MOVLW       ?lstr12_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr12_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,196 :: 		fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
	MOVLW       ?lstr13_USART_test+0
	MOVWF       FARG_FAT32_Open_fn+0 
	MOVLW       hi_addr(?lstr13_USART_test+0)
	MOVWF       FARG_FAT32_Open_fn+1 
	MOVLW       4
	MOVWF       FARG_FAT32_Open_mode+0 
	CALL        _FAT32_Open+0, 0
	MOVF        R0, 0 
	MOVWF       _fileHandle+0 
;USART_test.c,197 :: 		if(fileHandle == 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_logging_Init13
;USART_test.c,198 :: 		UART1_Write_Text("OK");
	MOVLW       ?lstr14_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr14_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	GOTO        L_logging_Init14
L_logging_Init13:
;USART_test.c,200 :: 		UART1_Write_Text("error creating file or file already exists!");
	MOVLW       ?lstr15_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr15_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
L_logging_Init14:
;USART_test.c,202 :: 		delay_ms(2000);     // wait 2 seconds
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_logging_Init15:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init15
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init15
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init15
;USART_test.c,204 :: 		UART1_Write_Text("\r\nWriting to the text file 'Log.txt' ... ");
	MOVLW       ?lstr16_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr16_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,205 :: 		i = FAT32_Write(fileHandle, "Hello,\r\nThis is a text file created using PIC18F46K22 microcontroller and mikroC compiler.\r\nHave a nice day ...", 113);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Write_fHandle+0 
	MOVLW       ?lstr17_USART_test+0
	MOVWF       FARG_FAT32_Write_wrBuf+0 
	MOVLW       hi_addr(?lstr17_USART_test+0)
	MOVWF       FARG_FAT32_Write_wrBuf+1 
	MOVLW       113
	MOVWF       FARG_FAT32_Write_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Write_len+1 
	CALL        _FAT32_Write+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,206 :: 		if(i == 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_logging_Init16
;USART_test.c,207 :: 		UART1_Write_Text("OK");
	MOVLW       ?lstr18_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr18_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	GOTO        L_logging_Init17
L_logging_Init16:
;USART_test.c,209 :: 		UART1_Write_Text("writing error");
	MOVLW       ?lstr19_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr19_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
L_logging_Init17:
;USART_test.c,211 :: 		delay_ms(2000);     // wait 2 seconds
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_logging_Init18:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init18
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init18
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init18
;USART_test.c,213 :: 		UART1_Write_Text("\r\nClosing the file 'Log.txt' ... ");
	MOVLW       ?lstr20_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr20_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,214 :: 		i = FAT32_Close(fileHandle);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Close_fHandle+0 
	CALL        _FAT32_Close+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,215 :: 		if(i == 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_logging_Init19
;USART_test.c,216 :: 		UART1_Write_Text("OK");
	MOVLW       ?lstr21_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr21_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	GOTO        L_logging_Init20
L_logging_Init19:
;USART_test.c,218 :: 		UART1_Write_Text("closing error");
	MOVLW       ?lstr22_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr22_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
L_logging_Init20:
;USART_test.c,220 :: 		delay_ms(2000);     // wait 2 seconds
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
;USART_test.c,222 :: 		UART1_Write_Text("\r\n\r\nReading 'Log.txt' file:");
	MOVLW       ?lstr23_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr23_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,223 :: 		delay_ms(2000);     // wait 2 seconds
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_logging_Init22:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init22
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init22
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init22
;USART_test.c,226 :: 		UART1_Write_Text("\r\nOpen 'Log.txt' file ... ");
	MOVLW       ?lstr24_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr24_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,227 :: 		fileHandle = FAT32_Open("Log.txt", FILE_READ);
	MOVLW       ?lstr25_USART_test+0
	MOVWF       FARG_FAT32_Open_fn+0 
	MOVLW       hi_addr(?lstr25_USART_test+0)
	MOVWF       FARG_FAT32_Open_fn+1 
	MOVLW       1
	MOVWF       FARG_FAT32_Open_mode+0 
	CALL        _FAT32_Open+0, 0
	MOVF        R0, 0 
	MOVWF       _fileHandle+0 
;USART_test.c,228 :: 		if(fileHandle != 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_logging_Init23
;USART_test.c,229 :: 		UART1_Write_Text("error opening file");
	MOVLW       ?lstr26_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr26_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	GOTO        L_logging_Init24
L_logging_Init23:
;USART_test.c,232 :: 		UART1_Write_Text("OK");
	MOVLW       ?lstr27_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr27_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,233 :: 		delay_ms(2000);     // wait 2 seconds
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
;USART_test.c,235 :: 		UART1_Write_Text("\r\nPrint 'log.txt' file:\r\n\r");
	MOVLW       ?lstr28_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr28_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,236 :: 		delay_ms(2000);     // wait 2 seconds
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
;USART_test.c,238 :: 		FAT32_Read(fileHandle, buffer, 113);
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
;USART_test.c,240 :: 		UART1_Write_Text(buffer);
	MOVLW       _buffer+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,242 :: 		delay_ms(2000);     // wait 2 seconds
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_logging_Init27:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init27
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init27
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init27
;USART_test.c,244 :: 		UART1_Write_Text("\r\n\r\nClosing the file 'log.txt' ... ");
	MOVLW       ?lstr29_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr29_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,245 :: 		i = FAT32_Close(fileHandle);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Close_fHandle+0 
	CALL        _FAT32_Close+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,246 :: 		if(i == 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_logging_Init28
;USART_test.c,247 :: 		UART1_Write_Text("OK");
	MOVLW       ?lstr30_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr30_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	GOTO        L_logging_Init29
L_logging_Init28:
;USART_test.c,249 :: 		UART1_Write_Text("closing error");
	MOVLW       ?lstr31_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr31_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
L_logging_Init29:
;USART_test.c,250 :: 		}
L_logging_Init24:
;USART_test.c,251 :: 		}
L_logging_Init8:
;USART_test.c,253 :: 		delay_ms(2000);     // wait 2 seconds
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_logging_Init30:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init30
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init30
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init30
;USART_test.c,254 :: 		UART1_Write_Text("\r\n\r\n***** END *****");
	MOVLW       ?lstr32_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr32_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,255 :: 		}
L_end_logging_Init:
	RETURN      0
; end of _logging_Init
