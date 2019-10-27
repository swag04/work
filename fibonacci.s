     AREA     appcode, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 	
	   MOV r1,#0x00000040  ;upto what number fibonacci series will be printed is stored in R1
	   MOV r2,#0x00000000  ; initialisation of R2 to 0
	   MOV r3,#0x00000001  ; initialisation of R3 to 1
	   MOV r5,r2           ; R5 will be observed for fibonacci seires result, so R5 is loaded with 0
	   MOV r5,r3           ; and 1 initially
	   ADD r2,r2,r3
	   MOV r5,r2           ; Till now R5 will have 0 1 1
loop 
	   CMP r1,r5
	   MOVGT r6,r2
	   ADDGT r2,r2,r3
	   CMP r1,r2
	   BLT stop
	   MOVGT r5,r2
	   MOVGT r3,r6
	   BGT loop
stop    B stop ; stop program
     ENDFUNC
     END 