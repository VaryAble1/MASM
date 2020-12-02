; --------------------------------------------------------------------
; Homework #?
; File: HW?_Lawrence.asm 
; Author: Branden Lawrence
; Date: 10/?/2020
; About: This program stuffs registers and calculates basic arithmetic
; Course: CS 2350 Section: 001
; Texas Tech University
; --------------------------------------------------------------------
;TITLE Homework #?         (HW?_Lawrence.asm)

;------------------ Building Blocks ----------------------------------
INCLUDE Irvine32.inc
;.386
;.model flat,stdcall
;.stack 4096
;ExitProcess proto,dwExitCode:dword
; --------------------------------------------------------------------

.data
caption byte "Dialog Title",0
HelloMsg byte "This is a popup message box.",0dh,0ah
						byte "Click OK to cotinue...",0


;----------------------- Main ----------------------------------------
.code
main PROC ; method

	; Save Gen-Purpose Registers
	pushad

	; MsgBox
	mov ebx, offset caption
	mov edx, offset HelloMsg
	call MsgBox
	

	; Restore gen-purpose registers
	popad

	exit
main ENDP
END main 
; Thanks for looking