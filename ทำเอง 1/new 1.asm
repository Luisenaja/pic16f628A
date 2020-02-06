		PROCESSOR PIC16F628
		#include <P16F628.INC>
		__CONFIG	_CP_OFF & _MCLRE_OFF & _INTRC_OSC_NOCLKOUT & _LVP_OFF & _WDT_OFF

		cblock	0x20
			xh
			yh
			yl
			yh
			
		endc
		cblock	0x30
			zl
			zh
		
		endc
		
		ORG		0x00			; Reset Vector
		goto	main_program		; vector to main program

		ORG		0x04			; Interrupt Vector
		goto	MyISR		; vector to interrup service routine

MyISR:						; blank ISR routine
		nop
		retfie

main_program:
		
		movf 	xl,f
		movwf 	yl,w
		movwf 	zl
		btfsc 	status,c
		incf 	xh,f
		movf 	xh,w
		addwf 	yh,w
		movwf 	zh
		
		end
222222222
