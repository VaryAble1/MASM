; Homework #5 Part 1
; File: HW5_1_Lawrence.asm 
; Author: Branden Lawrence
; Date: 10/10/2020
; About: Loop instructions to copy strings in reverse order
; Course: CS 2350 Section: 001
; Texas Tech University
TITLE Homework No. 5.1        (HW5_1_Lawrence.asm)

;------------------ Building Blocks -------------------------
INCLUDE Irvine32.inc
;.386
;.model flat,stdcall
;.stack 4096
;ExitProcess
;proto,dwExitCode:dword

.data
	source byte "This is the source string", 0	; 25 chars
	target byte sizeOf source dup('#')			; 25 #s

;----------------------- Main --------------------------------
.code
main PROC
	mov esi, 0		
	mov ecx, sizeof source		; Create counter
	mov edx, sizeof target - 1		; Create counter
	;Loop
	again:
		; copy string from source into target in reverse order
		mov al,source[esi]		; get character from source
		dec edx
		mov target[edx],al		; store into target
		inc esi					; move to the next char
		loop again				; repeat for the entire string
	; Display
	mov esi, offset target		; offset of variable
	mov ebx, 1					; byte format
	mov ecx, sizeof target		; counter
	call dumpMem				; Section 5.4
	; Exit
	invoke ExitProcess,0
main ENDP
END main 
; Thanks for looking