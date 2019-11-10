     AREA     appcode, CODE, READONLY
     EXPORT __main
	 IMPORT printMsg
     ENTRY 
__main  FUNCTION	
; IGNORE THIS PART
; e^x code
; FINAL RESULT IS STORED IN S4
; FACTORIAL VALUE IS STORES IN S5
	   LDR r0,= 0x00000064 ; X value
	   VMOV.F S7,r0 ; 
	   VCVT.F32.U32 S7,S7
	   VMOV.F S9,r0 ;
	   VCVT.F32.U32 S9,S9
	   LDR r8,= 0x00000001 ;
	   	  	   
loop1
       
       VMOV.F S0,r0
	   VCVT.F32.U32 S0,S0
	   LDR r1,= 0x00000010 ; n = 9	   
	   LDR r2,= 0x00000001 ; USED FOR FACTORIAL  
	   VLDR.F S4,= 1      ; USED TO STORE FINAL RESULT
       VLDR.F S5,= 1 ; USED TO STORE FACTORIAL RESULT
	   ;VMOV.F S5,r5
	   
loop     
       VMOV.F S7,S9
       CMP r8,r2
	   BNE pow
loop2
       VMOV.F S0,S7
       VDIV.F S3,S0,S5
	   VADD.F S4,S4,S3
	   LDR r8,= 0x00000001 
	   ADD r2,#0x00000001
	   VMOV.F S2,r2
	   VCVT.F32.U32 S2,S2
	   VMUL.F S5,S5,S2 ; FACTORIAL IS FOUND OUT HERE
	   CMP r2,r1
       BNE loop
       
	  ; At this point check S4 content. It store the final result. (Before executing next line)
	  ; NEW VALUE OF X WILL BE LOADED AFTER THIS    
	   ADD r0,#0x00000001
	   VMOV.F S7,r0 
	   VCVT.F32.U32 S7,S7
	   VMOV.F S9,r0 
	   VCVT.F32.U32 S9,S9
	   CMP r0,#0x00000064
	   BNE loop1

      ; THIS LOOP FIND OUT X^n TERM
pow     
       VMUL.F S7,S7,S9  
	   ADD r8,#0x00000001
	   CMP r8,r2
	   BNE pow
	   BEQ loop2
	   
	   
stop    B stop ; stop program
     ENDFUNC
     END 
		 
