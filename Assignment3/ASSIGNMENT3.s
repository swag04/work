	 AREA     appcode, CODE, READONLY
     EXPORT __main
	 IMPORT printMsg1
     ENTRY 
__main  FUNCTION
; SIMPLE NEURAL NETWORK IMPLEMENTATION	
; FINAL OUTPUT IS STORED IN S8
; S10 CONTAION FINAL X
	 VLDR.F32 S1,=1 ; S1 INITIALISED TO 1
	 VLDR.F32 S23,=0.5 ; S23 INITIALISED TO 0.5 , USED AS THRESHOLD
	 MOV R7, #0		;R7 is used to know which logic you want to implement
	 BAL MENU
	 
MENU					; switch case 
		CMP R7,#0		;go to and operation 
		BEQ ANDLOGIC
		CMP R7,#1		;go to or operation
		BEQ ORLOGIC
		CMP R7,#2		;go to not operation
		BEQ NOTLOGIC
		CMP R7,#3		;go to nand operation
		BEQ NANDLOGIC
		CMP R7,#4		;go to nor operation
		BEQ NORLOGIC
		CMP R7,#5       ;go to xor operation 
		BEQ XORLOGIC
		CMP R7,#6		;go to xnor operation
		BEQ XNORLOGIC
	
ANDLOGIC
		VLDR.F32 S14,=-0.1  ; W1 - these are weights mentioned in python code for AND gate
		VLDR.F32 S11,=0.2 ; W2
		VLDR.F32 S12,=0.2 ; W3
		VLDR.F32 S13,=-0.2 ; Bias
		B	NEXT
		
ORLOGIC
		VLDR.F32 S14,=-0.1 ; W1 - these are weights mentioned in python code for OR gate
		VLDR.F32 S11,=0.7 ; W2
		VLDR.F32 S12,=0.7 ; W3
		VLDR.F32 S13,=-0.1 ; Bias
		B	NEXT
		
NOTLOGIC
		VLDR.F32 S14,=0.5 ; W1 - these are weights mentioned in python code for NOT gate
		VLDR.F32 S11,=-0.7 ; W2
		VLDR.F32 S12,=0 ; W3
		VLDR.F32 S13,=0.1 ; Bias
		B	NEXT
		
NANDLOGIC
		VLDR.F32 S14,=0.6 ; W1 - these are weights mentioned in python code for NAND gate
		VLDR.F32 S11,=-0.8 ; W2
		VLDR.F32 S12,=-0.8 ; W3
		VLDR.F32 S13,=0.3 ; Bias
		B	NEXT
		
NORLOGIC
		VLDR.F32 S14,=0.5 ; W1 - these are weights mentioned in python code for NOR gate
		VLDR.F32 S11,=-0.7 ; W2
		VLDR.F32 S12,=-0.7 ; W3
		VLDR.F32 S13,=0.1 ; Bias
		B  	NEXT
		
XORLOGIC		
		VLDR.F32 S14,=-5 ; W1 - these are weights mentioned in python code for XOR gate
		VLDR.F32 S11,=20 ; W2
		VLDR.F32 S12,=10 ; W3
		VLDR.F32 S13,=1 ; Bias
		B	NEXT

XNORLOGIC
		VLDR.F32 S14,=-5 ; W1 - these are weights mentioned in python code for AND gate
		VLDR.F32 S11,=20 ; W2
		VLDR.F32 S12,=10 ; W3
		VLDR.F32 S13,=1 ; Bias
		B	NEXT	
	
NEXT    ; INPUT VALUE IS LOADED i.e X1,X2,X3
		VLDR.F32 S15,=1 ; X1
		VLDR.F32 S16,=0 ; X2
		VLDR.F32 S17,=1 ; X3
		B OPERATION
	
OPERATION
		VMUL.F32 S18,S15,S14 ; W1X1
		VMUL.F32 S19,S11,S16 ; W2X2
		VMUL.F32 S20,S12,S17 ; W3X3
		VADD.F32 S21,S19,S18 ; W1X1+W2X2
		VADD.F32 S21,S21,S20 ; W1X1+W2X2+W3X3
		VADD.F32 S21,S21,S13 ;FINAL X VALUE IS STORED IN S21
		VMOV.F32 S10, S21    
		BL EXP		          ; e^x SUBROUTINE IS CALLED HERE
		
		VADD.F S22,S4,S1 ; (1+e^x)
		VDIV.F S6,S4,S22 ; SIGMOID FUNCTION IMPLEMENTED i.e (e^x/(1+e^x)) VALUE IS STORED IN S6
		VMOV.F S8,S6       ; FINAL RESULT OF SIGMOID IS STORED IN S8
		VCMP.F S6,S23
		vmrs APSR_nzcv,FPSCR
		BLT LOGIC0
		BGT LOGIC1
FINAL
		;VCVT.U32.F32 S6,S6 
	    ;VMOV R0,S6
		BL printMsg1  ; PRINT FUNCTION IS CALLED
		B STOP

LOGIC0 LDR R0,= 0x00000000
	   B FINAL
LOGIC1 LDR R0,= 0x00000001
	   B FINAL
; e^x IMPLEMENTATION STARTED
EXP	
	   VMOV.F S7,S10
	   VMOV.F S9,S10 ;
	   LDR r8,= 0x00000001 ;
       
       VMOV.F S0,S10
	   ;VCVT.F32.U32 S0,S0
	   LDR r1,= 0x00000030 ; NO OF ITERATIONS	   
	   LDR r2,= 0x00000001 ; USED FOR FACTORIAL  
	   VLDR.F S4,= 1      ; USED TO STORE FINAL RESULT
       VLDR.F S5,= 1 ; USED TO STORE FACTORIAL RESULT
	   
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
       BX lr
	  

      ; THIS LOOP FIND OUT X^n TERM
pow     
       VMUL.F S7,S7,S9  
	   ADD r8,#0x00000001
	   CMP r8,r2
	   BNE pow
	   BEQ loop2
	   
STOP B STOP ; stop program
     ENDFUNC
     END