; --------------------------------------------------------------------
; Project #1
; File: Proj1_Lawrence.asm 
; Author: Branden Lawrence
; Date: 11/2/2020
; About: This program is a simple Math/Boolean calculator for 32-bit integers
; Course: CS 2350 Section: 001
; Texas Tech University
; --------------------------------------------------------------------
TITLE Project #1         (Proj1_Lawrence.asm)


;------------------ Building Blocks ----------------------------------
INCLUDE Irvine32.inc

;#region Building Blocks
.data
header		 byte "Instructions: ",0
menuNum		 byte "Now choose a number for both X and Y",0
menuNumNot	 byte "Now choose a number for X",0
menuChoice	 byte "Please choose between 1 - 7:",0dh,0ah
			 byte " ",0dh,0ah ; break
			 byte "1. X AND Y",0dh,0ah
			 byte "2. X OR Y",0dh,0ah
			 byte "3. NOT X",0dh,0ah
			 byte "4. X XOR Y",0dh,0ah
			 byte "5. X ADD Y",0dh,0ah
			 byte "6. X SUB Y",0dh,0ah
			 byte "7. Exit program",0

			 
xValue		dword  ?
yValue		dword  ?
sxValue		sdword ?
syValue		sdword ?
result		dword  ?
bar			byte " -",0
equiv		byte " == ",0
xChar		byte "X: ",0
yChar		byte "Y: ",0
choice		byte "#: ",0
exitTitle	byte "Goodbye",0
exitBody	byte "Thank You.",0
errorTitle  byte "Error!",0
errorBody   byte "Error. Please try again.",0
warning		byte "Warning!",0
confClose	byte "Are you sure you want to exit?",0
banner		byte "Results:",0
total		byte "X + Y = ",0
strxor		byte "X xor Y = ",0
strnot		byte "~X = ",0
stror		byte "X or Y = ",0
strand		byte "X and Y = ",0
strsub		byte "X - Y = ",0
;#endregion

;----------------------- Main ----------------------------------------
.code
main PROC							; main method
	pushad							; Save Gen-Purpose Registers
	mov ecx,  1						; Establish counter
.WHILE	ecx > 0;-------- Loop ----------------------------------------
Restart::
	;#region Menu: 
	mov ebx, offset header			; title
	mov edx, offset menuChoice		; message
	call MsgBox						; display GUI
	;#endregion

	;region menu choice
	mov edx, offset choice			; #:
	call WriteString				; print to console
	call ReadInt					; read user input
	cmp eax, 7						; If input == 7
	jz	Adios						; Quit
	.IF eax < 7						; Else If input < 7
			     ; Branching logic
	cmp eax, 6						; If input == 6
	jz	SUB_op						; jmp to SUB
	cmp eax, 5						; If input == 5
	jz	ADD_op						; jmp to ADD
	cmp eax, 4						; If input == 4
	jz 	XOR_op						; jmp to XOR
	cmp eax, 3						; If input == 3
	jz	NOT_op						; jmp to NOT
	cmp eax, 2						; If input == 2
	jz	OR_op						; jmp to OR
	cmp eax, 1						; If input == 1
	jz	AND_op						; jmp to AND
	cmp eax, 0						; If input == 0
	jz	Error						; jmp to ERROR
	;#endregion

	digits:
		;#region Menu: 
		mov ebx, offset header			; title
		mov edx, offset menuNum			; message
		call MsgBox						; display GUI
		;#endregion
		;#region print to console for X
		mov edx, offset xChar			; X:
		call WriteString				; print to console
		call ReadHex					; read user input
		mov xValue, eax					; take input into variable					; if not, error
		;#endregion
		;#region print to console for Y
		mov edx, offset yChar			; Y:
		call WriteString				; print to console
		call ReadHex					; read user input
		mov yValue, eax					; take input into variable
		;#endregion
		mov	eax, xValue					; add X
		ret								; return from procedure
		
	digit:								; for NOT X (excluding Y)
		;#region Menu: 
		mov ebx, offset header			; title
		mov edx, offset menuNumNot		; message
		call MsgBox						; display GUI
		;#endregion
		;#region print to console for X
		mov edx, offset xChar			; X:
		call WriteString				; print to console
		call ReadHex					; read user input
		mov xValue, eax					; take input into variable
		;#endregion
		ret								; return from procedure

;After the user�s selection, call a procedure that displays the name of the operation about to be
;performed and implements the operation. For example, you have six procedures.

;AND_op: Prompt the user for two hexadecimal integers. AND them together and display the
;result in hexadecimal.
	AND_op:
		call	digits					; retrieve values for X & Y
		and eax, yValue					; add Y
		mov edx, offset strand			; load message
		call	WriteString				; print to console
		jmp		Print					; print X + Y = result to console

;OR_op: Prompt the user for two hexadecimal integers. OR them together and display the result
;in hexadecimal.
	OR_op:
		call	digits					; retrieve values for X & Y
		or eax, yValue					; add Y
		mov edx, offset stror			; load message
		call	WriteString				; print to console
		jmp		Print					; print X || Y = result to console


;NOT_op: Prompt the user for a hexadecimal integer. NOT the integer and display the result in
;hexadecimal.
	NOT_op:
		call	digit					; retrieve digit from input
		not eax							; ~x
		mov edx, offset strnot			; load message
		call	WriteString				; print to console
		jmp		Print					; print ~X = result to console


;XOR_op: Prompt the user for two hexadecimal integers. Exclusive-OR them together and
;display the result in hexadecimal.
	XOR_op:
		call	digits					; retrieve digits from input
		xor eax, yvalue					; xor Y
		mov edx, offset strxor			; load message
		call	WriteString				; print to console
		jmp		Print					;print X xor Y = result to console


;ADD_op: Prompt the user for two hexadecimal integers. Add them and display the result in
;hexadecimal.
	ADD_op:
		call	digits					; retrieve values for X & Y
		add eax, yvalue					; add Y
		mov edx, offset total			; load message
		call	WriteString				; print to console
		jmp		Print					;print X + Y = result to console


;SUB_op: Prompt the user for two hexadecimal integers. Subtract (i.e., x - y) them and
;display the result in hexadecimal.
	SUB_op:
		;#region Menu: 
		mov ebx, offset header			; title
		mov edx, offset menuNum			; message
		call MsgBox						; display GUI
		;#endregion
		
		;#region print to console for X
		mov edx, offset xChar			; X:
		call WriteString				; print to console
		call ReadHex					; read user input
		mov sxValue, eax					; take input into variable					; if not, error
		;#endregion
		
		;#region print to console for Y
		mov edx, offset yChar			; Y:
		call WriteString				; print to console
		call ReadHex					; read user input
		mov syValue, eax					; take input into variable
		;#endregion
		
		mov	eax, sxValue					; add X
		cmp eax, syValue					; cmp X and Y
		jg min								; IF X < Y jmp to minus
		jz min								; IF 0 jump to skip negation
		sub eax, syValue					; X - Y = eax
		mov edx, offset strsub				; load message
		call	WriteString					; print to console
		mov edx, eax						; load message
		;call dumpregs						; test
		call	WriteHex					; print to console
		mov	edx, offset equiv				; load message
		call	WriteString					; print to console
		mov	edx, offset bar					; mov "-" into printer
		call	WriteString					; print to console
		neg	eax								; prints as a positive thus first print neg
		jmp		Printer						; jmp to print result
		
		min:								; minus
			sub eax, syValue				; X - Y = eax
			mov edx, offset strsub			; load message
			call	WriteString				; print to console
			mov edx, eax					; load message
			;call dumpregs					; test
			call	WriteHex				; print to console
			mov	edx, offset equiv			; load message
			call	WriteString				; print to console
			jmp		Printer					; jmp to print result
		
		Printer:
			mov	edx, eax					; reload result
			call	WriteDec				; translate to decimal
			call	crlf					; new line
			call	crlf					; new line
			.CONTINUE						; restart
	.ELSEIF eax > 7							; If input > 7
		jmp Error							; Out of bounds, restart
	.ENDIF									; End of process

	inc ecx									; increment counter
	.CONTINUE								; jmp to top of while loop

	;#region Print
	Print:
		mov edx, eax						; load message
		;call dumpregs						; test
		call	WriteHex					; print to console
		mov	edx, offset equiv				; load message
		call	WriteString					; print to console
		mov	edx, eax						; reload result
		call	WriteDec					; translate to decimal
		call	crlf						; new line
		call	crlf						; new line
		.CONTINUE							; restart
		ret									; just in case
	;#endregion
	;#region Error
	Error:
		mov ebx, offset errorTitle	; title
		mov edx, offset errorBody	; body
		call MsgBox					; display GUI
		.CONTINUE					; jmp to top of while loop
	;#endregion
	.ENDW									; end of while loop
;---------------------------------------------------------------------
	;Quit:
	jmp Quit
	
;When the operation is done, display the menu and wait for the user�s input. Repeat the operation until
;the user selects �7. Exit program�.

;-----------------------------------------------------------------
	;IF 'IDYES' == (6 in EAX) -> jmp Quit:
	;ELSE IF 'IDNO' == (7 in EAX) -> .CONTINUE
	Adios:
		mov ebx, offset warning			; title
		mov edx, offset confClose		; message
		call MsgBoxAsk					; confirm close
		cmp eax, 6						; IF yes
		jz Quit							; jmp to Quit
		jnz	Restart						; Else restart loop
	Quit:
		mov ebx, offset exitTitle		; title
		mov edx, offset exitBody		; message
		call MsgBox						; display GUI
		popad							; Restore gen-purpose registers
		exit							; clean exit
main ENDP								; end of procedure
END main								; end of program
; Thanks for looking