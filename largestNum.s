     AREA     appcode, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 	
	   MOV r1,#0x00000440  ; First Number
	   MOV r2,#0x00001230  ; Second Number
	   MOV r3,#0x00000301  ; Third Number
	   CMP r1,r2
	   BGT loop
	   BLT loop1
loop   CMP r1,r3
       MOVGT r5,r1
	   MOVLT r5,r3
	   B stop
loop1   CMP r2,r3
       MOVGT r5,r2
	   MOVLT r5,r3
	   
stop    B stop ; stop program
     ENDFUNC
     END 