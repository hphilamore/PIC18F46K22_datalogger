
_UART1_Write_CText:

;USART_test5.c,45 :: 		void UART1_Write_CText(const char *txt1)
;USART_test5.c,47 :: 		while (*txt1)
L_UART1_Write_CText0:
	MOVF        FARG_UART1_Write_CText_txt1+0, 0 
	MOVWF       TBLPTRL+0 
	MOVF        FARG_UART1_Write_CText_txt1+1, 0 
	MOVWF       TBLPTRH+0 
	MOVF        FARG_UART1_Write_CText_txt1+2, 0 
	MOVWF       TBLPTRU+0 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_UART1_Write_CText1
;USART_test5.c,48 :: 		UART1_Write(*txt1++);
	MOVF        FARG_UART1_Write_CText_txt1+0, 0 
	MOVWF       TBLPTRL+0 
	MOVF        FARG_UART1_Write_CText_txt1+1, 0 
	MOVWF       TBLPTRH+0 
	MOVF        FARG_UART1_Write_CText_txt1+2, 0 
	MOVWF       TBLPTRU+0 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_UART1_Write_data_+0
	CALL        _UART1_Write+0, 0
	MOVLW       1
	ADDWF       FARG_UART1_Write_CText_txt1+0, 1 
	MOVLW       0
	ADDWFC      FARG_UART1_Write_CText_txt1+1, 1 
	ADDWFC      FARG_UART1_Write_CText_txt1+2, 1 
	GOTO        L_UART1_Write_CText0
L_UART1_Write_CText1:
;USART_test5.c,49 :: 		}
L_end_UART1_Write_CText:
	RETURN      0
; end of _UART1_Write_CText

_strConstRamCpy:

;USART_test5.c,52 :: 		void strConstRamCpy(char *dest, const char *source) {
;USART_test5.c,53 :: 		while(*source) *dest++ = *source++ ;
L_strConstRamCpy2:
	MOVF        FARG_strConstRamCpy_source+0, 0 
	MOVWF       TBLPTRL+0 
	MOVF        FARG_strConstRamCpy_source+1, 0 
	MOVWF       TBLPTRH+0 
	MOVF        FARG_strConstRamCpy_source+2, 0 
	MOVWF       TBLPTRU+0 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_strConstRamCpy3
	MOVF        FARG_strConstRamCpy_source+0, 0 
	MOVWF       TBLPTRL+0 
	MOVF        FARG_strConstRamCpy_source+1, 0 
	MOVWF       TBLPTRH+0 
	MOVF        FARG_strConstRamCpy_source+2, 0 
	MOVWF       TBLPTRU+0 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVFF       FARG_strConstRamCpy_dest+0, FSR1L+0
	MOVFF       FARG_strConstRamCpy_dest+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_strConstRamCpy_dest+0, 1 
	INCF        FARG_strConstRamCpy_dest+1, 1 
	MOVLW       1
	ADDWF       FARG_strConstRamCpy_source+0, 1 
	MOVLW       0
	ADDWFC      FARG_strConstRamCpy_source+1, 1 
	ADDWFC      FARG_strConstRamCpy_source+2, 1 
	GOTO        L_strConstRamCpy2
L_strConstRamCpy3:
;USART_test5.c,54 :: 		*dest = 0 ;    // terminateur
	MOVFF       FARG_strConstRamCpy_dest+0, FSR1L+0
	MOVFF       FARG_strConstRamCpy_dest+1, FSR1H+0
	CLRF        POSTINC1+0 
;USART_test5.c,55 :: 		}
L_end_strConstRamCpy:
	RETURN      0
; end of _strConstRamCpy

_main:

;USART_test5.c,65 :: 		void main() {
;USART_test5.c,67 :: 		OSCCON = 0b01110000;  // bit7: device enters SLEEP on sleep instruction[0]
	MOVLW       112
	MOVWF       OSCCON+0 
;USART_test5.c,73 :: 		OSCTUNE = 0b00000000; // bit7:  device clock derived from the MFINTOSC or HFINTOSC source
	CLRF        OSCTUNE+0 
;USART_test5.c,76 :: 		ANSELC=0;
	CLRF        ANSELC+0 
;USART_test5.c,77 :: 		Led_Blanche_direction=0; // output
	BCF         TRISA4_bit+0, BitPos(TRISA4_bit+0) 
;USART_test5.c,80 :: 		Led_Blanche=1;     // do a chrono during led is ON
	BSF         LATA4_bit+0, BitPos(LATA4_bit+0) 
;USART_test5.c,81 :: 		Delay_ms(5000);
	MOVLW       102
	MOVWF       R11, 0
	MOVLW       118
	MOVWF       R12, 0
	MOVLW       193
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
;USART_test5.c,82 :: 		Led_Blanche=0;
	BCF         LATA4_bit+0, BitPos(LATA4_bit+0) 
;USART_test5.c,85 :: 		UART1_Init(19200);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;USART_test5.c,86 :: 		UART1_Write(CLS);  // efface ecran si code 12 voir vbray
	MOVLW       12
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;USART_test5.c,87 :: 		Delay_ms(1000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
	NOP
;USART_test5.c,89 :: 		UART1_Write('A');
	MOVLW       65
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;USART_test5.c,90 :: 		UART1_Write('B');
	MOVLW       66
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;USART_test5.c,91 :: 		UART1_Write('Z');
	MOVLW       90
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;USART_test5.c,92 :: 		UART1_Write('a');
	MOVLW       97
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;USART_test5.c,93 :: 		UART1_Write('b');
	MOVLW       98
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;USART_test5.c,94 :: 		UART1_Write('Z');
	MOVLW       90
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;USART_test5.c,98 :: 		txt=&TEXTE[0]; // init pointeur sur table TEXTE
	MOVLW       _TEXTE+0
	MOVWF       _txt+0 
	MOVLW       hi_addr(_TEXTE+0)
	MOVWF       _txt+1 
;USART_test5.c,99 :: 		Freq = Clock_kHz();
	MOVLW       128
	MOVWF       _Freq+0 
	MOVLW       62
	MOVWF       _Freq+1 
	MOVLW       0
	MOVWF       _Freq+2 
	MOVWF       _Freq+3 
;USART_test5.c,101 :: 		UART1_Write_CText(" Fosc =");
	MOVLW       ?lstr_1_USART_test5+0
	MOVWF       FARG_UART1_Write_CText_txt1+0 
	MOVLW       hi_addr(?lstr_1_USART_test5+0)
	MOVWF       FARG_UART1_Write_CText_txt1+1 
	MOVLW       higher_addr(?lstr_1_USART_test5+0)
	MOVWF       FARG_UART1_Write_CText_txt1+2 
	CALL        _UART1_Write_CText+0, 0
;USART_test5.c,104 :: 		UART1_Write_CText(" KHz\r\n");
	MOVLW       ?lstr_2_USART_test5+0
	MOVWF       FARG_UART1_Write_CText_txt1+0 
	MOVLW       hi_addr(?lstr_2_USART_test5+0)
	MOVWF       FARG_UART1_Write_CText_txt1+1 
	MOVLW       higher_addr(?lstr_2_USART_test5+0)
	MOVWF       FARG_UART1_Write_CText_txt1+2 
	CALL        _UART1_Write_CText+0, 0
;USART_test5.c,106 :: 		UART1_Write_CText("18F46K22 40pins FOSC=16MHz test UART1 19200,8,N,1\r\n ");
	MOVLW       ?lstr_3_USART_test5+0
	MOVWF       FARG_UART1_Write_CText_txt1+0 
	MOVLW       hi_addr(?lstr_3_USART_test5+0)
	MOVWF       FARG_UART1_Write_CText_txt1+1 
	MOVLW       higher_addr(?lstr_3_USART_test5+0)
	MOVWF       FARG_UART1_Write_CText_txt1+2 
	CALL        _UART1_Write_CText+0, 0
;USART_test5.c,109 :: 		while(1){
L_main6:
;USART_test5.c,110 :: 		UART1_Write_Text("Hello");
	MOVLW       ?lstr4_USART_test5+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_USART_test5+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test5.c,111 :: 		Delay_ms(1000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
	DECFSZ      R12, 1, 1
	BRA         L_main8
	DECFSZ      R11, 1, 1
	BRA         L_main8
	NOP
;USART_test5.c,112 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;USART_test5.c,113 :: 		Led_Blanche=!Led_Blanche;
	BTG         LATA4_bit+0, BitPos(LATA4_bit+0) 
;USART_test5.c,114 :: 		}
	GOTO        L_main6
;USART_test5.c,115 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
