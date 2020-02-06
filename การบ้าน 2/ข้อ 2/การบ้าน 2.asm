		PROCESSOR PIC16F628
		#include <P16F628.INC>
		__CONFIG	_CP_OFF & _MCLRE_OFF & _INTRC_OSC_NOCLKOUT & _LVP_OFF & _WDT_OFF

		cblock	0x20
			max_post ;max_post EQU 20H
			max_value ; max_value EQU 21H
		endc
			
		ORG		0x00			; Reset Vector
		goto	main		; vector to main program
main:
		movlw 	.6
		movwf 	31H
		movlw 	.7
		movwf 	37H
		movlw 	.8
		movwf 	38H
		movlw 	.9
		movwf 	39H
		movlw 	.2
		movwf 	3EH
		clrf 	3FH

start:
		clrw
		movlw 	30H
		movwf 	max_post
		movf	30H,max_value
		movlw 	31H ; FSR=31H
		movwf 	FSR

k_check:
		movf	max_value,w
		subwf	INDF,W 	; [w]=INDF-[w]
		btfss	STATUS,C ; compare INDF>= [w] ?
		goto	again_loop
		movf	INDF,max_value
		movf	FSR,max_post

again_loop:
		movf 	FSR,w
		subwf	.62
		btfss	STATUS,Z
		goto 	fsr_loop
		goto	byebye

fsr_loop:
		incf	FSR,FSR ; FSR=FSR+1
		goto	k_check

byebye:
		end