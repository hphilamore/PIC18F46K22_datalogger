
_bcd_to_decimal:

<<<<<<< HEAD
;USART_test.c,193 :: 		uint8_t bcd_to_decimal(uint8_t number)
;USART_test.c,195 :: 		return ( (number >> 4) * 10 + (number & 0x0F) );
=======
;USART_test.c,188 :: 		uint8_t bcd_to_decimal(uint8_t number)
;USART_test.c,190 :: 		return ( (number >> 4) * 10 + (number & 0x0F) );
>>>>>>> parent of 7a63acd... RTc library removed
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
<<<<<<< HEAD
;USART_test.c,196 :: 		}
=======
;USART_test.c,191 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_bcd_to_decimal:
	RETURN      0
; end of _bcd_to_decimal

_decimal_to_bcd:

<<<<<<< HEAD
;USART_test.c,199 :: 		uint8_t decimal_to_bcd(uint8_t number)
;USART_test.c,201 :: 		return ( ((number / 10) << 4) + (number % 10) );
=======
;USART_test.c,194 :: 		uint8_t decimal_to_bcd(uint8_t number)
;USART_test.c,196 :: 		return ( ((number / 10) << 4) + (number % 10) );
>>>>>>> parent of 7a63acd... RTc library removed
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
<<<<<<< HEAD
;USART_test.c,202 :: 		}
=======
;USART_test.c,197 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_decimal_to_bcd:
	RETURN      0
; end of _decimal_to_bcd

_alarm_cfg:

<<<<<<< HEAD
;USART_test.c,205 :: 		uint8_t alarm_cfg(uint8_t n, uint8_t i)
;USART_test.c,207 :: 		if( n & (1 << i) )
=======
;USART_test.c,200 :: 		uint8_t alarm_cfg(uint8_t n, uint8_t i)
;USART_test.c,202 :: 		if( n & (1 << i) )
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        FARG_alarm_cfg_i+0, 0 
	MOVWF       R2 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__alarm_cfg33:
	BZ          L__alarm_cfg34
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__alarm_cfg33
L__alarm_cfg34:
	MOVF        FARG_alarm_cfg_n+0, 0 
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm_cfg0
<<<<<<< HEAD
;USART_test.c,208 :: 		return 0x80;
=======
;USART_test.c,203 :: 		return 0x80;
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       128
	MOVWF       R0 
	GOTO        L_end_alarm_cfg
L_alarm_cfg0:
<<<<<<< HEAD
;USART_test.c,210 :: 		return 0;
	CLRF        R0 
;USART_test.c,211 :: 		}
=======
;USART_test.c,205 :: 		return 0;
	CLRF        R0 
;USART_test.c,206 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_alarm_cfg:
	RETURN      0
; end of _alarm_cfg

_RTC_Set:

<<<<<<< HEAD
;USART_test.c,214 :: 		void RTC_Set(RTC_Time *time_t)
;USART_test.c,217 :: 		time_t->day     = decimal_to_bcd(time_t->day);
=======
;USART_test.c,209 :: 		void RTC_Set(RTC_Time *time_t)
;USART_test.c,212 :: 		time_t->day     = decimal_to_bcd(time_t->day);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       4
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FLOC__RTC_Set+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FLOC__RTC_Set+1 
	MOVFF       FLOC__RTC_Set+0, FSR0L+0
	MOVFF       FLOC__RTC_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__RTC_Set+0, FSR1L+0
	MOVFF       FLOC__RTC_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
<<<<<<< HEAD
;USART_test.c,218 :: 		time_t->month   = decimal_to_bcd(time_t->month);
=======
;USART_test.c,213 :: 		time_t->month   = decimal_to_bcd(time_t->month);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       5
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FLOC__RTC_Set+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FLOC__RTC_Set+1 
	MOVFF       FLOC__RTC_Set+0, FSR0L+0
	MOVFF       FLOC__RTC_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__RTC_Set+0, FSR1L+0
	MOVFF       FLOC__RTC_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
<<<<<<< HEAD
;USART_test.c,219 :: 		time_t->year    = decimal_to_bcd(time_t->year);
=======
;USART_test.c,214 :: 		time_t->year    = decimal_to_bcd(time_t->year);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       6
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FLOC__RTC_Set+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FLOC__RTC_Set+1 
	MOVFF       FLOC__RTC_Set+0, FSR0L+0
	MOVFF       FLOC__RTC_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__RTC_Set+0, FSR1L+0
	MOVFF       FLOC__RTC_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
<<<<<<< HEAD
;USART_test.c,220 :: 		time_t->hours   = decimal_to_bcd(time_t->hours);
=======
;USART_test.c,215 :: 		time_t->hours   = decimal_to_bcd(time_t->hours);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       2
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FLOC__RTC_Set+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FLOC__RTC_Set+1 
	MOVFF       FLOC__RTC_Set+0, FSR0L+0
	MOVFF       FLOC__RTC_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__RTC_Set+0, FSR1L+0
	MOVFF       FLOC__RTC_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
<<<<<<< HEAD
;USART_test.c,221 :: 		time_t->minutes = decimal_to_bcd(time_t->minutes);
=======
;USART_test.c,216 :: 		time_t->minutes = decimal_to_bcd(time_t->minutes);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FLOC__RTC_Set+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FLOC__RTC_Set+1 
	MOVFF       FLOC__RTC_Set+0, FSR0L+0
	MOVFF       FLOC__RTC_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__RTC_Set+0, FSR1L+0
	MOVFF       FLOC__RTC_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
<<<<<<< HEAD
;USART_test.c,222 :: 		time_t->seconds = decimal_to_bcd(time_t->seconds);
=======
;USART_test.c,217 :: 		time_t->seconds = decimal_to_bcd(time_t->seconds);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        FARG_RTC_Set_time_t+0, 0 
	MOVWF       FLOC__RTC_Set+0 
	MOVF        FARG_RTC_Set_time_t+1, 0 
	MOVWF       FLOC__RTC_Set+1 
	MOVFF       FARG_RTC_Set_time_t+0, FSR0L+0
	MOVFF       FARG_RTC_Set_time_t+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__RTC_Set+0, FSR1L+0
	MOVFF       FLOC__RTC_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
<<<<<<< HEAD
;USART_test.c,226 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;USART_test.c,227 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,228 :: 		RTC_I2C_WRITE(DS3231_REG_SECONDS);
	CLRF        FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,229 :: 		RTC_I2C_WRITE(time_t->seconds);
=======
;USART_test.c,221 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;USART_test.c,222 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,223 :: 		RTC_I2C_WRITE(DS3231_REG_SECONDS);
	CLRF        FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,224 :: 		RTC_I2C_WRITE(time_t->seconds);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVFF       FARG_RTC_Set_time_t+0, FSR0L+0
	MOVFF       FARG_RTC_Set_time_t+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
<<<<<<< HEAD
;USART_test.c,230 :: 		RTC_I2C_WRITE(time_t->minutes);
=======
;USART_test.c,225 :: 		RTC_I2C_WRITE(time_t->minutes);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
<<<<<<< HEAD
;USART_test.c,231 :: 		RTC_I2C_WRITE(time_t->hours);
=======
;USART_test.c,226 :: 		RTC_I2C_WRITE(time_t->hours);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       2
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
<<<<<<< HEAD
;USART_test.c,232 :: 		RTC_I2C_WRITE(time_t->dow);
=======
;USART_test.c,227 :: 		RTC_I2C_WRITE(time_t->dow);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       3
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
<<<<<<< HEAD
;USART_test.c,233 :: 		RTC_I2C_WRITE(time_t->day);
=======
;USART_test.c,228 :: 		RTC_I2C_WRITE(time_t->day);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       4
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
<<<<<<< HEAD
;USART_test.c,234 :: 		RTC_I2C_WRITE(time_t->month);
=======
;USART_test.c,229 :: 		RTC_I2C_WRITE(time_t->month);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       5
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
<<<<<<< HEAD
;USART_test.c,235 :: 		RTC_I2C_WRITE(time_t->year);
=======
;USART_test.c,230 :: 		RTC_I2C_WRITE(time_t->year);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       6
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
<<<<<<< HEAD
;USART_test.c,236 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;USART_test.c,237 :: 		}
=======
;USART_test.c,231 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;USART_test.c,232 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_RTC_Set:
	RETURN      0
; end of _RTC_Set

_RTC_Get:

<<<<<<< HEAD
;USART_test.c,240 :: 		RTC_Time *RTC_Get()
;USART_test.c,242 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;USART_test.c,243 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,244 :: 		RTC_I2C_WRITE(DS3231_REG_SECONDS);
	CLRF        FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,245 :: 		RTC_I2C_RESTART();
	CALL        _I2C2_Repeated_Start+0, 0
;USART_test.c,246 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,247 :: 		c_time.seconds = RTC_I2C_READ(1);
=======
;USART_test.c,235 :: 		RTC_Time *RTC_Get()
;USART_test.c,237 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;USART_test.c,238 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,239 :: 		RTC_I2C_WRITE(DS3231_REG_SECONDS);
	CLRF        FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,240 :: 		RTC_I2C_RESTART();
	CALL        _I2C2_Repeated_Start+0, 0
;USART_test.c,241 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,242 :: 		c_time.seconds = RTC_I2C_READ(1);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+0 
<<<<<<< HEAD
;USART_test.c,248 :: 		c_time.minutes = RTC_I2C_READ(1);
=======
;USART_test.c,243 :: 		c_time.minutes = RTC_I2C_READ(1);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+1 
<<<<<<< HEAD
;USART_test.c,249 :: 		c_time.hours   = RTC_I2C_READ(1);
=======
;USART_test.c,244 :: 		c_time.hours   = RTC_I2C_READ(1);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+2 
<<<<<<< HEAD
;USART_test.c,250 :: 		c_time.dow   = RTC_I2C_READ(1);
=======
;USART_test.c,245 :: 		c_time.dow   = RTC_I2C_READ(1);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+3 
<<<<<<< HEAD
;USART_test.c,251 :: 		c_time.day   = RTC_I2C_READ(1);
=======
;USART_test.c,246 :: 		c_time.day   = RTC_I2C_READ(1);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+4 
<<<<<<< HEAD
;USART_test.c,252 :: 		c_time.month = RTC_I2C_READ(1);
=======
;USART_test.c,247 :: 		c_time.month = RTC_I2C_READ(1);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+5 
<<<<<<< HEAD
;USART_test.c,253 :: 		c_time.year  = RTC_I2C_READ(0);
=======
;USART_test.c,248 :: 		c_time.year  = RTC_I2C_READ(0);
>>>>>>> parent of 7a63acd... RTc library removed
	CLRF        FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+6 
<<<<<<< HEAD
;USART_test.c,254 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;USART_test.c,257 :: 		c_time.seconds = bcd_to_decimal(c_time.seconds);
=======
;USART_test.c,249 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;USART_test.c,252 :: 		c_time.seconds = bcd_to_decimal(c_time.seconds);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        _c_time+0, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+0 
<<<<<<< HEAD
;USART_test.c,258 :: 		c_time.minutes = bcd_to_decimal(c_time.minutes);
=======
;USART_test.c,253 :: 		c_time.minutes = bcd_to_decimal(c_time.minutes);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        _c_time+1, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+1 
<<<<<<< HEAD
;USART_test.c,259 :: 		c_time.hours   = bcd_to_decimal(c_time.hours);
=======
;USART_test.c,254 :: 		c_time.hours   = bcd_to_decimal(c_time.hours);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        _c_time+2, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+2 
<<<<<<< HEAD
;USART_test.c,260 :: 		c_time.day     = bcd_to_decimal(c_time.day);
=======
;USART_test.c,255 :: 		c_time.day     = bcd_to_decimal(c_time.day);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        _c_time+4, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+4 
<<<<<<< HEAD
;USART_test.c,261 :: 		c_time.month   = bcd_to_decimal(c_time.month);
=======
;USART_test.c,256 :: 		c_time.month   = bcd_to_decimal(c_time.month);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        _c_time+5, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+5 
<<<<<<< HEAD
;USART_test.c,262 :: 		c_time.year    = bcd_to_decimal(c_time.year);
=======
;USART_test.c,257 :: 		c_time.year    = bcd_to_decimal(c_time.year);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        _c_time+6, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+6 
<<<<<<< HEAD
;USART_test.c,265 :: 		return &c_time;
=======
;USART_test.c,260 :: 		return &c_time;
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       _c_time+0
	MOVWF       R0 
	MOVLW       hi_addr(_c_time+0)
	MOVWF       R1 
<<<<<<< HEAD
;USART_test.c,266 :: 		}
=======
;USART_test.c,261 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_RTC_Get:
	RETURN      0
; end of _RTC_Get

_Alarm1_Set:

<<<<<<< HEAD
;USART_test.c,269 :: 		void Alarm1_Set(RTC_Time *time_t, al1 _config)
;USART_test.c,272 :: 		time_t->day     = decimal_to_bcd(time_t->day);
=======
;USART_test.c,264 :: 		void Alarm1_Set(RTC_Time *time_t, al1 _config)
;USART_test.c,267 :: 		time_t->day     = decimal_to_bcd(time_t->day);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       4
	ADDWF       FARG_Alarm1_Set_time_t+0, 0 
	MOVWF       FLOC__Alarm1_Set+0 
	MOVLW       0
	ADDWFC      FARG_Alarm1_Set_time_t+1, 0 
	MOVWF       FLOC__Alarm1_Set+1 
	MOVFF       FLOC__Alarm1_Set+0, FSR0L+0
	MOVFF       FLOC__Alarm1_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__Alarm1_Set+0, FSR1L+0
	MOVFF       FLOC__Alarm1_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
<<<<<<< HEAD
;USART_test.c,273 :: 		time_t->hours   = decimal_to_bcd(time_t->hours);
=======
;USART_test.c,268 :: 		time_t->hours   = decimal_to_bcd(time_t->hours);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       2
	ADDWF       FARG_Alarm1_Set_time_t+0, 0 
	MOVWF       FLOC__Alarm1_Set+0 
	MOVLW       0
	ADDWFC      FARG_Alarm1_Set_time_t+1, 0 
	MOVWF       FLOC__Alarm1_Set+1 
	MOVFF       FLOC__Alarm1_Set+0, FSR0L+0
	MOVFF       FLOC__Alarm1_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__Alarm1_Set+0, FSR1L+0
	MOVFF       FLOC__Alarm1_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
<<<<<<< HEAD
;USART_test.c,274 :: 		time_t->minutes = decimal_to_bcd(time_t->minutes);
=======
;USART_test.c,269 :: 		time_t->minutes = decimal_to_bcd(time_t->minutes);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	ADDWF       FARG_Alarm1_Set_time_t+0, 0 
	MOVWF       FLOC__Alarm1_Set+0 
	MOVLW       0
	ADDWFC      FARG_Alarm1_Set_time_t+1, 0 
	MOVWF       FLOC__Alarm1_Set+1 
	MOVFF       FLOC__Alarm1_Set+0, FSR0L+0
	MOVFF       FLOC__Alarm1_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__Alarm1_Set+0, FSR1L+0
	MOVFF       FLOC__Alarm1_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
<<<<<<< HEAD
;USART_test.c,275 :: 		time_t->seconds = decimal_to_bcd(time_t->seconds);
=======
;USART_test.c,270 :: 		time_t->seconds = decimal_to_bcd(time_t->seconds);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        FARG_Alarm1_Set_time_t+0, 0 
	MOVWF       FLOC__Alarm1_Set+0 
	MOVF        FARG_Alarm1_Set_time_t+1, 0 
	MOVWF       FLOC__Alarm1_Set+1 
	MOVFF       FARG_Alarm1_Set_time_t+0, FSR0L+0
	MOVFF       FARG_Alarm1_Set_time_t+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__Alarm1_Set+0, FSR1L+0
	MOVFF       FLOC__Alarm1_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
<<<<<<< HEAD
;USART_test.c,279 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;USART_test.c,280 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,281 :: 		RTC_I2C_WRITE(DS3231_REG_AL1_SEC);
	MOVLW       7
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,282 :: 		RTC_I2C_WRITE( time_t->seconds | alarm_cfg(_config, 0) );
=======
;USART_test.c,274 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;USART_test.c,275 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,276 :: 		RTC_I2C_WRITE(DS3231_REG_AL1_SEC);
	MOVLW       7
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,277 :: 		RTC_I2C_WRITE( time_t->seconds | alarm_cfg(_config, 0) );
>>>>>>> parent of 7a63acd... RTc library removed
	MOVFF       FARG_Alarm1_Set_time_t+0, FSR0L+0
	MOVFF       FARG_Alarm1_Set_time_t+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Alarm1_Set+0 
	MOVF        FARG_Alarm1_Set__config+0, 0 
	MOVWF       FARG_alarm_cfg_n+0 
	CLRF        FARG_alarm_cfg_i+0 
	CALL        _alarm_cfg+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__Alarm1_Set+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
<<<<<<< HEAD
;USART_test.c,283 :: 		RTC_I2C_WRITE( time_t->minutes | alarm_cfg(_config, 1) );
=======
;USART_test.c,278 :: 		RTC_I2C_WRITE( time_t->minutes | alarm_cfg(_config, 1) );
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	ADDWF       FARG_Alarm1_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_Alarm1_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Alarm1_Set+0 
	MOVF        FARG_Alarm1_Set__config+0, 0 
	MOVWF       FARG_alarm_cfg_n+0 
	MOVLW       1
	MOVWF       FARG_alarm_cfg_i+0 
	CALL        _alarm_cfg+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__Alarm1_Set+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
<<<<<<< HEAD
;USART_test.c,284 :: 		RTC_I2C_WRITE( time_t->hours   | alarm_cfg(_config, 2) );
=======
;USART_test.c,279 :: 		RTC_I2C_WRITE( time_t->hours   | alarm_cfg(_config, 2) );
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       2
	ADDWF       FARG_Alarm1_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_Alarm1_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Alarm1_Set+0 
	MOVF        FARG_Alarm1_Set__config+0, 0 
	MOVWF       FARG_alarm_cfg_n+0 
	MOVLW       2
	MOVWF       FARG_alarm_cfg_i+0 
	CALL        _alarm_cfg+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__Alarm1_Set+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
<<<<<<< HEAD
;USART_test.c,285 :: 		if ( _config & 0x10 )
	BTFSS       FARG_Alarm1_Set__config+0, 4 
	GOTO        L_Alarm1_Set2
;USART_test.c,286 :: 		RTC_I2C_WRITE( time_t->dow | 0x40 | alarm_cfg(_config, 3) );
=======
;USART_test.c,280 :: 		if ( _config & 0x10 )
	BTFSS       FARG_Alarm1_Set__config+0, 4 
	GOTO        L_Alarm1_Set2
;USART_test.c,281 :: 		RTC_I2C_WRITE( time_t->dow | 0x40 | alarm_cfg(_config, 3) );
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       3
	ADDWF       FARG_Alarm1_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_Alarm1_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       64
	IORWF       POSTINC0+0, 0 
	MOVWF       FLOC__Alarm1_Set+0 
	MOVF        FARG_Alarm1_Set__config+0, 0 
	MOVWF       FARG_alarm_cfg_n+0 
	MOVLW       3
	MOVWF       FARG_alarm_cfg_i+0 
	CALL        _alarm_cfg+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__Alarm1_Set+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
	GOTO        L_Alarm1_Set3
L_Alarm1_Set2:
<<<<<<< HEAD
;USART_test.c,288 :: 		RTC_I2C_WRITE( time_t->day | alarm_cfg(_config, 3) );
=======
;USART_test.c,283 :: 		RTC_I2C_WRITE( time_t->day | alarm_cfg(_config, 3) );
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       4
	ADDWF       FARG_Alarm1_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_Alarm1_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Alarm1_Set+0 
	MOVF        FARG_Alarm1_Set__config+0, 0 
	MOVWF       FARG_alarm_cfg_n+0 
	MOVLW       3
	MOVWF       FARG_alarm_cfg_i+0 
	CALL        _alarm_cfg+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__Alarm1_Set+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
L_Alarm1_Set3:
<<<<<<< HEAD
;USART_test.c,289 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;USART_test.c,290 :: 		}
=======
;USART_test.c,284 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;USART_test.c,285 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_Alarm1_Set:
	RETURN      0
; end of _Alarm1_Set

_Alarm1_Get:

<<<<<<< HEAD
;USART_test.c,293 :: 		RTC_Time *Alarm1_Get()
;USART_test.c,295 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;USART_test.c,296 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,297 :: 		RTC_I2C_WRITE(DS3231_REG_AL1_SEC);
	MOVLW       7
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,298 :: 		RTC_I2C_RESTART();
	CALL        _I2C2_Repeated_Start+0, 0
;USART_test.c,299 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,300 :: 		c_alarm1.seconds = RTC_I2C_READ(1) & 0x7F;
=======
;USART_test.c,288 :: 		RTC_Time *Alarm1_Get()
;USART_test.c,290 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;USART_test.c,291 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,292 :: 		RTC_I2C_WRITE(DS3231_REG_AL1_SEC);
	MOVLW       7
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,293 :: 		RTC_I2C_RESTART();
	CALL        _I2C2_Repeated_Start+0, 0
;USART_test.c,294 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,295 :: 		c_alarm1.seconds = RTC_I2C_READ(1) & 0x7F;
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVLW       127
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm1+0 
<<<<<<< HEAD
;USART_test.c,301 :: 		c_alarm1.minutes = RTC_I2C_READ(1) & 0x7F;
=======
;USART_test.c,296 :: 		c_alarm1.minutes = RTC_I2C_READ(1) & 0x7F;
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVLW       127
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm1+1 
<<<<<<< HEAD
;USART_test.c,302 :: 		c_alarm1.hours   = RTC_I2C_READ(1) & 0x3F;
=======
;USART_test.c,297 :: 		c_alarm1.hours   = RTC_I2C_READ(1) & 0x3F;
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVLW       63
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm1+2 
<<<<<<< HEAD
;USART_test.c,303 :: 		c_alarm1.dow = c_alarm1.day = RTC_I2C_READ(0) & 0x3F;
=======
;USART_test.c,298 :: 		c_alarm1.dow = c_alarm1.day = RTC_I2C_READ(0) & 0x3F;
>>>>>>> parent of 7a63acd... RTc library removed
	CLRF        FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVLW       63
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm1+4 
	MOVF        R0, 0 
	MOVWF       _c_alarm1+3 
<<<<<<< HEAD
;USART_test.c,304 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;USART_test.c,307 :: 		c_alarm1.seconds = bcd_to_decimal(c_alarm1.seconds);
=======
;USART_test.c,299 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;USART_test.c,302 :: 		c_alarm1.seconds = bcd_to_decimal(c_alarm1.seconds);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        _c_alarm1+0, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm1+0 
<<<<<<< HEAD
;USART_test.c,308 :: 		c_alarm1.minutes = bcd_to_decimal(c_alarm1.minutes);
=======
;USART_test.c,303 :: 		c_alarm1.minutes = bcd_to_decimal(c_alarm1.minutes);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        _c_alarm1+1, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm1+1 
<<<<<<< HEAD
;USART_test.c,309 :: 		c_alarm1.hours   = bcd_to_decimal(c_alarm1.hours);
=======
;USART_test.c,304 :: 		c_alarm1.hours   = bcd_to_decimal(c_alarm1.hours);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        _c_alarm1+2, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm1+2 
<<<<<<< HEAD
;USART_test.c,310 :: 		c_alarm1.day     = bcd_to_decimal(c_alarm1.day);
=======
;USART_test.c,305 :: 		c_alarm1.day     = bcd_to_decimal(c_alarm1.day);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        _c_alarm1+4, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm1+4 
<<<<<<< HEAD
;USART_test.c,313 :: 		return &c_alarm1;
=======
;USART_test.c,308 :: 		return &c_alarm1;
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       _c_alarm1+0
	MOVWF       R0 
	MOVLW       hi_addr(_c_alarm1+0)
	MOVWF       R1 
<<<<<<< HEAD
;USART_test.c,314 :: 		}
=======
;USART_test.c,309 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_Alarm1_Get:
	RETURN      0
; end of _Alarm1_Get

_Alarm1_Enable:

<<<<<<< HEAD
;USART_test.c,317 :: 		void Alarm1_Enable()
;USART_test.c,319 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,320 :: 		ctrl_reg |= 0x01;
	MOVLW       1
	IORWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,321 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,322 :: 		}
=======
;USART_test.c,312 :: 		void Alarm1_Enable()
;USART_test.c,314 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,315 :: 		ctrl_reg |= 0x01;
	MOVLW       1
	IORWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,316 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,317 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_Alarm1_Enable:
	RETURN      0
; end of _Alarm1_Enable

_Alarm1_Disable:

<<<<<<< HEAD
;USART_test.c,325 :: 		void Alarm1_Disable()
;USART_test.c,327 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,328 :: 		ctrl_reg &= 0xFE;
	MOVLW       254
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,329 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,330 :: 		}
=======
;USART_test.c,320 :: 		void Alarm1_Disable()
;USART_test.c,322 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,323 :: 		ctrl_reg &= 0xFE;
	MOVLW       254
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,324 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,325 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_Alarm1_Disable:
	RETURN      0
; end of _Alarm1_Disable

_Alarm1_IF_Check:

<<<<<<< HEAD
;USART_test.c,333 :: 		uint8_t Alarm1_IF_Check()
;USART_test.c,335 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,336 :: 		if(stat_reg & 0x01)
	BTFSS       R0, 0 
	GOTO        L_Alarm1_IF_Check4
;USART_test.c,337 :: 		return 1;
=======
;USART_test.c,328 :: 		uint8_t Alarm1_IF_Check()
;USART_test.c,330 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,331 :: 		if(stat_reg & 0x01)
	BTFSS       R0, 0 
	GOTO        L_Alarm1_IF_Check4
;USART_test.c,332 :: 		return 1;
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_Alarm1_IF_Check
L_Alarm1_IF_Check4:
<<<<<<< HEAD
;USART_test.c,339 :: 		return 0;
	CLRF        R0 
;USART_test.c,340 :: 		}
=======
;USART_test.c,334 :: 		return 0;
	CLRF        R0 
;USART_test.c,335 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_Alarm1_IF_Check:
	RETURN      0
; end of _Alarm1_IF_Check

_Alarm1_IF_Reset:

<<<<<<< HEAD
;USART_test.c,343 :: 		void Alarm1_IF_Reset()
;USART_test.c,345 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,346 :: 		stat_reg &= 0xFE;
	MOVLW       254
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,347 :: 		RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
	MOVLW       15
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,348 :: 		}
=======
;USART_test.c,338 :: 		void Alarm1_IF_Reset()
;USART_test.c,340 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,341 :: 		stat_reg &= 0xFE;
	MOVLW       254
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,342 :: 		RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
	MOVLW       15
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,343 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_Alarm1_IF_Reset:
	RETURN      0
; end of _Alarm1_IF_Reset

_Alarm1_Status:

<<<<<<< HEAD
;USART_test.c,351 :: 		uint8_t Alarm1_Status()
;USART_test.c,353 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,354 :: 		if(ctrl_reg & 0x01)
	BTFSS       R0, 0 
	GOTO        L_Alarm1_Status6
;USART_test.c,355 :: 		return 1;
=======
;USART_test.c,346 :: 		uint8_t Alarm1_Status()
;USART_test.c,348 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,349 :: 		if(ctrl_reg & 0x01)
	BTFSS       R0, 0 
	GOTO        L_Alarm1_Status6
;USART_test.c,350 :: 		return 1;
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_Alarm1_Status
L_Alarm1_Status6:
<<<<<<< HEAD
;USART_test.c,357 :: 		return 0;
	CLRF        R0 
;USART_test.c,358 :: 		}
=======
;USART_test.c,352 :: 		return 0;
	CLRF        R0 
;USART_test.c,353 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_Alarm1_Status:
	RETURN      0
; end of _Alarm1_Status

_Alarm2_Set:

<<<<<<< HEAD
;USART_test.c,361 :: 		void Alarm2_Set(RTC_Time *time_t, al2 _config)
;USART_test.c,364 :: 		time_t->day     = decimal_to_bcd(time_t->day);
=======
;USART_test.c,356 :: 		void Alarm2_Set(RTC_Time *time_t, al2 _config)
;USART_test.c,359 :: 		time_t->day     = decimal_to_bcd(time_t->day);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       4
	ADDWF       FARG_Alarm2_Set_time_t+0, 0 
	MOVWF       FLOC__Alarm2_Set+0 
	MOVLW       0
	ADDWFC      FARG_Alarm2_Set_time_t+1, 0 
	MOVWF       FLOC__Alarm2_Set+1 
	MOVFF       FLOC__Alarm2_Set+0, FSR0L+0
	MOVFF       FLOC__Alarm2_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__Alarm2_Set+0, FSR1L+0
	MOVFF       FLOC__Alarm2_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
<<<<<<< HEAD
;USART_test.c,365 :: 		time_t->hours   = decimal_to_bcd(time_t->hours);
=======
;USART_test.c,360 :: 		time_t->hours   = decimal_to_bcd(time_t->hours);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       2
	ADDWF       FARG_Alarm2_Set_time_t+0, 0 
	MOVWF       FLOC__Alarm2_Set+0 
	MOVLW       0
	ADDWFC      FARG_Alarm2_Set_time_t+1, 0 
	MOVWF       FLOC__Alarm2_Set+1 
	MOVFF       FLOC__Alarm2_Set+0, FSR0L+0
	MOVFF       FLOC__Alarm2_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__Alarm2_Set+0, FSR1L+0
	MOVFF       FLOC__Alarm2_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
<<<<<<< HEAD
;USART_test.c,366 :: 		time_t->minutes = decimal_to_bcd(time_t->minutes);
=======
;USART_test.c,361 :: 		time_t->minutes = decimal_to_bcd(time_t->minutes);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	ADDWF       FARG_Alarm2_Set_time_t+0, 0 
	MOVWF       FLOC__Alarm2_Set+0 
	MOVLW       0
	ADDWFC      FARG_Alarm2_Set_time_t+1, 0 
	MOVWF       FLOC__Alarm2_Set+1 
	MOVFF       FLOC__Alarm2_Set+0, FSR0L+0
	MOVFF       FLOC__Alarm2_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__Alarm2_Set+0, FSR1L+0
	MOVFF       FLOC__Alarm2_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
<<<<<<< HEAD
;USART_test.c,370 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;USART_test.c,371 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,372 :: 		RTC_I2C_WRITE(DS3231_REG_AL2_MIN);
	MOVLW       11
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,373 :: 		RTC_I2C_WRITE( (time_t->minutes) | alarm_cfg(_config, 1) );
=======
;USART_test.c,365 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;USART_test.c,366 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,367 :: 		RTC_I2C_WRITE(DS3231_REG_AL2_MIN);
	MOVLW       11
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,368 :: 		RTC_I2C_WRITE( (time_t->minutes) | alarm_cfg(_config, 1) );
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	ADDWF       FARG_Alarm2_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_Alarm2_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Alarm2_Set+0 
	MOVF        FARG_Alarm2_Set__config+0, 0 
	MOVWF       FARG_alarm_cfg_n+0 
	MOVLW       1
	MOVWF       FARG_alarm_cfg_i+0 
	CALL        _alarm_cfg+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__Alarm2_Set+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
<<<<<<< HEAD
;USART_test.c,374 :: 		RTC_I2C_WRITE( (time_t->hours) | alarm_cfg(_config, 2) );
=======
;USART_test.c,369 :: 		RTC_I2C_WRITE( (time_t->hours) | alarm_cfg(_config, 2) );
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       2
	ADDWF       FARG_Alarm2_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_Alarm2_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Alarm2_Set+0 
	MOVF        FARG_Alarm2_Set__config+0, 0 
	MOVWF       FARG_alarm_cfg_n+0 
	MOVLW       2
	MOVWF       FARG_alarm_cfg_i+0 
	CALL        _alarm_cfg+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__Alarm2_Set+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
<<<<<<< HEAD
;USART_test.c,375 :: 		if ( _config & 0x10 )
	BTFSS       FARG_Alarm2_Set__config+0, 4 
	GOTO        L_Alarm2_Set8
;USART_test.c,376 :: 		RTC_I2C_WRITE( time_t->dow | 0x40 | alarm_cfg(_config, 3) );
=======
;USART_test.c,370 :: 		if ( _config & 0x10 )
	BTFSS       FARG_Alarm2_Set__config+0, 4 
	GOTO        L_Alarm2_Set8
;USART_test.c,371 :: 		RTC_I2C_WRITE( time_t->dow | 0x40 | alarm_cfg(_config, 3) );
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       3
	ADDWF       FARG_Alarm2_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_Alarm2_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       64
	IORWF       POSTINC0+0, 0 
	MOVWF       FLOC__Alarm2_Set+0 
	MOVF        FARG_Alarm2_Set__config+0, 0 
	MOVWF       FARG_alarm_cfg_n+0 
	MOVLW       3
	MOVWF       FARG_alarm_cfg_i+0 
	CALL        _alarm_cfg+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__Alarm2_Set+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
	GOTO        L_Alarm2_Set9
L_Alarm2_Set8:
<<<<<<< HEAD
;USART_test.c,378 :: 		RTC_I2C_WRITE( time_t->day | alarm_cfg(_config, 3) );
=======
;USART_test.c,373 :: 		RTC_I2C_WRITE( time_t->day | alarm_cfg(_config, 3) );
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       4
	ADDWF       FARG_Alarm2_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_Alarm2_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Alarm2_Set+0 
	MOVF        FARG_Alarm2_Set__config+0, 0 
	MOVWF       FARG_alarm_cfg_n+0 
	MOVLW       3
	MOVWF       FARG_alarm_cfg_i+0 
	CALL        _alarm_cfg+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__Alarm2_Set+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
L_Alarm2_Set9:
<<<<<<< HEAD
;USART_test.c,379 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;USART_test.c,380 :: 		}
=======
;USART_test.c,374 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;USART_test.c,375 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_Alarm2_Set:
	RETURN      0
; end of _Alarm2_Set

_Alarm2_Get:

<<<<<<< HEAD
;USART_test.c,383 :: 		RTC_Time *Alarm2_Get()
;USART_test.c,385 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;USART_test.c,386 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,387 :: 		RTC_I2C_WRITE(DS3231_REG_AL2_MIN);
	MOVLW       11
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,388 :: 		RTC_I2C_RESTART();
	CALL        _I2C2_Repeated_Start+0, 0
;USART_test.c,389 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,390 :: 		c_alarm2.minutes = RTC_I2C_READ(1) & 0x7F;
=======
;USART_test.c,378 :: 		RTC_Time *Alarm2_Get()
;USART_test.c,380 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;USART_test.c,381 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,382 :: 		RTC_I2C_WRITE(DS3231_REG_AL2_MIN);
	MOVLW       11
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,383 :: 		RTC_I2C_RESTART();
	CALL        _I2C2_Repeated_Start+0, 0
;USART_test.c,384 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,385 :: 		c_alarm2.minutes = RTC_I2C_READ(1) & 0x7F;
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVLW       127
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm2+1 
<<<<<<< HEAD
;USART_test.c,391 :: 		c_alarm2.hours   = RTC_I2C_READ(1) & 0x3F;
=======
;USART_test.c,386 :: 		c_alarm2.hours   = RTC_I2C_READ(1) & 0x3F;
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVLW       63
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm2+2 
<<<<<<< HEAD
;USART_test.c,392 :: 		c_alarm2.dow = c_alarm2.day = RTC_I2C_READ(0) & 0x3F;
=======
;USART_test.c,387 :: 		c_alarm2.dow = c_alarm2.day = RTC_I2C_READ(0) & 0x3F;
>>>>>>> parent of 7a63acd... RTc library removed
	CLRF        FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVLW       63
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm2+4 
	MOVF        R0, 0 
	MOVWF       _c_alarm2+3 
<<<<<<< HEAD
;USART_test.c,393 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;USART_test.c,396 :: 		c_alarm2.minutes = bcd_to_decimal(c_alarm2.minutes);
=======
;USART_test.c,388 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;USART_test.c,391 :: 		c_alarm2.minutes = bcd_to_decimal(c_alarm2.minutes);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        _c_alarm2+1, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm2+1 
<<<<<<< HEAD
;USART_test.c,397 :: 		c_alarm2.hours   = bcd_to_decimal(c_alarm2.hours);
=======
;USART_test.c,392 :: 		c_alarm2.hours   = bcd_to_decimal(c_alarm2.hours);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        _c_alarm2+2, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm2+2 
<<<<<<< HEAD
;USART_test.c,398 :: 		c_alarm2.day     = bcd_to_decimal(c_alarm2.day);
=======
;USART_test.c,393 :: 		c_alarm2.day     = bcd_to_decimal(c_alarm2.day);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        _c_alarm2+4, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm2+4 
<<<<<<< HEAD
;USART_test.c,400 :: 		c_alarm2.seconds = 0;
	CLRF        _c_alarm2+0 
;USART_test.c,401 :: 		return &c_alarm2;
=======
;USART_test.c,395 :: 		c_alarm2.seconds = 0;
	CLRF        _c_alarm2+0 
;USART_test.c,396 :: 		return &c_alarm2;
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       _c_alarm2+0
	MOVWF       R0 
	MOVLW       hi_addr(_c_alarm2+0)
	MOVWF       R1 
<<<<<<< HEAD
;USART_test.c,402 :: 		}
=======
;USART_test.c,397 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_Alarm2_Get:
	RETURN      0
; end of _Alarm2_Get

_Alarm2_Enable:

<<<<<<< HEAD
;USART_test.c,405 :: 		void Alarm2_Enable()
;USART_test.c,407 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,408 :: 		ctrl_reg |= 0x02;
	MOVLW       2
	IORWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,409 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,410 :: 		}
=======
;USART_test.c,400 :: 		void Alarm2_Enable()
;USART_test.c,402 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,403 :: 		ctrl_reg |= 0x02;
	MOVLW       2
	IORWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,404 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,405 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_Alarm2_Enable:
	RETURN      0
; end of _Alarm2_Enable

_Alarm2_Disable:

<<<<<<< HEAD
;USART_test.c,413 :: 		void Alarm2_Disable()
;USART_test.c,415 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,416 :: 		ctrl_reg &= 0xFD;
	MOVLW       253
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,417 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,418 :: 		}
=======
;USART_test.c,408 :: 		void Alarm2_Disable()
;USART_test.c,410 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,411 :: 		ctrl_reg &= 0xFD;
	MOVLW       253
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,412 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,413 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_Alarm2_Disable:
	RETURN      0
; end of _Alarm2_Disable

_Alarm2_IF_Check:

<<<<<<< HEAD
;USART_test.c,421 :: 		uint8_t Alarm2_IF_Check()
;USART_test.c,423 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,424 :: 		if(stat_reg & 0x02)
	BTFSS       R0, 1 
	GOTO        L_Alarm2_IF_Check10
;USART_test.c,425 :: 		return 1;
=======
;USART_test.c,416 :: 		uint8_t Alarm2_IF_Check()
;USART_test.c,418 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,419 :: 		if(stat_reg & 0x02)
	BTFSS       R0, 1 
	GOTO        L_Alarm2_IF_Check10
;USART_test.c,420 :: 		return 1;
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_Alarm2_IF_Check
L_Alarm2_IF_Check10:
<<<<<<< HEAD
;USART_test.c,427 :: 		return 0;
	CLRF        R0 
;USART_test.c,428 :: 		}
=======
;USART_test.c,422 :: 		return 0;
	CLRF        R0 
;USART_test.c,423 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_Alarm2_IF_Check:
	RETURN      0
; end of _Alarm2_IF_Check

_Alarm2_IF_Reset:

<<<<<<< HEAD
;USART_test.c,431 :: 		void Alarm2_IF_Reset()
;USART_test.c,433 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,434 :: 		stat_reg &= 0xFD;
	MOVLW       253
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,435 :: 		RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
	MOVLW       15
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,436 :: 		}
=======
;USART_test.c,426 :: 		void Alarm2_IF_Reset()
;USART_test.c,428 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,429 :: 		stat_reg &= 0xFD;
	MOVLW       253
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,430 :: 		RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
	MOVLW       15
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,431 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_Alarm2_IF_Reset:
	RETURN      0
; end of _Alarm2_IF_Reset

_Alarm2_Status:

<<<<<<< HEAD
;USART_test.c,439 :: 		uint8_t Alarm2_Status()
;USART_test.c,441 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,442 :: 		if(ctrl_reg & 0x02)
	BTFSS       R0, 1 
	GOTO        L_Alarm2_Status12
;USART_test.c,443 :: 		return 1;
=======
;USART_test.c,434 :: 		uint8_t Alarm2_Status()
;USART_test.c,436 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,437 :: 		if(ctrl_reg & 0x02)
	BTFSS       R0, 1 
	GOTO        L_Alarm2_Status12
;USART_test.c,438 :: 		return 1;
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_Alarm2_Status
L_Alarm2_Status12:
<<<<<<< HEAD
;USART_test.c,445 :: 		return 0;
	CLRF        R0 
;USART_test.c,446 :: 		}
=======
;USART_test.c,440 :: 		return 0;
	CLRF        R0 
;USART_test.c,441 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_Alarm2_Status:
	RETURN      0
; end of _Alarm2_Status

_RTC_Write_Reg:

<<<<<<< HEAD
;USART_test.c,449 :: 		void RTC_Write_Reg(uint8_t reg_address, uint8_t reg_value)
;USART_test.c,451 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;USART_test.c,452 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,453 :: 		RTC_I2C_WRITE(reg_address);
	MOVF        FARG_RTC_Write_Reg_reg_address+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,454 :: 		RTC_I2C_WRITE(reg_value);
	MOVF        FARG_RTC_Write_Reg_reg_value+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,455 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;USART_test.c,456 :: 		}
=======
;USART_test.c,444 :: 		void RTC_Write_Reg(uint8_t reg_address, uint8_t reg_value)
;USART_test.c,446 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;USART_test.c,447 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,448 :: 		RTC_I2C_WRITE(reg_address);
	MOVF        FARG_RTC_Write_Reg_reg_address+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,449 :: 		RTC_I2C_WRITE(reg_value);
	MOVF        FARG_RTC_Write_Reg_reg_value+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,450 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;USART_test.c,451 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_RTC_Write_Reg:
	RETURN      0
; end of _RTC_Write_Reg

_RTC_Read_Reg:

<<<<<<< HEAD
;USART_test.c,459 :: 		uint8_t RTC_Read_Reg(uint8_t reg_address)
;USART_test.c,463 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;USART_test.c,464 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,465 :: 		RTC_I2C_WRITE(reg_address);
	MOVF        FARG_RTC_Read_Reg_reg_address+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,466 :: 		RTC_I2C_RESTART();
	CALL        _I2C2_Repeated_Start+0, 0
;USART_test.c,467 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,468 :: 		reg_data = RTC_I2C_READ(0);
=======
;USART_test.c,454 :: 		uint8_t RTC_Read_Reg(uint8_t reg_address)
;USART_test.c,458 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;USART_test.c,459 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,460 :: 		RTC_I2C_WRITE(reg_address);
	MOVF        FARG_RTC_Read_Reg_reg_address+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,461 :: 		RTC_I2C_RESTART();
	CALL        _I2C2_Repeated_Start+0, 0
;USART_test.c,462 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,463 :: 		reg_data = RTC_I2C_READ(0);
>>>>>>> parent of 7a63acd... RTc library removed
	CLRF        FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       RTC_Read_Reg_reg_data_L0+0 
<<<<<<< HEAD
;USART_test.c,469 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;USART_test.c,471 :: 		return reg_data;
	MOVF        RTC_Read_Reg_reg_data_L0+0, 0 
	MOVWF       R0 
;USART_test.c,472 :: 		}
=======
;USART_test.c,464 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;USART_test.c,466 :: 		return reg_data;
	MOVF        RTC_Read_Reg_reg_data_L0+0, 0 
	MOVWF       R0 
;USART_test.c,467 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_RTC_Read_Reg:
	RETURN      0
; end of _RTC_Read_Reg

_IntSqw_Set:

<<<<<<< HEAD
;USART_test.c,475 :: 		void IntSqw_Set(INT_SQW _config)
;USART_test.c,477 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,478 :: 		ctrl_reg &= 0xA3;
	MOVLW       163
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,479 :: 		ctrl_reg |= _config;
	MOVF        FARG_IntSqw_Set__config+0, 0 
	IORWF       FARG_RTC_Write_Reg_reg_value+0, 1 
;USART_test.c,480 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,481 :: 		}
=======
;USART_test.c,470 :: 		void IntSqw_Set(INT_SQW _config)
;USART_test.c,472 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,473 :: 		ctrl_reg &= 0xA3;
	MOVLW       163
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,474 :: 		ctrl_reg |= _config;
	MOVF        FARG_IntSqw_Set__config+0, 0 
	IORWF       FARG_RTC_Write_Reg_reg_value+0, 1 
;USART_test.c,475 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,476 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_IntSqw_Set:
	RETURN      0
; end of _IntSqw_Set

_Enable_32kHZ:

<<<<<<< HEAD
;USART_test.c,484 :: 		void Enable_32kHZ()
;USART_test.c,486 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,487 :: 		stat_reg |= 0x08;
	MOVLW       8
	IORWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,488 :: 		RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
	MOVLW       15
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,489 :: 		}
=======
;USART_test.c,479 :: 		void Enable_32kHZ()
;USART_test.c,481 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,482 :: 		stat_reg |= 0x08;
	MOVLW       8
	IORWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,483 :: 		RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
	MOVLW       15
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,484 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_Enable_32kHZ:
	RETURN      0
; end of _Enable_32kHZ

_Disable_32kHZ:

<<<<<<< HEAD
;USART_test.c,492 :: 		void Disable_32kHZ()
;USART_test.c,494 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,495 :: 		stat_reg &= 0xF7;
	MOVLW       247
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,496 :: 		RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
	MOVLW       15
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,497 :: 		}
=======
;USART_test.c,487 :: 		void Disable_32kHZ()
;USART_test.c,489 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,490 :: 		stat_reg &= 0xF7;
	MOVLW       247
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,491 :: 		RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
	MOVLW       15
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,492 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_Disable_32kHZ:
	RETURN      0
; end of _Disable_32kHZ

_OSC_Start:

<<<<<<< HEAD
;USART_test.c,500 :: 		void OSC_Start()
;USART_test.c,502 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,503 :: 		ctrl_reg &= 0x7F;
	MOVLW       127
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,504 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,505 :: 		}
=======
;USART_test.c,495 :: 		void OSC_Start()
;USART_test.c,497 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,498 :: 		ctrl_reg &= 0x7F;
	MOVLW       127
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,499 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,500 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_OSC_Start:
	RETURN      0
; end of _OSC_Start

_OSC_Stop:

<<<<<<< HEAD
;USART_test.c,508 :: 		void OSC_Stop()
;USART_test.c,510 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,511 :: 		ctrl_reg |= 0x80;
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,512 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,513 :: 		}
=======
;USART_test.c,503 :: 		void OSC_Stop()
;USART_test.c,505 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;USART_test.c,506 :: 		ctrl_reg |= 0x80;
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;USART_test.c,507 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;USART_test.c,508 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_OSC_Stop:
	RETURN      0
; end of _OSC_Stop

_Get_Temperature:

<<<<<<< HEAD
;USART_test.c,517 :: 		int16_t Get_Temperature()
;USART_test.c,521 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;USART_test.c,522 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,523 :: 		RTC_I2C_WRITE(DS3231_REG_TEMP_MSB);
	MOVLW       17
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,524 :: 		RTC_I2C_RESTART();
	CALL        _I2C2_Repeated_Start+0, 0
;USART_test.c,525 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,526 :: 		t_msb = RTC_I2C_READ(1);
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
;USART_test.c,527 :: 		}
=======
;USART_test.c,512 :: 		int16_t Get_Temperature()
;USART_test.c,516 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;USART_test.c,517 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,518 :: 		RTC_I2C_WRITE(DS3231_REG_TEMP_MSB);
	MOVLW       17
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,519 :: 		RTC_I2C_RESTART();
	CALL        _I2C2_Repeated_Start+0, 0
;USART_test.c,520 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;USART_test.c,521 :: 		t_msb = RTC_I2C_READ(1);
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
;USART_test.c,522 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_Get_Temperature:
	RETURN      0
; end of _Get_Temperature

_main:

<<<<<<< HEAD
;USART_test.c,535 :: 		void main() {
;USART_test.c,537 :: 		OSCCON = 0b01110000;  // bit7: device enters SLEEP on sleep instruction[0]
	MOVLW       112
	MOVWF       OSCCON+0 
;USART_test.c,543 :: 		OSCTUNE = 0b00000000; // bit7:  device clock derived from the MFINTOSC or HFINTOSC source
	CLRF        OSCTUNE+0 
;USART_test.c,547 :: 		ANSELA = 0;      // configure all PORTA pins as analog for data logging
	CLRF        ANSELA+0 
;USART_test.c,548 :: 		ANSELB = 0;         // configure all PORTB pins as digital
	CLRF        ANSELB+0 
;USART_test.c,549 :: 		ANSELC = 0;         // configure all PORTC pins as digital
	CLRF        ANSELC+0 
;USART_test.c,550 :: 		ANSELD = 0;         // configure all PORTD pins as digital
	CLRF        ANSELD+0 
;USART_test.c,551 :: 		T0CON  = 0x04;      // configure Timer0 module (16-bit timer & prescaler = 32)
	MOVLW       4
	MOVWF       T0CON+0 
;USART_test.c,556 :: 		ADC_Init_Advanced(_ADC_INTERNAL_VREFL | _ADC_INTERNAL_FVRH1);
	MOVLW       24
	MOVWF       FARG_ADC_Init_Advanced_reference+0 
	CALL        _ADC_Init_Advanced+0, 0
;USART_test.c,557 :: 		delay_ms(1000);     // wait a second
=======
;USART_test.c,532 :: 		void main() {
;USART_test.c,534 :: 		OSCCON = 0b01110000;  // bit7: device enters SLEEP on sleep instruction[0]
	MOVLW       112
	MOVWF       OSCCON+0 
;USART_test.c,540 :: 		OSCTUNE = 0b00000000; // bit7:  device clock derived from the MFINTOSC or HFINTOSC source
	CLRF        OSCTUNE+0 
;USART_test.c,544 :: 		ANSELA = 0;      // configure all PORTA pins as analog for data logging
	CLRF        ANSELA+0 
;USART_test.c,545 :: 		ANSELC = 0;         // configure all PORTC pins as digital
	CLRF        ANSELC+0 
;USART_test.c,546 :: 		ANSELD = 0;         // configure all PORTD pins as digital
	CLRF        ANSELD+0 
;USART_test.c,551 :: 		ADC_Init_Advanced(_ADC_INTERNAL_VREFL | _ADC_INTERNAL_FVRH1);
	MOVLW       24
	MOVWF       FARG_ADC_Init_Advanced_reference+0 
	CALL        _ADC_Init_Advanced+0, 0
;USART_test.c,552 :: 		delay_ms(1000);     // wait a second
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main14:
	DECFSZ      R13, 1, 1
	BRA         L_main14
	DECFSZ      R12, 1, 1
	BRA         L_main14
	DECFSZ      R11, 1, 1
	BRA         L_main14
	NOP
<<<<<<< HEAD
;USART_test.c,560 :: 		I2C2_Init(400000);
	MOVLW       10
	MOVWF       SSP2ADD+0 
	CALL        _I2C2_Init+0, 0
;USART_test.c,562 :: 		logging_Init();
	CALL        _logging_Init+0, 0
;USART_test.c,564 :: 		mytime->day   = '1' ;
	MOVLW       4
	ADDWF       _mytime+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       49
	MOVWF       POSTINC1+0 
;USART_test.c,565 :: 		mytime->month = '2'  ;
	MOVLW       5
	ADDWF       _mytime+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       50
	MOVWF       POSTINC1+0 
;USART_test.c,566 :: 		mytime->year  = '3' ;
	MOVLW       6
	ADDWF       _mytime+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       51
	MOVWF       POSTINC1+0 
;USART_test.c,567 :: 		mytime->hours   = '1' ;
	MOVLW       2
	ADDWF       _mytime+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       49
	MOVWF       POSTINC1+0 
;USART_test.c,568 :: 		mytime->minutes = '2'  ;
	MOVLW       1
	ADDWF       _mytime+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       50
	MOVWF       POSTINC1+0 
;USART_test.c,569 :: 		mytime->seconds  = '3' ;
	MOVFF       _mytime+0, FSR1L+0
	MOVFF       _mytime+1, FSR1H+0
	MOVLW       51
	MOVWF       POSTINC1+0 
;USART_test.c,570 :: 		RTC_Set(mytime);
	MOVF        _mytime+0, 0 
	MOVWF       FARG_RTC_Set_time_t+0 
	MOVF        _mytime+1, 0 
	MOVWF       FARG_RTC_Set_time_t+1 
	CALL        _RTC_Set+0, 0
;USART_test.c,574 :: 		while(1){
L_main15:
;USART_test.c,576 :: 		ReadADC_and_Log();
	CALL        _ReadADC_and_Log+0, 0
;USART_test.c,578 :: 		mytime = RTC_Get();
	CALL        _RTC_Get+0, 0
	MOVF        R0, 0 
	MOVWF       _mytime+0 
	MOVF        R1, 0 
	MOVWF       _mytime+1 
;USART_test.c,579 :: 		UART1_Write_Text(mytime->hours);
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       0
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	MOVLW       0
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;USART_test.c,601 :: 		}
	GOTO        L_main15
;USART_test.c,602 :: 		}
=======
;USART_test.c,554 :: 		logging_Init();
	CALL        _logging_Init+0, 0
;USART_test.c,557 :: 		while(1){
L_main15:
;USART_test.c,558 :: 		mytime = RTC_Get();
	CALL        _RTC_Get+0, 0
	MOVF        R0, 0 
	MOVWF       _mytime+0 
	MOVF        R1, 0 
	MOVWF       _mytime+1 
;USART_test.c,559 :: 		ReadADC_and_Log();
	CALL        _ReadADC_and_Log+0, 0
;USART_test.c,581 :: 		}
	GOTO        L_main15
;USART_test.c,582 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_main:
	GOTO        $+0
; end of _main

_ReadADC_and_Log:

<<<<<<< HEAD
;USART_test.c,604 :: 		void ReadADC_and_Log(){
;USART_test.c,610 :: 		R0 = ADC_Get_Sample(0);
=======
;USART_test.c,584 :: 		void ReadADC_and_Log(){
;USART_test.c,590 :: 		R0 = ADC_Get_Sample(0);
>>>>>>> parent of 7a63acd... RTc library removed
	CLRF        FARG_ADC_Get_Sample_channel+0 
	CALL        _ADC_Get_Sample+0, 0
	MOVF        R0, 0 
	MOVWF       ReadADC_and_Log_R0_L0+0 
	MOVF        R1, 0 
	MOVWF       ReadADC_and_Log_R0_L0+1 
<<<<<<< HEAD
;USART_test.c,611 :: 		R1 = ADC_Get_Sample(1);
=======
;USART_test.c,591 :: 		R1 = ADC_Get_Sample(1);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       1
	MOVWF       FARG_ADC_Get_Sample_channel+0 
	CALL        _ADC_Get_Sample+0, 0
	MOVF        R0, 0 
	MOVWF       ReadADC_and_Log_R1_L0+0 
	MOVF        R1, 0 
	MOVWF       ReadADC_and_Log_R1_L0+1 
<<<<<<< HEAD
;USART_test.c,612 :: 		WordToStr(R0, R0_);
=======
;USART_test.c,592 :: 		WordToStr(R0, R0_);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        ReadADC_and_Log_R0_L0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        ReadADC_and_Log_R0_L0+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       ReadADC_and_Log_R0__L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(ReadADC_and_Log_R0__L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
<<<<<<< HEAD
;USART_test.c,613 :: 		WordToStr(R1, R1_);
=======
;USART_test.c,593 :: 		WordToStr(R1, R1_);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        ReadADC_and_Log_R1_L0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        ReadADC_and_Log_R1_L0+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       ReadADC_and_Log_R1__L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(ReadADC_and_Log_R1__L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
<<<<<<< HEAD
;USART_test.c,615 :: 		Delay_ms(1000);
=======
;USART_test.c,595 :: 		Delay_ms(1000);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_ReadADC_and_Log17:
	DECFSZ      R13, 1, 1
	BRA         L_ReadADC_and_Log17
	DECFSZ      R12, 1, 1
	BRA         L_ReadADC_and_Log17
	DECFSZ      R11, 1, 1
	BRA         L_ReadADC_and_Log17
	NOP
<<<<<<< HEAD
;USART_test.c,619 :: 		fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
=======
;USART_test.c,599 :: 		fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       ?lstr1_USART_test+0
	MOVWF       FARG_FAT32_Open_fn+0 
	MOVLW       hi_addr(?lstr1_USART_test+0)
	MOVWF       FARG_FAT32_Open_fn+1 
	MOVLW       4
	MOVWF       FARG_FAT32_Open_mode+0 
	CALL        _FAT32_Open+0, 0
	MOVF        R0, 0 
	MOVWF       _fileHandle+0 
<<<<<<< HEAD
;USART_test.c,621 :: 		UART1_Write_Text("\n");
=======
;USART_test.c,601 :: 		UART1_Write_Text("\n");
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       ?lstr2_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
<<<<<<< HEAD
;USART_test.c,622 :: 		UART1_Write_Text(R0_);
=======
;USART_test.c,602 :: 		UART1_Write_Text(R0_);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       ReadADC_and_Log_R0__L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(ReadADC_and_Log_R0__L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
<<<<<<< HEAD
;USART_test.c,623 :: 		UART1_Write_Text("\t");
=======
;USART_test.c,603 :: 		UART1_Write_Text("\t");
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       ?lstr3_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
<<<<<<< HEAD
;USART_test.c,624 :: 		UART1_Write_Text(R1_);
=======
;USART_test.c,604 :: 		UART1_Write_Text(R1_);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       ReadADC_and_Log_R1__L0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(ReadADC_and_Log_R1__L0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
<<<<<<< HEAD
;USART_test.c,626 :: 		i = FAT32_Write(fileHandle, "\r\n", 6);
=======
;USART_test.c,606 :: 		i = FAT32_Write(fileHandle, "\r\n", 6);
>>>>>>> parent of 7a63acd... RTc library removed
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
<<<<<<< HEAD
;USART_test.c,627 :: 		i = FAT32_Write(fileHandle, R0_, 6);
=======
;USART_test.c,607 :: 		i = FAT32_Write(fileHandle, R0_, 6);
>>>>>>> parent of 7a63acd... RTc library removed
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
<<<<<<< HEAD
;USART_test.c,629 :: 		i = FAT32_Write(fileHandle, R1_, 6);
=======
;USART_test.c,609 :: 		i = FAT32_Write(fileHandle, R1_, 6);
>>>>>>> parent of 7a63acd... RTc library removed
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
<<<<<<< HEAD
;USART_test.c,636 :: 		i = FAT32_Close(fileHandle);
=======
;USART_test.c,616 :: 		i = FAT32_Close(fileHandle);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Close_fHandle+0 
	CALL        _FAT32_Close+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
<<<<<<< HEAD
;USART_test.c,639 :: 		delay_ms(5000);     // wait 5 seconds
=======
;USART_test.c,619 :: 		delay_ms(5000);     // wait 5 seconds
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       102
	MOVWF       R11, 0
	MOVLW       118
	MOVWF       R12, 0
	MOVLW       193
	MOVWF       R13, 0
L_ReadADC_and_Log18:
	DECFSZ      R13, 1, 1
	BRA         L_ReadADC_and_Log18
	DECFSZ      R12, 1, 1
	BRA         L_ReadADC_and_Log18
	DECFSZ      R11, 1, 1
	BRA         L_ReadADC_and_Log18
<<<<<<< HEAD
;USART_test.c,640 :: 		}
=======
;USART_test.c,620 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_ReadADC_and_Log:
	RETURN      0
; end of _ReadADC_and_Log

_logging_Init:

<<<<<<< HEAD
;USART_test.c,643 :: 		void logging_Init(){
;USART_test.c,645 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
=======
;USART_test.c,623 :: 		void logging_Init(){
;USART_test.c,625 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       2
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
<<<<<<< HEAD
;USART_test.c,647 :: 		UART1_Init(9600);   // initialize UART1 module at 9600 baud
=======
;USART_test.c,627 :: 		UART1_Init(9600);   // initialize UART1 module at 9600 baud
>>>>>>> parent of 7a63acd... RTc library removed
	BSF         BAUDCON+0, 3, 0
	MOVLW       1
	MOVWF       SPBRGH+0 
	MOVLW       160
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
<<<<<<< HEAD
;USART_test.c,649 :: 		UART1_Write_Text("\r\n\nInitialize FAT library ... ");
=======
;USART_test.c,629 :: 		UART1_Write_Text("\r\n\nInitialize FAT library ... ");
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       ?lstr5_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr5_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
<<<<<<< HEAD
;USART_test.c,650 :: 		delay_ms(1000);     // wait 2 secods
=======
;USART_test.c,630 :: 		delay_ms(1000);     // wait 2 secods
>>>>>>> parent of 7a63acd... RTc library removed
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
<<<<<<< HEAD
;USART_test.c,653 :: 		i = FAT32_Init();
	CALL        _FAT32_Init+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,654 :: 		if(i != 0)
=======
;USART_test.c,633 :: 		i = FAT32_Init();
	CALL        _FAT32_Init+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
;USART_test.c,634 :: 		if(i != 0)
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_logging_Init20
<<<<<<< HEAD
;USART_test.c,656 :: 		UART1_Write_Text("Error initializing FAT library (SD card missing?)!");
=======
;USART_test.c,636 :: 		UART1_Write_Text("Error initializing FAT library (SD card missing?)!");
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       ?lstr6_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
<<<<<<< HEAD
;USART_test.c,657 :: 		}
	GOTO        L_logging_Init21
L_logging_Init20:
;USART_test.c,662 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
=======
;USART_test.c,637 :: 		}
	GOTO        L_logging_Init21
L_logging_Init20:
;USART_test.c,642 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
>>>>>>> parent of 7a63acd... RTc library removed
	CLRF        FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
<<<<<<< HEAD
;USART_test.c,663 :: 		UART1_Write_Text("FAT Library initialized");
=======
;USART_test.c,643 :: 		UART1_Write_Text("FAT Library initialized");
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       ?lstr7_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr7_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
<<<<<<< HEAD
;USART_test.c,664 :: 		delay_ms(1000);     // wait 2 seconds
=======
;USART_test.c,644 :: 		delay_ms(1000);     // wait 2 seconds
>>>>>>> parent of 7a63acd... RTc library removed
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
<<<<<<< HEAD
;USART_test.c,678 :: 		UART1_Write_Text("\r\n\r\nWrite test code to file :  This_is_a_text_file_created_using_PIC18F46K22_microcontroller");
=======
;USART_test.c,658 :: 		UART1_Write_Text("\r\n\r\nWrite test code to file :  This_is_a_text_file_created_using_PIC18F46K22_microcontroller");
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       ?lstr8_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr8_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
<<<<<<< HEAD
;USART_test.c,679 :: 		fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
=======
;USART_test.c,659 :: 		fileHandle = FAT32_Open("Log.txt", FILE_APPEND);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       ?lstr9_USART_test+0
	MOVWF       FARG_FAT32_Open_fn+0 
	MOVLW       hi_addr(?lstr9_USART_test+0)
	MOVWF       FARG_FAT32_Open_fn+1 
	MOVLW       4
	MOVWF       FARG_FAT32_Open_mode+0 
	CALL        _FAT32_Open+0, 0
	MOVF        R0, 0 
	MOVWF       _fileHandle+0 
<<<<<<< HEAD
;USART_test.c,690 :: 		i = FAT32_Write(fileHandle, "\r\nThis_is_a_text_file_created_using_PIC18F46K22_microcontroller_and_mikroC_compiler.\r\n", 113);
=======
;USART_test.c,670 :: 		i = FAT32_Write(fileHandle, "\r\nThis_is_a_text_file_created_using_PIC18F46K22_microcontroller_and_mikroC_compiler.\r\n", 113);
>>>>>>> parent of 7a63acd... RTc library removed
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
	MOVWF       _i+0 
<<<<<<< HEAD
;USART_test.c,698 :: 		delay_ms(1000);     // wait 2 seconds
=======
;USART_test.c,678 :: 		delay_ms(1000);     // wait 2 seconds
>>>>>>> parent of 7a63acd... RTc library removed
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
<<<<<<< HEAD
;USART_test.c,701 :: 		i = FAT32_Close(fileHandle);
=======
;USART_test.c,681 :: 		i = FAT32_Close(fileHandle);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Close_fHandle+0 
	CALL        _FAT32_Close+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
<<<<<<< HEAD
;USART_test.c,711 :: 		UART1_Write_Text("\r\n\r\nReading first line of file:");
=======
;USART_test.c,691 :: 		UART1_Write_Text("\r\n\r\nReading first line of file:");
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       ?lstr11_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr11_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
<<<<<<< HEAD
;USART_test.c,712 :: 		delay_ms(1000);     // wait 2 seconds
=======
;USART_test.c,692 :: 		delay_ms(1000);     // wait 2 seconds
>>>>>>> parent of 7a63acd... RTc library removed
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
<<<<<<< HEAD
;USART_test.c,715 :: 		UART1_Write_Text("\r\nOpen file ... ");
=======
;USART_test.c,695 :: 		UART1_Write_Text("\r\nOpen file ... ");
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       ?lstr12_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr12_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
<<<<<<< HEAD
;USART_test.c,716 :: 		fileHandle = FAT32_Open("Log.txt", FILE_READ);
=======
;USART_test.c,696 :: 		fileHandle = FAT32_Open("Log.txt", FILE_READ);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       ?lstr13_USART_test+0
	MOVWF       FARG_FAT32_Open_fn+0 
	MOVLW       hi_addr(?lstr13_USART_test+0)
	MOVWF       FARG_FAT32_Open_fn+1 
	MOVLW       1
	MOVWF       FARG_FAT32_Open_mode+0 
	CALL        _FAT32_Open+0, 0
	MOVF        R0, 0 
	MOVWF       _fileHandle+0 
<<<<<<< HEAD
;USART_test.c,717 :: 		if(fileHandle != 0)
=======
;USART_test.c,697 :: 		if(fileHandle != 0)
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_logging_Init25
<<<<<<< HEAD
;USART_test.c,718 :: 		UART1_Write_Text("error opening file");
=======
;USART_test.c,698 :: 		UART1_Write_Text("error opening file");
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       ?lstr14_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr14_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	GOTO        L_logging_Init26
L_logging_Init25:
<<<<<<< HEAD
;USART_test.c,724 :: 		UART1_Write_Text("\r\nPrint file:\r\n\r");
=======
;USART_test.c,704 :: 		UART1_Write_Text("\r\nPrint file:\r\n\r");
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       ?lstr15_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr15_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
<<<<<<< HEAD
;USART_test.c,725 :: 		delay_ms(1000);     // wait 2 seconds
=======
;USART_test.c,705 :: 		delay_ms(1000);     // wait 2 seconds
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_logging_Init27:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init27
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init27
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init27
	NOP
<<<<<<< HEAD
;USART_test.c,727 :: 		FAT32_Read(fileHandle, buffer, 113);
=======
;USART_test.c,707 :: 		FAT32_Read(fileHandle, buffer, 113);
>>>>>>> parent of 7a63acd... RTc library removed
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
<<<<<<< HEAD
;USART_test.c,729 :: 		UART1_Write_Text(buffer);
=======
;USART_test.c,709 :: 		UART1_Write_Text(buffer);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       _buffer+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
<<<<<<< HEAD
;USART_test.c,731 :: 		delay_ms(1000);     // wait 2 seconds
=======
;USART_test.c,711 :: 		delay_ms(1000);     // wait 2 seconds
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_logging_Init28:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init28
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init28
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init28
	NOP
<<<<<<< HEAD
;USART_test.c,733 :: 		UART1_Write_Text("\r\n\r\nClosing the file ... ");
=======
;USART_test.c,713 :: 		UART1_Write_Text("\r\n\r\nClosing the file ... ");
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       ?lstr16_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr16_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
<<<<<<< HEAD
;USART_test.c,734 :: 		i = FAT32_Close(fileHandle);
=======
;USART_test.c,714 :: 		i = FAT32_Close(fileHandle);
>>>>>>> parent of 7a63acd... RTc library removed
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Close_fHandle+0 
	CALL        _FAT32_Close+0, 0
	MOVF        R0, 0 
	MOVWF       _i+0 
<<<<<<< HEAD
;USART_test.c,743 :: 		}
L_logging_Init26:
;USART_test.c,744 :: 		}
L_logging_Init21:
;USART_test.c,746 :: 		delay_ms(1000);     // wait 2 seconds
=======
;USART_test.c,723 :: 		}
L_logging_Init26:
;USART_test.c,724 :: 		}
L_logging_Init21:
;USART_test.c,726 :: 		delay_ms(1000);     // wait 2 seconds
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_logging_Init29:
	DECFSZ      R13, 1, 1
	BRA         L_logging_Init29
	DECFSZ      R12, 1, 1
	BRA         L_logging_Init29
	DECFSZ      R11, 1, 1
	BRA         L_logging_Init29
	NOP
<<<<<<< HEAD
;USART_test.c,747 :: 		UART1_Write_Text("\r\n\r\n***** END OF INITIALISATION *****\r\n\r\n");
=======
;USART_test.c,727 :: 		UART1_Write_Text("\r\n\r\n***** END OF INITIALISATION *****\r\n\r\n");
>>>>>>> parent of 7a63acd... RTc library removed
	MOVLW       ?lstr17_USART_test+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr17_USART_test+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
<<<<<<< HEAD
;USART_test.c,748 :: 		}
=======
;USART_test.c,728 :: 		}
>>>>>>> parent of 7a63acd... RTc library removed
L_end_logging_Init:
	RETURN      0
; end of _logging_Init
