
_main:

;Blink2.c,1 :: 		void main()
;Blink2.c,5 :: 		OSCCON = 0b01110000;  // bit7: device enters SLEEP on sleep instruction[0]
	MOVLW       112
	MOVWF       OSCCON+0 
;Blink2.c,11 :: 		OSCTUNE = 0b00000000; // bit7:  device clock derived from the MFINTOSC or HFINTOSC source
	CLRF        OSCTUNE+0 
;Blink2.c,16 :: 		TRISD = 0; //set pin B0 as output
	CLRF        TRISD+0 
;Blink2.c,19 :: 		ANSELD = 0; //set port as Digital
	CLRF        ANSELD+0 
;Blink2.c,21 :: 		do
L_main0:
;Blink2.c,26 :: 		LATD = 0;
	CLRF        LATD+0 
;Blink2.c,28 :: 		Delay_ms(1000); //Delay of 1 second
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
;Blink2.c,31 :: 		LATD = 1;
	MOVLW       1
	MOVWF       LATD+0 
;Blink2.c,33 :: 		Delay_ms(1000); //Delay of 1 second
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
;Blink2.c,37 :: 		while(1); //Keep the loop running
	GOTO        L_main0
;Blink2.c,39 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
