		PROCESSOR PIC16F628
		#include <P16F628.INC>
		__CONFIG	_CP_OFF & _MCLRE_OFF & _INTRC_OSC_NOCLKOUT & _LVP_OFF & _WDT_OFF

		cblock	0x20
			mul_a
			mul_b
			res_h
			res_l
		endc
		
			ORG		0x00			; Reset Vector
			goto	Mymain		; vector to main program

			ORG		0x04			; Interrupt Vector
			goto	MyISR		; vector to interrup service routine

MyISR:						; blank ISR routine
			nop
			retfie
			
Mymain:		movlw	.120
			movwf	mul_a
			movlw	.5
			movwf	mul_b
mul_1_byte:	
			clrw	
			movwf	res_h
			movwf	res_l
			movf	mul_a,w
			btfsc	STATUS,Z
			goto	mul_exit
			movf	mul_b,W
			btfsc	STATUS,Z
			goto	mul_exit
			
mul_loop:	movf	mul_a,w
			addwf	res_l,F
			btfsc	STATUS,C
			incf	res_h,F
			decfsz	mul_b,F
			goto	mul_loop
			return
			
mul_exit:	return
			
			