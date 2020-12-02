; Homework #1
; File: AddTwo.asm 
; Source: Chapter 3 example
; Author: Branden Lawrence
; Date: 09/08/2020
; About: adds two 32-bit integers.
; Course: CS 2350 Section: 001
; Texas Tech University


.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.code
; main process
main proc
	; move
	mov	eax,5	
	; add
	add	eax,6	
	
	; clean exit code 0
	invoke ExitProcess,0
; main end point
main endp
end main
; Thanks for looking