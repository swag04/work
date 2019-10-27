     AREA     appcode, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 	
	   MOV r1,#0x00000441  ; Number to check even or odd is stored in r1
	   MOV r2,#0x00000001  ; Value 1 is stored in r2
	   MOV r4,#0x00000000  ; Result will be stored in r4 , if r4 =1 => Odd number else Even Number
	   AND r5,r1,r2
	   CMP r5,r4
	   MOVNE r4,#0x00000001
	   
	   
	   
stop    B stop ; stop program
     ENDFUNC
     END 
