		
		PROCESSOR PIC16F628
		#include <P16F628.INC>
		__CONFIG _CP_OFF & _MCLRE_OFF & _INTRC_OSC_NOCLKOUT & _LVP_OFF & _WDT_OFF

		Mul_num	macro	NumA,Out_res1,Out_res2,NumB,Out_res3
		
					movf	NumA,w
					addwf	Out_res1,f
					btfsc	STATUS,C
					incf	Out_res2,f ;  มีตัวทด
					movf	NumB,w
					addwf	Out_res2,f
					btfsc	STATUS,C
					incf	Out_res3,f		
					
				endm
					
					
		cblock	0x20
			resL
			resH
			mulA
			mulB
			Out1
			Out2
			Out3
			Out4
			Out5
			cAL
			cAH
			cBL
			cBH
		endc

		ORG		0x00
		goto	Main
		
Main:		
			movlw	0x02
			movwf	cAL
			movlw	0x01
			movwf	cAH
			movwf	cBH
			movwf	cBL
			movf	cAL,w
			movwf	mulA
			movf	cBL,w
			movwf	mulB
			call	Multiple
			Mul_num	resL,Out1,Out2,resH,Out3
			movf	cAH,w
			movwf	mulA
			movf	cBL,w
			movwf	mulB
			call	Multiple
			Mul_num	resL,Out2,Out3,resH,Out4
			movf	cAL,w
			movwf	mulA
			movf	cBH,w
			movwf	mulB
			call	Multiple
			Mul_num	resL,Out2,Out3,resH,Out4
			movf	cAH,w
			movwf	mulA
			movf	cBH,w
			movwf	mulB
			call	Multiple
			Mul_num	resL,Out3,Out4,resH,Out5
			
			goto	Exit
			
		
Multiple:			;โปรแกรม คูณเลขๆ
			clrw
			movwf	resH
			movwf	resL
			movf	mulA,w
			btfsc	STATUS,Z
			goto	mul_exit
mul_loop:
			movf	mulA,w
			addwf	resL,f
			btfsc	STATUS,C
			incf	resH,F
			decfsz	mulB,f
			goto	mul_loop
mul_exit:	
			return
Exit:
	
		END