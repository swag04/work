     AREA     appcode, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 	
	   MOV r1,#0x00000004  
	   MOV r2,#0x0000000C 
	   MOV r3,#0x00000008  
	   MOV r4,#0x0000000F  
	   
       CMP r1, #8
       ITTEE LT
       ITE LT
	   SUBLT r1 , r1, r2 ; 	   
	   MOVGE r1, r3 ;
       MOVGE r1, r4 ; 
	   MOVGE r1, r4 ; 
	   
	   
stop    B stop ; stop program
     ENDFUNC
     END 
		 
; Nested If then else block will not work 
; I am getting error message as -- Ques4.s(13): error: A1603E: This instruction inside IT block has UNPREDICTABLE results 
; Even if we use ITTEE, we can write 2 then and else statements at max but ITE block must have 3 lines of code. So this is not possible.