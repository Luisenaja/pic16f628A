;program description 1
;student name : raktana faknak Date : 22/09/60 
;program version 7.22 
PROCESSOR PIC16F627A
#include <P16F627A.INC>
		__CONFIG	_CP_OFF & _MCLRE_ON & _INTRC_OSC_NOCLKOUT & _LVP_OFF & _WDT_OFF
myvar1  EQU 20H
myvar2  EQU 21H

		org   0000H
		goto  main_program
	   
main_program :
		movlw 0AAH ; 10101010 ไปไวใน work
		mpvwf myvar1 ;coppy ไป myvar1
	   
		movlw 0FFH
		movwf 20H ;  นำข้อมูลเข้าไปเก็บที่ ตำแหน่ง 20 H
	   
; using pointer 
		movlw 21H ; point ไปที่  21 H
		movwf FSR ; ทำผ่าน pointer
		movf  myvar1,w
		movwf INDF ; ทำผ่าน INDF พร้อมกับ FSR
		goto  main_program
 end