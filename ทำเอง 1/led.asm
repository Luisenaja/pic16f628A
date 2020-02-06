		PROCESSOR PIC16F628
		#include <P16F628.INC>
		__CONFIG	_CP_OFF & _MCLRE_ON & _INTRC_OSC_NOCLKOUT & _LVP_OFF & _WDT_OFF
		
		
		org 0x00
		goto mainpro
		org 0x04 ;reset vector
		
main_pro:
		bsf status,rp0
		bcf status,rp1 ;goto bank1
		bsf trisb,1 ;
		bcf trisb,0
		bsf status,rp0
inf_loop:
		btfss portb,1
		goto LED_ON
		goto LED_OFF
LED_OFF:
		bcf portb,0
		goto inf_loop
LED_ON:
		bsf portb,1
		goto inf_loop
		end
		11111
		
