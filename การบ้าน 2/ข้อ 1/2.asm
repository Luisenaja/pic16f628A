	PROCESSOR PIC16F628
		#include <P16F628.INC>
		__CONFIG	_CP_OFF & _MCLRE_OFF & _INTRC_OSC_NOCLKOUT & _LVP_OFF & _WDT_OFF

		cblock	0x20
			xh
			xl
		endc
		cblock	0x30
			yh
			yl
		endc
		
		ORG		0x00			; Reset Vector
		goto	main		; vector to main program

		ORG		0x04			; Interrupt Vector
		goto	MyISR		; vector to interrup service routine

MyISR:						; blank ISR routine
		nop
		retfie

main:
		
		movlw 	B'10001000'
		movwf 	xl
		movlw 	B'00010011'
		movwf 	xh
		movlw 	B'01110000'
		movwf 	yl
		movlw 	B'00010111'
		movwf 	yh
		movf 	xl,w
		addwf	yl,w
		btfsc 	STATUS,C
		incf	xh,xh
		movf	xh,w
		addwf	yh,w
		btfsc	STATUS,C
		bsf		22H,0
		movwf	xh
		
		end