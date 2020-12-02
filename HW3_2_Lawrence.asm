; Homework #3
; File: HW3_2_Lawrence.asm 
; Source: Chapter 3 example
; Author: Branden Lawrence
; Date: 09/24/2020
; About: Contains the definitions of each data type listed in table 3-2
; Course: CS 2350 Section: 001
; Texas Tech University
TITLE Homework #3, Version 2         (HW3_2_Lawrence.asm)

INCLUDE Irvine32.inc

.data
contextualByte		 byte   255							; 8-bit BYTE
signedByte			 sbyte  127							; 8-bit SBYTE
unsignedWord		 word	65535						; 16-bit WORD
signedWord			 sword  32767						; 16-bit SWORD
doubleWord			 dword  4294967295					; 32-bit DWORD
signedDoubleWord     sdword 2147483647					; 32-bit SDWORD
portectedWord		 fword	281474976710655				; 48-bit FWORD
quadWord			 qword  18446744073709551615		; 64-bit QWORD
tenByte				 tbyte	1208925819614629174706175	; 80-bit (10-byte) TBYTE

.code
main PROC
	call	DumpRegs			; display the registers
exit
main ENDP
END main ; Thanks for looking