; File: ArraySumation.asm 
; Author: Branden Lawrence
; Date: 10/10/2020
; About: This program calculates basic arithmetic in an array
; Orbis Labs

;------------------ Building Blocks -------------------------
INCLUDE Irvine32.inc
.data
arrayW	 word	 1000h,2000h,3000h

;----------------------- Main --------------------------------
.code
main PROC

	mov esi, OFFSET arrayW	;Duplicate the variable label to the ESI register
	mov ax, [esi]			;MOV the contents of the ESI address to AX : ax=1000h
	add esi,2				;Move to the next address
	add ax, [esi]			;AX + 2000h = 3000h into AX
	add esi,2				;Move to the next address
	add ax,[esi]			;AX + 3000h = 6000h into AX

	; Display Registers
	call	DumpRegs

	exit
main ENDP
END main 
; Thanks for looking