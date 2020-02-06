;program delay 88ms
;homework 3
;Raktana Faknak 5713079 EGEC
		PROCESSOR PIC16F628
		#include <P16F628.INC>
		__CONFIG _CP_OFF & _MCLRE_ON & _INTRC_OSC_NOCLKOUT & _LVP_OFF & _WDT_OFF 
		cblock	 0x20
		temp
		endc
		
		ORG 	 0x20
		banksel  TRISA
		bcf      TRISA,0
		banksel  PORTA

		bsf      PORTA,0
		call	 Delay
		bcf      PORTA,0
		goto	 ee

Delay:		
		movlw    .21
		movwf    count
delay_ms:  
		nop
		decfsz   count,f
		goto     delay_ms
		return
		
ee:
		end

