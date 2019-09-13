
_bcd_to_decimal:

;DS3231.c,152 :: 		uint8_t bcd_to_decimal(uint8_t number)
;DS3231.c,154 :: 		return ( (number >> 4) * 10 + (number & 0x0F) );
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
;DS3231.c,155 :: 		}
L_end_bcd_to_decimal:
	RETURN      0
; end of _bcd_to_decimal

_decimal_to_bcd:

;DS3231.c,158 :: 		uint8_t decimal_to_bcd(uint8_t number)
;DS3231.c,160 :: 		return ( ((number / 10) << 4) + (number % 10) );
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
;DS3231.c,161 :: 		}
L_end_decimal_to_bcd:
	RETURN      0
; end of _decimal_to_bcd

_alarm_cfg:

;DS3231.c,164 :: 		uint8_t alarm_cfg(uint8_t n, uint8_t i)
;DS3231.c,166 :: 		if( n & (1 << i) )
	MOVF        FARG_alarm_cfg_i+0, 0 
	MOVWF       R2 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__alarm_cfg18:
	BZ          L__alarm_cfg19
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__alarm_cfg18
L__alarm_cfg19:
	MOVF        FARG_alarm_cfg_n+0, 0 
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm_cfg0
;DS3231.c,167 :: 		return 0x80;
	MOVLW       128
	MOVWF       R0 
	GOTO        L_end_alarm_cfg
L_alarm_cfg0:
;DS3231.c,169 :: 		return 0;
	CLRF        R0 
;DS3231.c,170 :: 		}
L_end_alarm_cfg:
	RETURN      0
; end of _alarm_cfg

_RTC_Set:

;DS3231.c,173 :: 		void RTC_Set(RTC_Time *time_t)
;DS3231.c,176 :: 		time_t->day     = decimal_to_bcd(time_t->day);
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
;DS3231.c,177 :: 		time_t->month   = decimal_to_bcd(time_t->month);
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
;DS3231.c,178 :: 		time_t->year    = decimal_to_bcd(time_t->year);
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
;DS3231.c,179 :: 		time_t->hours   = decimal_to_bcd(time_t->hours);
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
;DS3231.c,180 :: 		time_t->minutes = decimal_to_bcd(time_t->minutes);
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
;DS3231.c,181 :: 		time_t->seconds = decimal_to_bcd(time_t->seconds);
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
;DS3231.c,185 :: 		RTC_I2C_START();
	CALL        _I2C1_Start+0, 0
;DS3231.c,186 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,187 :: 		RTC_I2C_WRITE(DS3231_REG_SECONDS);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,188 :: 		RTC_I2C_WRITE(time_t->seconds);
	MOVFF       FARG_RTC_Set_time_t+0, FSR0L+0
	MOVFF       FARG_RTC_Set_time_t+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,189 :: 		RTC_I2C_WRITE(time_t->minutes);
	MOVLW       1
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,190 :: 		RTC_I2C_WRITE(time_t->hours);
	MOVLW       2
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,191 :: 		RTC_I2C_WRITE(time_t->dow);
	MOVLW       3
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,192 :: 		RTC_I2C_WRITE(time_t->day);
	MOVLW       4
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,193 :: 		RTC_I2C_WRITE(time_t->month);
	MOVLW       5
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,194 :: 		RTC_I2C_WRITE(time_t->year);
	MOVLW       6
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,195 :: 		RTC_I2C_STOP();
	CALL        _I2C1_Stop+0, 0
;DS3231.c,196 :: 		}
L_end_RTC_Set:
	RETURN      0
; end of _RTC_Set

_RTC_Get:

;DS3231.c,199 :: 		RTC_Time *RTC_Get()
;DS3231.c,201 :: 		RTC_I2C_START();
	CALL        _I2C1_Start+0, 0
;DS3231.c,202 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,203 :: 		RTC_I2C_WRITE(DS3231_REG_SECONDS);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,204 :: 		RTC_I2C_RESTART();
	CALL        _I2C1_Repeated_Start+0, 0
;DS3231.c,205 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,206 :: 		c_time.seconds = RTC_I2C_READ(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+0 
;DS3231.c,207 :: 		c_time.minutes = RTC_I2C_READ(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+1 
;DS3231.c,208 :: 		c_time.hours   = RTC_I2C_READ(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+2 
;DS3231.c,209 :: 		c_time.dow   = RTC_I2C_READ(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+3 
;DS3231.c,210 :: 		c_time.day   = RTC_I2C_READ(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+4 
;DS3231.c,211 :: 		c_time.month = RTC_I2C_READ(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+5 
;DS3231.c,212 :: 		c_time.year  = RTC_I2C_READ(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+6 
;DS3231.c,213 :: 		RTC_I2C_STOP();
	CALL        _I2C1_Stop+0, 0
;DS3231.c,216 :: 		c_time.seconds = bcd_to_decimal(c_time.seconds);
	MOVF        _c_time+0, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+0 
;DS3231.c,217 :: 		c_time.minutes = bcd_to_decimal(c_time.minutes);
	MOVF        _c_time+1, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+1 
;DS3231.c,218 :: 		c_time.hours   = bcd_to_decimal(c_time.hours);
	MOVF        _c_time+2, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+2 
;DS3231.c,219 :: 		c_time.day     = bcd_to_decimal(c_time.day);
	MOVF        _c_time+4, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+4 
;DS3231.c,220 :: 		c_time.month   = bcd_to_decimal(c_time.month);
	MOVF        _c_time+5, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+5 
;DS3231.c,221 :: 		c_time.year    = bcd_to_decimal(c_time.year);
	MOVF        _c_time+6, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+6 
;DS3231.c,224 :: 		return &c_time;
	MOVLW       _c_time+0
	MOVWF       R0 
	MOVLW       hi_addr(_c_time+0)
	MOVWF       R1 
;DS3231.c,225 :: 		}
L_end_RTC_Get:
	RETURN      0
; end of _RTC_Get

_Alarm1_Set:

;DS3231.c,228 :: 		void Alarm1_Set(RTC_Time *time_t, al1 _config)
;DS3231.c,231 :: 		time_t->day     = decimal_to_bcd(time_t->day);
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
;DS3231.c,232 :: 		time_t->hours   = decimal_to_bcd(time_t->hours);
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
;DS3231.c,233 :: 		time_t->minutes = decimal_to_bcd(time_t->minutes);
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
;DS3231.c,234 :: 		time_t->seconds = decimal_to_bcd(time_t->seconds);
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
;DS3231.c,238 :: 		RTC_I2C_START();
	CALL        _I2C1_Start+0, 0
;DS3231.c,239 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,240 :: 		RTC_I2C_WRITE(DS3231_REG_AL1_SEC);
	MOVLW       7
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,241 :: 		RTC_I2C_WRITE( time_t->seconds | alarm_cfg(_config, 0) );
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
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,242 :: 		RTC_I2C_WRITE( time_t->minutes | alarm_cfg(_config, 1) );
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
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,243 :: 		RTC_I2C_WRITE( time_t->hours   | alarm_cfg(_config, 2) );
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
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,244 :: 		if ( _config & 0x10 )
	BTFSS       FARG_Alarm1_Set__config+0, 4 
	GOTO        L_Alarm1_Set2
;DS3231.c,245 :: 		RTC_I2C_WRITE( time_t->dow | 0x40 | alarm_cfg(_config, 3) );
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
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
	GOTO        L_Alarm1_Set3
L_Alarm1_Set2:
;DS3231.c,247 :: 		RTC_I2C_WRITE( time_t->day | alarm_cfg(_config, 3) );
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
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
L_Alarm1_Set3:
;DS3231.c,248 :: 		RTC_I2C_STOP();
	CALL        _I2C1_Stop+0, 0
;DS3231.c,249 :: 		}
L_end_Alarm1_Set:
	RETURN      0
; end of _Alarm1_Set

_Alarm1_Get:

;DS3231.c,252 :: 		RTC_Time *Alarm1_Get()
;DS3231.c,254 :: 		RTC_I2C_START();
	CALL        _I2C1_Start+0, 0
;DS3231.c,255 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,256 :: 		RTC_I2C_WRITE(DS3231_REG_AL1_SEC);
	MOVLW       7
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,257 :: 		RTC_I2C_RESTART();
	CALL        _I2C1_Repeated_Start+0, 0
;DS3231.c,258 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,259 :: 		c_alarm1.seconds = RTC_I2C_READ(1) & 0x7F;
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVLW       127
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm1+0 
;DS3231.c,260 :: 		c_alarm1.minutes = RTC_I2C_READ(1) & 0x7F;
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVLW       127
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm1+1 
;DS3231.c,261 :: 		c_alarm1.hours   = RTC_I2C_READ(1) & 0x3F;
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVLW       63
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm1+2 
;DS3231.c,262 :: 		c_alarm1.dow = c_alarm1.day = RTC_I2C_READ(0) & 0x3F;
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVLW       63
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm1+4 
	MOVF        R0, 0 
	MOVWF       _c_alarm1+3 
;DS3231.c,263 :: 		RTC_I2C_STOP();
	CALL        _I2C1_Stop+0, 0
;DS3231.c,266 :: 		c_alarm1.seconds = bcd_to_decimal(c_alarm1.seconds);
	MOVF        _c_alarm1+0, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm1+0 
;DS3231.c,267 :: 		c_alarm1.minutes = bcd_to_decimal(c_alarm1.minutes);
	MOVF        _c_alarm1+1, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm1+1 
;DS3231.c,268 :: 		c_alarm1.hours   = bcd_to_decimal(c_alarm1.hours);
	MOVF        _c_alarm1+2, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm1+2 
;DS3231.c,269 :: 		c_alarm1.day     = bcd_to_decimal(c_alarm1.day);
	MOVF        _c_alarm1+4, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm1+4 
;DS3231.c,272 :: 		return &c_alarm1;
	MOVLW       _c_alarm1+0
	MOVWF       R0 
	MOVLW       hi_addr(_c_alarm1+0)
	MOVWF       R1 
;DS3231.c,273 :: 		}
L_end_Alarm1_Get:
	RETURN      0
; end of _Alarm1_Get

_Alarm1_Enable:

;DS3231.c,276 :: 		void Alarm1_Enable()
;DS3231.c,278 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;DS3231.c,279 :: 		ctrl_reg |= 0x01;
	MOVLW       1
	IORWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;DS3231.c,280 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;DS3231.c,281 :: 		}
L_end_Alarm1_Enable:
	RETURN      0
; end of _Alarm1_Enable

_Alarm1_Disable:

;DS3231.c,284 :: 		void Alarm1_Disable()
;DS3231.c,286 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;DS3231.c,287 :: 		ctrl_reg &= 0xFE;
	MOVLW       254
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;DS3231.c,288 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;DS3231.c,289 :: 		}
L_end_Alarm1_Disable:
	RETURN      0
; end of _Alarm1_Disable

_Alarm1_IF_Check:

;DS3231.c,292 :: 		uint8_t Alarm1_IF_Check()
;DS3231.c,294 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;DS3231.c,295 :: 		if(stat_reg & 0x01)
	BTFSS       R0, 0 
	GOTO        L_Alarm1_IF_Check4
;DS3231.c,296 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_Alarm1_IF_Check
L_Alarm1_IF_Check4:
;DS3231.c,298 :: 		return 0;
	CLRF        R0 
;DS3231.c,299 :: 		}
L_end_Alarm1_IF_Check:
	RETURN      0
; end of _Alarm1_IF_Check

_Alarm1_IF_Reset:

;DS3231.c,302 :: 		void Alarm1_IF_Reset()
;DS3231.c,304 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;DS3231.c,305 :: 		stat_reg &= 0xFE;
	MOVLW       254
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;DS3231.c,306 :: 		RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
	MOVLW       15
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;DS3231.c,307 :: 		}
L_end_Alarm1_IF_Reset:
	RETURN      0
; end of _Alarm1_IF_Reset

_Alarm1_Status:

;DS3231.c,310 :: 		uint8_t Alarm1_Status()
;DS3231.c,312 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;DS3231.c,313 :: 		if(ctrl_reg & 0x01)
	BTFSS       R0, 0 
	GOTO        L_Alarm1_Status6
;DS3231.c,314 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_Alarm1_Status
L_Alarm1_Status6:
;DS3231.c,316 :: 		return 0;
	CLRF        R0 
;DS3231.c,317 :: 		}
L_end_Alarm1_Status:
	RETURN      0
; end of _Alarm1_Status

_Alarm2_Set:

;DS3231.c,320 :: 		void Alarm2_Set(RTC_Time *time_t, al2 _config)
;DS3231.c,323 :: 		time_t->day     = decimal_to_bcd(time_t->day);
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
;DS3231.c,324 :: 		time_t->hours   = decimal_to_bcd(time_t->hours);
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
;DS3231.c,325 :: 		time_t->minutes = decimal_to_bcd(time_t->minutes);
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
;DS3231.c,329 :: 		RTC_I2C_START();
	CALL        _I2C1_Start+0, 0
;DS3231.c,330 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,331 :: 		RTC_I2C_WRITE(DS3231_REG_AL2_MIN);
	MOVLW       11
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,332 :: 		RTC_I2C_WRITE( (time_t->minutes) | alarm_cfg(_config, 1) );
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
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,333 :: 		RTC_I2C_WRITE( (time_t->hours) | alarm_cfg(_config, 2) );
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
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,334 :: 		if ( _config & 0x10 )
	BTFSS       FARG_Alarm2_Set__config+0, 4 
	GOTO        L_Alarm2_Set8
;DS3231.c,335 :: 		RTC_I2C_WRITE( time_t->dow | 0x40 | alarm_cfg(_config, 3) );
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
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
	GOTO        L_Alarm2_Set9
L_Alarm2_Set8:
;DS3231.c,337 :: 		RTC_I2C_WRITE( time_t->day | alarm_cfg(_config, 3) );
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
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
L_Alarm2_Set9:
;DS3231.c,338 :: 		RTC_I2C_STOP();
	CALL        _I2C1_Stop+0, 0
;DS3231.c,339 :: 		}
L_end_Alarm2_Set:
	RETURN      0
; end of _Alarm2_Set

_Alarm2_Get:

;DS3231.c,342 :: 		RTC_Time *Alarm2_Get()
;DS3231.c,344 :: 		RTC_I2C_START();
	CALL        _I2C1_Start+0, 0
;DS3231.c,345 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,346 :: 		RTC_I2C_WRITE(DS3231_REG_AL2_MIN);
	MOVLW       11
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,347 :: 		RTC_I2C_RESTART();
	CALL        _I2C1_Repeated_Start+0, 0
;DS3231.c,348 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,349 :: 		c_alarm2.minutes = RTC_I2C_READ(1) & 0x7F;
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVLW       127
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm2+1 
;DS3231.c,350 :: 		c_alarm2.hours   = RTC_I2C_READ(1) & 0x3F;
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVLW       63
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm2+2 
;DS3231.c,351 :: 		c_alarm2.dow = c_alarm2.day = RTC_I2C_READ(0) & 0x3F;
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVLW       63
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm2+4 
	MOVF        R0, 0 
	MOVWF       _c_alarm2+3 
;DS3231.c,352 :: 		RTC_I2C_STOP();
	CALL        _I2C1_Stop+0, 0
;DS3231.c,355 :: 		c_alarm2.minutes = bcd_to_decimal(c_alarm2.minutes);
	MOVF        _c_alarm2+1, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm2+1 
;DS3231.c,356 :: 		c_alarm2.hours   = bcd_to_decimal(c_alarm2.hours);
	MOVF        _c_alarm2+2, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm2+2 
;DS3231.c,357 :: 		c_alarm2.day     = bcd_to_decimal(c_alarm2.day);
	MOVF        _c_alarm2+4, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm2+4 
;DS3231.c,359 :: 		c_alarm2.seconds = 0;
	CLRF        _c_alarm2+0 
;DS3231.c,360 :: 		return &c_alarm2;
	MOVLW       _c_alarm2+0
	MOVWF       R0 
	MOVLW       hi_addr(_c_alarm2+0)
	MOVWF       R1 
;DS3231.c,361 :: 		}
L_end_Alarm2_Get:
	RETURN      0
; end of _Alarm2_Get

_Alarm2_Enable:

;DS3231.c,364 :: 		void Alarm2_Enable()
;DS3231.c,366 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;DS3231.c,367 :: 		ctrl_reg |= 0x02;
	MOVLW       2
	IORWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;DS3231.c,368 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;DS3231.c,369 :: 		}
L_end_Alarm2_Enable:
	RETURN      0
; end of _Alarm2_Enable

_Alarm2_Disable:

;DS3231.c,372 :: 		void Alarm2_Disable()
;DS3231.c,374 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;DS3231.c,375 :: 		ctrl_reg &= 0xFD;
	MOVLW       253
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;DS3231.c,376 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;DS3231.c,377 :: 		}
L_end_Alarm2_Disable:
	RETURN      0
; end of _Alarm2_Disable

_Alarm2_IF_Check:

;DS3231.c,380 :: 		uint8_t Alarm2_IF_Check()
;DS3231.c,382 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;DS3231.c,383 :: 		if(stat_reg & 0x02)
	BTFSS       R0, 1 
	GOTO        L_Alarm2_IF_Check10
;DS3231.c,384 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_Alarm2_IF_Check
L_Alarm2_IF_Check10:
;DS3231.c,386 :: 		return 0;
	CLRF        R0 
;DS3231.c,387 :: 		}
L_end_Alarm2_IF_Check:
	RETURN      0
; end of _Alarm2_IF_Check

_Alarm2_IF_Reset:

;DS3231.c,390 :: 		void Alarm2_IF_Reset()
;DS3231.c,392 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;DS3231.c,393 :: 		stat_reg &= 0xFD;
	MOVLW       253
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;DS3231.c,394 :: 		RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
	MOVLW       15
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;DS3231.c,395 :: 		}
L_end_Alarm2_IF_Reset:
	RETURN      0
; end of _Alarm2_IF_Reset

_Alarm2_Status:

;DS3231.c,398 :: 		uint8_t Alarm2_Status()
;DS3231.c,400 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;DS3231.c,401 :: 		if(ctrl_reg & 0x02)
	BTFSS       R0, 1 
	GOTO        L_Alarm2_Status12
;DS3231.c,402 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_Alarm2_Status
L_Alarm2_Status12:
;DS3231.c,404 :: 		return 0;
	CLRF        R0 
;DS3231.c,405 :: 		}
L_end_Alarm2_Status:
	RETURN      0
; end of _Alarm2_Status

_RTC_Write_Reg:

;DS3231.c,408 :: 		void RTC_Write_Reg(uint8_t reg_address, uint8_t reg_value)
;DS3231.c,410 :: 		RTC_I2C_START();
	CALL        _I2C1_Start+0, 0
;DS3231.c,411 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,412 :: 		RTC_I2C_WRITE(reg_address);
	MOVF        FARG_RTC_Write_Reg_reg_address+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,413 :: 		RTC_I2C_WRITE(reg_value);
	MOVF        FARG_RTC_Write_Reg_reg_value+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,414 :: 		RTC_I2C_STOP();
	CALL        _I2C1_Stop+0, 0
;DS3231.c,415 :: 		}
L_end_RTC_Write_Reg:
	RETURN      0
; end of _RTC_Write_Reg

_RTC_Read_Reg:

;DS3231.c,418 :: 		uint8_t RTC_Read_Reg(uint8_t reg_address)
;DS3231.c,422 :: 		RTC_I2C_START();
	CALL        _I2C1_Start+0, 0
;DS3231.c,423 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,424 :: 		RTC_I2C_WRITE(reg_address);
	MOVF        FARG_RTC_Read_Reg_reg_address+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,425 :: 		RTC_I2C_RESTART();
	CALL        _I2C1_Repeated_Start+0, 0
;DS3231.c,426 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,427 :: 		reg_data = RTC_I2C_READ(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       RTC_Read_Reg_reg_data_L0+0 
;DS3231.c,428 :: 		RTC_I2C_STOP();
	CALL        _I2C1_Stop+0, 0
;DS3231.c,430 :: 		return reg_data;
	MOVF        RTC_Read_Reg_reg_data_L0+0, 0 
	MOVWF       R0 
;DS3231.c,431 :: 		}
L_end_RTC_Read_Reg:
	RETURN      0
; end of _RTC_Read_Reg

_IntSqw_Set:

;DS3231.c,434 :: 		void IntSqw_Set(INT_SQW _config)
;DS3231.c,436 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;DS3231.c,437 :: 		ctrl_reg &= 0xA3;
	MOVLW       163
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;DS3231.c,438 :: 		ctrl_reg |= _config;
	MOVF        FARG_IntSqw_Set__config+0, 0 
	IORWF       FARG_RTC_Write_Reg_reg_value+0, 1 
;DS3231.c,439 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;DS3231.c,440 :: 		}
L_end_IntSqw_Set:
	RETURN      0
; end of _IntSqw_Set

_Enable_32kHZ:

;DS3231.c,443 :: 		void Enable_32kHZ()
;DS3231.c,445 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;DS3231.c,446 :: 		stat_reg |= 0x08;
	MOVLW       8
	IORWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;DS3231.c,447 :: 		RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
	MOVLW       15
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;DS3231.c,448 :: 		}
L_end_Enable_32kHZ:
	RETURN      0
; end of _Enable_32kHZ

_Disable_32kHZ:

;DS3231.c,451 :: 		void Disable_32kHZ()
;DS3231.c,453 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;DS3231.c,454 :: 		stat_reg &= 0xF7;
	MOVLW       247
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;DS3231.c,455 :: 		RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
	MOVLW       15
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;DS3231.c,456 :: 		}
L_end_Disable_32kHZ:
	RETURN      0
; end of _Disable_32kHZ

_OSC_Start:

;DS3231.c,459 :: 		void OSC_Start()
;DS3231.c,461 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;DS3231.c,462 :: 		ctrl_reg &= 0x7F;
	MOVLW       127
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;DS3231.c,463 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;DS3231.c,464 :: 		}
L_end_OSC_Start:
	RETURN      0
; end of _OSC_Start

_OSC_Stop:

;DS3231.c,467 :: 		void OSC_Stop()
;DS3231.c,469 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;DS3231.c,470 :: 		ctrl_reg |= 0x80;
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;DS3231.c,471 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;DS3231.c,472 :: 		}
L_end_OSC_Stop:
	RETURN      0
; end of _OSC_Stop

_Get_Temperature:

;DS3231.c,476 :: 		int16_t Get_Temperature()
;DS3231.c,480 :: 		RTC_I2C_START();
	CALL        _I2C1_Start+0, 0
;DS3231.c,481 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,482 :: 		RTC_I2C_WRITE(DS3231_REG_TEMP_MSB);
	MOVLW       17
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,483 :: 		RTC_I2C_RESTART();
	CALL        _I2C1_Repeated_Start+0, 0
;DS3231.c,484 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,485 :: 		t_msb = RTC_I2C_READ(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       Get_Temperature_t_msb_L0+0 
;DS3231.c,486 :: 		t_lsb = RTC_I2C_READ(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       Get_Temperature_t_lsb_L0+0 
;DS3231.c,487 :: 		RTC_I2C_STOP();
	CALL        _I2C1_Stop+0, 0
;DS3231.c,489 :: 		c_temp = (uint16_t)t_msb << 2 | t_lsb >> 6;
	MOVF        Get_Temperature_t_msb_L0+0, 0 
	MOVWF       Get_Temperature_c_temp_L0+0 
	MOVLW       0
	MOVWF       Get_Temperature_c_temp_L0+1 
	RLCF        Get_Temperature_c_temp_L0+0, 1 
	BCF         Get_Temperature_c_temp_L0+0, 0 
	RLCF        Get_Temperature_c_temp_L0+1, 1 
	RLCF        Get_Temperature_c_temp_L0+0, 1 
	BCF         Get_Temperature_c_temp_L0+0, 0 
	RLCF        Get_Temperature_c_temp_L0+1, 1 
	MOVLW       6
	MOVWF       R1 
	MOVF        Get_Temperature_t_lsb_L0+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__Get_Temperature44:
	BZ          L__Get_Temperature45
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__Get_Temperature44
L__Get_Temperature45:
	MOVF        R0, 0 
	IORWF       Get_Temperature_c_temp_L0+0, 1 
	MOVLW       0
	IORWF       Get_Temperature_c_temp_L0+1, 1 
;DS3231.c,491 :: 		if(t_msb & 0x80)
	BTFSS       Get_Temperature_t_msb_L0+0, 7 
	GOTO        L_Get_Temperature14
;DS3231.c,492 :: 		c_temp |= 0xFC00;
	MOVLW       0
	IORWF       Get_Temperature_c_temp_L0+0, 1 
	MOVLW       252
	IORWF       Get_Temperature_c_temp_L0+1, 1 
L_Get_Temperature14:
;DS3231.c,494 :: 		return c_temp * 25;
	MOVF        Get_Temperature_c_temp_L0+0, 0 
	MOVWF       R0 
	MOVF        Get_Temperature_c_temp_L0+1, 0 
	MOVWF       R1 
	MOVLW       25
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
;DS3231.c,495 :: 		}
L_end_Get_Temperature:
	RETURN      0
; end of _Get_Temperature
