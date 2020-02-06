		PROCESSOR PIC16F628
		#include <P16F628.INC>
		__CONFIG	_CP_OFF & _MCLRE_OFF & _INTRC_OSC_NOCLKOUT & _LVP_OFF & _WDT_OFF

		cblock	0x20
			x
			y
			remain
			count
			endc
		
			ORG		0x00			; Reset Vector
			goto	Mymain		; vector to main program

			ORG		0x04			; Interupt Vector
			goto	MyISR		; vector to interrup service routine

MyISR:						; blank ISR routine
			nop
			retfie
Mymain:		movlw	.7
			movwf	x
			movlw	.3
			movwf	y
			clrf	remain
			clrf	count
			clrw
			movf	y,W
			subwf	x,remain

check:		btfsc	STATUS,Z
			goto	count_end

count_go:	incf	count,F
			goto 	new_loop

new_loop:	movf	y,W
			subwf	remain,remain
			goto	check
			
count_end:	incf	count,F
			end
			
		