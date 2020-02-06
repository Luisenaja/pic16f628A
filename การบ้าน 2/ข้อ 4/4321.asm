			PROCESSOR PIC16F628A
			#include <P16F628.INC>
			__CONFIG	      _CP_OFF & _MCLRE_ON & _INTRC_OSC_NOCLKOUT & _LVP_OFF & _WDT_OFF
			cblock 	 0x20
			temp
			temp1
			endc
			
			ORG		 0x00			; Reset Vector
			goto	 My_main		; vector to main program
			ORG		 0x04			; Interrupt Vector
			goto	 MyISR		; vector to interrup service routine

MyISR:						; blank ISR routine
			nop
			retfie
		 
My_main:	
			banksel  TRISB
			bcf      TRISB,0
			banksel  PORTB
			bsf      PORTB,0
			call	 delay
			bcf      PORTB,0
			goto     byebye
		 
delay:   	movlw    .200
			movwf    temp
loop_a: 	movlw    .20
			movwf    temp1
loop_b:  	nop
			nop
			nop
			decfsz   temp1,f
			goto     loop_b
			decfsz   temp,f
			goto     loop_a
			return   
byebye:
			end