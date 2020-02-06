;     		********************
;			Program Run LEDk-kjj
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

		ORG		0x00				
		goto 	Main_loop

Main_loop					
		movlw		.7  		; set I/O Port 
		banksel		CMCON
		movwf		CMCON
		banksel		TRISA
		bsf			TRISA,0
		movlw		0x00
		movwf		TRISB		
		banksel 	PORTB		
		movwf		PORTB		
		movlw		0x00		
		movwf		temp		

Again:						
		btfss		PORTA,0		; sw active low //check sw		
		goto		stop
		movf		temp,w	
		call		LED_PATTERN 
		movwf   	PORTB		
		incf		temp,f		
		movf		temp,w
		sublw		.6			
		btfsc		STATUS,Z
		call		reset
		goto		Again		
reset:
		movlw		0x00
		movwf		temp
		return
stop:
			movlw		.10
			call		DelayMS					
			btfsc		PORTA,0				
			goto		Again
			call		eff
			movf		temp,w
			call		LED_PATTERN 
			movwf		PORTB
checkup:
			btfss		PORTA,0				
			goto		checkup			
			movlw		.10
			call		DelayMS
			btfsc		PORTA,0				
			goto		stop				
			goto		checkup
eff:
			movlw		.0
			movwf		temp1
			movf		temp1,w	
			call		LED_PATTERN 
			movwf   	PORTB
			call		Delay1_5S
			incf		temp1,f		
			movf		temp1,w
			sublw		.5			
			btfsc		STATUS,Z
			call		reset
			return
			
;********************** SUBROUTINES **************************************

;#########################################################################		
; Running LED patterns using a look-up table
;#########################################################################

LED_PATTERN:

		addwf	PCL,f

		retlw	B'0001000'		; pattern 1
		retlw	B'1000001'		; pattern 2
		retlw	B'1001001'		; pattern 3
		retlw	B'1010101'		; pattern 4
		retlw	B'1011101'		; pattern 5
		retlw	B'1110111'		; pattern 6


;#########################################################################
; Delay subroutine for 1.5 second
;#########################################################################
Delay1_5S:   					;หาค่าdelayเอง
				movlw	.6
				movwf	count1
outterloop:
				movlw	.24			;1
				movwf	count0		;1
innerloop:
				movlw	.168		;2
				movwf	count2		;2		
loopin:
				decfsz	count2,f		;3
				goto	loopin			;3
				decfsz	count0,F		;2
				goto	innerloop		;2
				decfsz	count1,F		;1
				goto	outterloop		;1
				return

				
DelayMS:
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