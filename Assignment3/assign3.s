  area     exponentialSeries, CODE, READONLY
       EXPORT __main
       ENTRY 
; Implementation of neural network
__main  FUNCTION		 
        MOV R0, #30 	   ;No. of itterations
        MOV R1 , #1		   ;counter
        VLDR.F32 S0,=1 	   ;initial 1 and result
		VLDR.F32 S1,=1     ;intermediate vals
        ;VLDR.F32 S2,=5    ;holding x 
		VLDR.F32 S3,=1     ;to calculate factorial 
		VLDR.F32 S5,=1
		VLDR.F32 S6,=1     ;intermediate val
		VLDR.F32 S7,=1		; hold 1 always
        VLDR.F32 S8,=1		;hold 1+ exp(x)
		VLDR.F32 S9,=1		; result of sigmoid fn
		MOV R2, #4		;This is for which logic u want to immplement
		BAL options
		
options					; switch-case equivalent
		CMP R2, 0		;branch to and operation 
		B logicand
		CMP R2, 1		;branch to or operation
		B logicor
		CMP R2, 2		;branch to not operation
		B logicnot
		CMP R2, 3		;branch to nand operation
		B logicnand
		CMP R2, 4		;branch to nor operation
		B logicnor
		CMP R2, 5       ;branch to xor operation 
		B logicxor
		CMP R2, 6		;branch to xnor operation
		B logicxnor
		

epowerx 
       
	    CMP R0, R1;			; when counter R1 becomes equal to R0(No. of itterations) then stops
		beq sigmoid 
		;VADD.F32 s0,s0,s2
		B numerator			
        
		
				
numerator 
        VMUL.F32 S1,S1,S2	; t = t*x
        B denominator 

		
denominator					; calculate factorial value or denominator of exponential series
        
		VMOV.F32 S4, R1;
		VCVT.F32.U32 S4,S4	;Convertion of TRUE Value of a  number to IEEE FP standards and back to TRUE value.
		VMUL.F32 S5,S5,S4;		
		ADD R1,R1,#1
		B divide

divide 
        VDIV.F32 S6,S1,S5	; divide numerator and denominator
		VADD.F32 s0,s0,s6
        B epowerx			; branch back to epowerx for next itteration
		
		
sigmoid
		VADD.F32 s8,s0,s7
		VDIV.F32 S9,S0,S8
		CMP R0, R1;			; when counter R1 becomes equal to R0(No. of itterations) then stops
		beq stop
		
		
logicand
		VLDR.F32 S10,=-0.1
		VLDR.F32 S11,=0.2
		VLDR.F32 S12,=0.2
		VLDR.F32 S13,=-0.2
		B	dataset
		
logicor
		VLDR.F32 S10,=-0.1
		VLDR.F32 S11,=0.7
		VLDR.F32 S12,=0.7
		VLDR.F32 S13,=-0.1
		B	dataset
		
logicnot
		VLDR.F32 S10,=0.5
		VLDR.F32 S11,=-0.7
		VLDR.F32 S12,=0
		VLDR.F32 S13,=0.1
		B	dataset
		
logicnand
		VLDR.F32 S10,=0.6
		VLDR.F32 S11,=-0.8
		VLDR.F32 S12,=-0.8
		VLDR.F32 S13,=0.3
		B	dataset
		
logicnor
		VLDR.F32 S10,=0.5
		VLDR.F32 S11,=-0.7
		VLDR.F32 S12,=-0.7
		VLDR.F32 S13,=0.1
		B  	dataset
		
logicxor		
		VLDR.F32 S10,=-5
		VLDR.F32 S11,=20
		VLDR.F32 S12,=10
		VLDR.F32 S13,=1
		B	dataset

logicxnor
		VLDR.F32 S10,=-5
		VLDR.F32 S11,=20
		VLDR.F32 S12,=10
		VLDR.F32 S13,=1
		B	dataset
		
dataset
		VLDR.F32 S14,=1
		VLDR.F32 S15,=0
		VLDR.F32 S16,=0
		B computation
		
computation
		VMUL.F32 S17,S10,S14;
		VMUL.F32 S18,S11,S15;
		VMUL.F32 S19,S12,S16;
		VADD.F32 S20,S17,S18
		VADD.F32 S20,S20,S19
		VADD.F32 S20,S20,S13      ;now x is ready
		VMOV.F32 S2, S20;
		B epowerx
		

stop B stop ; stop program
     ENDFUNC
     END