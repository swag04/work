     AREA     appcode, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 	
	   MOV r1,#0x00000440  ; First Number
	   MOV r2,#0x00001230  ; Second Number
	   MOV r3,#0x00000301  ; Third Number
	   CMP r1,r2 ; First number is compared to second number
	   BGT loop ; If first number is greater than second one then execution will go to loop block
	   BLT loop1 ; Else execution will go to loop1
loop   CMP r1,r3 ; Here first number is compared with third number
       MOVGT r5,r1 ; If first number is greater then that is transfered to R5
	   MOVLT r5,r3 ; If third number is greater then that is transfered to R5
	   B stop
loop1   CMP r2,r3 ; Here second number is compared with third number
       MOVGT r5,r2 ;If second number is greater then that is transfered to R5
	   MOVLT r5,r3 ;If third number is greater then that is transfered to R5
	   
stop    B stop ; stop program
     ENDFUNC
     END 
