; Homework #4
; File: HW4_Lawrence.asm 
; Author: Branden Lawrence
; Date: 10/07/2020
; About: This program stuffs registers and calculates basic arithmetic
; Course: CS 2350 Section: 001
; Texas Tech University
TITLE Homework #4         (HW4_Lawrence.asm)

;------------------ Building Blocks -------------------------
INCLUDE Irvine32.inc
.data
Uarray	 word	 1000h,2000h,3000h,4000h
Sarray	 sword	 -1,-2,-3,-4

val1     sdword  8
val2     sdword  -15
val3     sdword  20

;----------------------- Main --------------------------------
.code
main PROC

	; Stuff Registers
	movzx	eax,Uarray			; 1000h
	movzx	ebx,Uarray+2		; 2000h
	movzx	ecx,Uarray+4		; 3000h
	movzx	edx,Uarray+6		; 4000h


	;Display Registers
	call	DumpRegs

	; Stuff Registers
	movsx	eax,Sarray			; FFFFFFFFh
	movsx	ebx,Sarray+2		; FFFFFFFEh
	movsx	ecx,Sarray+4		; FFFFFFFDh
	movsx	edx,Sarray+6		; FFFFFFFCh

	; Display Registers
	call	DumpRegs

	; EAX = -val2	 + 7 - val3  + val1
	; 10  = (-(-15)) + 7 - 20	 + 8

	mov		eax,val2		; EAX = FFFFFFF1h
	neg		eax				; EAX = 0000000Fh
	add		eax,7			; EAX = 00000016h
	mov		ebx,val3		; EBX = 00000016h
	sub		eax,ebx			; EAX = 00000002h
	add		eax,val1		; EBX = 0000000Ah

	; Display Registers
	call	DumpRegs

	exit
main ENDP
END main 
; Thanks for looking