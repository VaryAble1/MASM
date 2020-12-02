; Homework #5 Part 2
; File: HW5_2_Lawrence.asm 
; Author: Branden Lawrence
; Date: 10/14/2020
; About: Create a Fibonacci number sequence to the first 7 values
; Course: CS 2350 Section: 001
; Texas Tech University
TITLE Homework No. 5.2         (HW5_2_Lawrence.asm)

;------------------ Building Blocks -------------------------
INCLUDE Irvine32.inc
;.386
;.model flat,stdcall
;.stack 4096
;ExitProcess
;proto,dwExitCode:dword

.data
thing1 dword 0
thing2 dword 1

;----------------------- Main --------------------------------
.code
main PROC

	;Loop
	mov ecx, 3
	; Counter
	again:
		; Left (Thing1)
		mov eax, thing1		; 0 - 1 - 3
		add eax, thing2		; 1 - 2 - 5
		mov thing1, eax		; 1 - 3 - 8
		call dumpRegs		;	Display
		; Right (Thing2)
		mov eax, thing1		; 1 - 3 - 8
		add eax, thing2		; 1 - 2 - 5
		mov thing2, eax		; 2 - 5 - 13
		call dumpRegs		;	Display

		loop again			;	Repeat
	; Exit
	invoke ExitProcess,0
main ENDP
END main 
; Thanks for looking