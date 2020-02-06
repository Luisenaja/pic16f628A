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
		clrf	30H
		clrf	31H
		clrf	32H
		clrf	33H
		clrf	34H
		clrf	35H
		clrf	36H
		clrf	37H
		clrf	38H
		clrf	39H
		clrf	3AH
		clrf	3BH
		clrf	3CH
		clrf	3DH
		clrf	3EH
		clrf	3FH
		clrw
		movlw 	.6
		movwf 	31H
		movlw 	.7
		movwf 	32H
		movlw 	.8
		movwf 	33H
		movlw 	.9
		movwf 	34H
		movlw 	.2
		movwf 	35H

start:
		clrw
		movlw 	30H
		movwf 	max_post
		movf	max_post,max_value
		movlw 	31H ; FSR=31H
		movwf 	FSR

k_check:
		movf	max_value,w
		subwf	INDF,W 	; [w]=INDF-[w] [w]=max_value
		btfss	STATUS,C ; compare INDF>= [w] ?
		goto	again_loop
		movf	INDF,w
		movwf	max_value
		movf	FSR,w
		movwf	max_post

again_loop:
		movf 	FSR,W
		sublw	.62
		btfsc	STATUS,C
		goto 	fsr_loop
		goto	byebye

fsr_loop:
		incf	FSR,W
		movwf	FSR		; FSR=FSR+1
		goto	k_check

byebye:
		end