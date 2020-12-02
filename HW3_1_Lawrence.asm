; Homework #3
; File: HW3_1_Lawrence.asm 
; Source: Chapter 3 example
; Author: Branden Lawrence
; Date: 09/24/2020
; About: adds and subtracts 32-bit integers.
; Course: CS 2350 Section: 001
; Texas Tech University
TITLE Homework #3, Version 1         (HW3_1_Lawrence.asm)

; This program adds and subtracts 32-bit integers
; and stores the sum in a variable.

INCLUDE Irvine32.inc

.data
valA     dword  10000h
valB     dword  40000h
valC     dword  20000h
valD	 dword  30000h
finalVal dword  ?

.code
main PROC

	mov	eax,valA			; start with 10000h
	mov	ebx,valB			; start with 40000h
	mov	ecx,valC			; start with 20000h
	mov	edx,valD			; start with 30000h

	call	DumpRegs			; display the registers (Before)

	; A = (A + B) - (C + D)					; Equation
	; eax = (eax + ebx) - (ecx + edx)		; Subsitute Registers
	; 0 = (10000 + 40000)-(20000 + 30000)	; Subsitute Values
	; 0 = (50000)-(50000)					; Simplify

	add	eax,valB			; add 10000h + 40000h
	add	ecx,valD			; add 20000h + 30000h
	sub	eax,ecx				; subtract 50000h from 50000h
	mov	finalVal,eax		; store the result (00000h)
	
	
	call	DumpRegs			; display the registers (After)

	exit
main ENDP
END main
;Thanks for looking