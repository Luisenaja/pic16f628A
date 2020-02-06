			PROCESSOR PIC16F628
			#include <P16F628.INC>

			__CONFIG	_CP_OFF & _MCLRE_OFF & _HS_OSC & _LVP_OFF & _WDT_OFF

		cblock 	0x20
			temp
			temp1
			count
			count0
			count1
			count2
		endc

		ORG			0x000				
		goto 		Main_loop
		
		org			0x004
		goto		MyISR
MyISR :
		nop
		retfie

Main_loop					
		movlw		.7  		; set I/O Port 
		banksel		CMCON
		movwf		CMCON
		banksel		TRISA
		bsf			TRISA,0 	;at Ra0 is Input sw
		movlw		.0
		movwf		TRISB		;at Rb0 - Rb7 is output port	
		banksel 	PORTB		
		movwf		PORTB		
		clrf		temp

check_sw:
		btfsc		PORTA,0 
		call		Delay_1ms
		goto		no_loop
		goto		yes_loop

yes_loop:
		movf		count,W
		call 		Luktao_table
		call		Delay_1s
		goto		check_sw

no_loop:
		incf		count,F
		sublw		.7
		btfsc		STATUS,Z
		goto		check_sw
		movlw		.1
		covwf		count
		goto		check_sw
		
Luktao_table :
		addwf		PCL,f

		retlw		B'0001000'		; pattern 1
		retlw		B'1000001'		; pattern 2
		retlw		B'1001001'		; pattern 3
		retlw		B'1010101'		; pattern 4
		retlw		B'1011101'		; pattern 5
		retlw		B'1110111'		; pattern 6
		return

Delay_1s:   
		movlw		.6
		movwf		count1
outterloop:
		movlw		.24			;1
		movwf		count0		;1
innerloop:	
		movlw		.168		;2
		movwf		count2		;2		
loopin:
		decfsz		count2,f		;3
		goto		loopin			;3
		decfsz		count0,F		;2
		goto		innerloop		;2
		decfsz		count1,F		;1
		goto		outterloop		;1
		
		return

Delay_1ms
		movwf		count2
		incf		count2,f
		decfsz		count2,f
		goto		$+2
		goto		$+3
		call		Delay1MS
		goto		$-4
		return
			
Delay1MS:
		movlw		.50					;1	cyc
		movwf		count1				;1	cyc
outloop:
		movlw		.5					;1	cyc	*count1
		nop								;1	cyc	*count1
		movwf		count0				;1	cyc	*count1
inloop:
		decfsz		count0,f			;1	cyc	*count1*count0
		goto		inloop				;2	cyc	*count1*count0
		decfsz		count1,f			;1	cyc	*count1
		goto		outloop				;2	cyc	*count1
		return							;1	cyc
		
		END



		

		
