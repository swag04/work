     AREA     appcode, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 	
	   MOV r1,#0x00000004  ; Number a will be stored here
	   MOV r2,#0x0000000C  ; Number b will be stored here
	   
       CMP r1,r2
	   BNE loop
loop   SUBGT r1,r1,r2
       SUBLT r2,r2,r1
	   CMP r1,r2
	   BNE loop
	   
	   
stop    B stop ; stop program
     ENDFUNC
     END 