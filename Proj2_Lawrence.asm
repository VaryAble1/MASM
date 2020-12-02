; --------------------------------------------------------------------
; Project #2
; File: Proj2_Lawrence.asm 
; Author: Branden Lawrence
; Date: 11/21/2020
; About: This project is to write a simple game program that reads a computer's mind
; Course: CS 2350 Section: 001
; Texas Tech University
; --------------------------------------------------------------------
;TITLE Project #2         (Proj2_Lawrence.asm )

;------------------ Building Blocks ----------------------------------
;#region Building Blocks
INCLUDE Irvine32.inc
;.386
;.model flat,stdcall
;.stack 4096
;ExitProcess proto,dwExitCode:dword

.data
num1		dword	?
num2		dword	?
num3		dword	?
counter		byte	?
results		byte "Answer: ",0
caption		byte "Main Menu",0
PlayAgin	byte "Play A New Game?",0
exitTitle	byte "Thank You!",0
exitBody	byte "GAME OVER",0
failMsg	byte "All guesses incorrect. Please try again.",0

GameMenu	byte	"Here is a set of rules:",0
StrikeMenu	byte	"Strike(s): The computer will response with a strike,",0dh,0ah
			byte	"if one of your numbers AND positions are matched with the computer's. ",0dh,0ah
			byte	" ",0dh,0ah
			byte	"Let say, the computer has 4 2 9.",0dh,0ah
			byte	"If you type 0 1 8, the computer will response with '0 strike',",0dh,0ah
			byte	"because all of your numbers and their positions are not matched with the computer's.",0dh,0ah
			byte	" ",0dh,0ah
			byte	"If you type 5 2 7, the computer will response with '1 strike',because one of numbers (i.e., 2) and its position are matched.",0dh,0ah
			byte	" ",0dh,0ah
			byte	"If you type 4 3 9, the computer will response with '2 strikes'.",0

BallMenu		byte	"Ball(s): The computer will response with a ball,",0dh,0ah
				byte	"if one of your numbers is matched with the computer's but the position is different.",0dh,0ah
				byte	" ",0dh,0ah
				byte	"Let say, the computer has 4 2 9.",0dh,0ah
				byte	"If you type 1 8 3, the computer will response with '0 ball' because none of numbers matched.",0dh,0ah
				byte	" ",0dh,0ah
				byte	"If you type 2 9 0, the computer will response with '2 balls' because two numbers (i.e., 2 and 9) are matched buttheir positions are different.",0dh,0ah
				byte	" ",0dh,0ah
				byte	"If you type 9 4 2, the computer will response with '3 balls'.",0

GuessPrompt		byte	" ",0dh,0ah
				byte	"Please choose a number: ",0
ResultMenu		byte	"End of Game Results:",0
NotBallsMsg		byte	"You have 0 balls! #BetterLuckNextTime",0
NotStrikesMsg	byte	"You have 0 Strikes! #PracticeMakesPerfect",0
Ball3Msg		byte	"You have 3 balls! #SoClose",0
Ball2Msg		byte	"You have 2 balls! #SwapEm",0
Ball1Msg		byte	"You have 1 ball! Right number, Wrong spot. #TryAgain",0
StrikeOutMsg	byte	"You have 3 strikes! #StrikeOut",0
twoStrikeMsg	byte	"You have 2 strikes! #AlmostThere",0
youllHaveToDoBetterThanThatMsg	byte	"You have 1 strike! #BetterThanNothing",0
Tries			byte	"=============================================:Tries:",0
Life5			byte	"---------------------------------------------:lives:5:-",0
Life4			byte	"---------------------------------------------:lives:4:-",0
Life3			byte	"---------------------------------------------:lives:3:-",0
Life2			byte	"---------------------------------------------:lives:2:-",0
Life1			byte	"---------------------------------------------:lives:1:-",0
lives			byte	0
count			byte	0
ball1			dword	0
ball2			dword	0
ball3			dword	0
strike1			dword	0
strike2			dword	0
strike3			dword	0
;#endregion
; --------------------------------------------------------------------


;----------------------- Main ----------------------------------------
.code
main PROC

	pushad							; Save Gen-Purpose Registers
	mov ecx,  1						; Establish counter
.WHILE	ecx > 0;-------- Loop ----------------------------------------
	;#region Main Menu
	mov ebx, offset caption			; title
	mov edx, offset PlayAgin		; ask to play again
	call MsgBoxAsk					; confirm close
	cmp eax, 6				        ; IF yes reset
	; instantiate
	mov num1, 0
	mov num2, 0
	mov num3, 0
	mov ball1, 0
	mov ball2, 0
	mov ball3, 0
	mov strike1, 0
	mov strike2, 0
	mov strike3, 0
	call	getNums					; Generate random numbers
	cmp eax, 7						; IF no:
	jz Quit							; jmp to Quit
	;#endregion
	

	;#region Game Menu
	mov	ebx,	offset GameMenu		; title
	mov edx,	offset StrikeMenu	; Strike tutorial
	call MsgBox						; Explain Strikes in GUI
	mov edx,	offset BallMenu		; Ball tutorial
	call MsgBox						;Explain Balls in GUI
	;#endregion
;----------------------- Instructions --------------------------------
;#region Instructions
;1. This project is to write a simple game program that reads a computer's mind. 
; The computer will think three numbers and you are going to guess the numbers.
; First of all, the computer randomly generates 3 different numbers, e.g. 1 2 3, 8 3 9, 0 4 5, or 7 3 2. 
; For the sake of simplicity, each number cannot be duplicated, e.g., 1 3 3, 7 2 7, 0 0 9, or 8 8 8 are not allowed.


	mov ecx, 3							; set counter
	mov count, 3						; set 2nd counter
	mov	lives, 6						; number of lives before game over unless StrikeOut!

	looper:								; ask for guesses 
		mov edx, offset GuessPrompt		; Ask for a number
		call WriteString				; print to console
		call ReadInt					; read user input

		.IF ecx == 3						; number 1
			cmp	 eax, num1					; correct guess?
			jz right						; yes
			jnz	wrong						; no
		.ELSEIF ecx == 2					; number 2
			cmp	 eax, num2					; correct guess?
			jz	right						; yes
			jnz	wrong						; no
		.ELSEIF ecx == 1					; number 1
			cmp	 eax, num3					; correct guess?
			jz	right						; yes
			jnz	wrong						; no
		.ENDIF

		loop looper							; self explanitory 
		

;When you guess and type numbers, the computer will response in terms of number of strike(s) and
;ball(s), e.g., 2 strikes 0 ball. Based on the number of strike(s) and ball(s), you will have a clue about the
;numbers what the computer is currently thinking. Then you can prepare for the next numbers to type.

	; #region Correct
	right:									; if correct
		.IF count == 3 						; strike position 1
			dec	count						; count - 1
			mov strike1, 1					; strike1 == true
			dec	ecx							; decrement counter
			jmp looper						; loop again
		.ELSEIF count == 2 					; strike position 2
			dec	count						; count - 1
			mov strike2, 1					; strike2 == true
			dec ecx							; decrement counter
			jmp looper						; loop again
		.ELSEIF count == 1 					; strike position 3
			dec	count						; count - 1
			mov strike3, 1					; strike3 == true
			jmp Result						; annalyze results 
		.ENDIF
		ret
	;#endregion
	
	;#region Incorrect
	wrong:
		.IF count ==	3 					; ball position 1
			dec	count						; count - 1
			; does it match either of the other two numbers? If so:
			cmp eax, num2					; same as num2
			jz point1						; give point
			cmp eax, num3					; same as num3
			jz point1						; give point
			jnz here1						; jump if not
			point1:
			mov ball1,	1					; assign point
			here1:
			dec	ecx							; count - 1
			jmp looper						; loop again
		.ELSEIF count == 2 					; ball position 2
			dec	count						; count - 1
			; does it match either of the other two numbers? If so:
			cmp eax, num1					; same as num1 
			jz point2						; give point
			cmp eax, num3					; same as num3
			jz point2						; give point
			jnz here2						; if not jump
			point2:
			mov ball2,	1					; assign point
			here2:
			dec	ecx							; decrement count
			jmp looper						; loop again
		.ELSEIF count == 1 					; ball position 3
			dec	count						; count - 1
			; does it match either of the other two numbers? If so:
			cmp eax, num1					; same as num1
			jz point3						; give point
			cmp eax, num2					; same as num2
			jz point3						; give point
			jnz here3						; if not jump
			point3:
			mov ball3,	1					; assign point
			here3:
			jmp Result						;	annalyze results
		.ENDIF
		ret
	;#endregion
	
	; respond with strikes and/or balls
	Result:  ;===============================================================
		dec		lives						; lose 1 life
		mov		edx, offset failMsg			; fail message default
		sub	    eax, eax					; zero out
		add		eax, strike1				; start with strike1 value
		add		eax, strike2				; add strike2 value
		add		eax, strike3				; add strike3 value
		cmp		eax, 3						; if there are 3 strikes
		jz	StrikeOut						; 3 strikes
		cmp		eax, 2						; if there are 2 strikes
		jz	twoStrike						; 2 strikes
		cmp		eax, 1						; if there are 1 strikes
		jz	youllHaveToDoBetterThanThat		; 1 strike
		cmp		eax, 0						; if there are 0 strikes
		jz	NotStrikes						; try harder
		balls: ;-------------------------------------------------------------
		mov		ebx, offset ResultMenu		; title
		call	MsgBox						; display Strike GUI
		mov		edx, offset failMsg 		; fail message default
		sub	    eax, eax					; zero out
		add		eax, ball1					; start with ball1 value
		add		eax, ball2					; add ball2 value
		add		eax, ball3					; add ball3 value
		cmp		eax, 3						; are there 3 balls?
		jz	AllBalls						; 3 balls
		cmp		eax, 2						; are there 2 balls?
		jz	BiBalls							; 2 balls
		cmp		eax, 1						; is there at least 1 ball??
		jz	MonoBall						; 1 ball
		cmp		eax, 0						; if you have no balls
		jz  NotBalls						; special message
		ret   ;===============================================================

;• Strike Out: If three input numbers and their positions are exactly matched with the
;computer's, the computer will response with “strike out”. Then a menu will display and ask
;whether to continue or not.
	Reset:
		.IF lives > 0						; if there are any lives left
			call WriteString				; print to console balls msg
			mov ball1, 0					; reset
			mov ball2, 0					; reset
			mov ball3, 0					; reset
			mov strike1, 0					; reset
			mov strike1, 0					; reset
			mov strike1, 0					; reset
			mov strike2, 0					; reset
			mov strike3, 0					; reset
			mov count, 3					; reset count
			mov ecx, 3						; reset counter
			jmp looper						; loop again
		.ENDIF
		jmp Quit							; if done, quit
		ret

;• Whenever you have "strike out!!", display the number of trials.
LifeMeter:
	.IF lives == 5							; if there are 5 lives
		mov	edx, offset Life5				; lives left message
	.ELSEIF lives == 4						; if there are 4 lives
		mov	edx, offset Life4				; lives left message
	.ELSEIF lives == 3						; if there are 3 lives
		mov	edx, offset Life3				; lives left message
	.ELSEIF lives == 2						; if there are 2 lives
		mov	edx, offset Life2				; lives left message
	.ELSEIF lives == 1						; if there is 1 life
		mov	edx, offset Life1				; lives left message
	.ELSEIF lives == 0						; if there are 0 lives
		;call testing
	.ENDIF
	ret

;#endregion
;---------------------------------------------------------------------
.ENDW										; end of while loop

getNums:
	mov count, 3							; set count to 3
	mov ecx, 3								; set counter
	Random:
		.IF count == 3						; if first go-around
			call one						; getOne
			dec	count						; count - 1
		.ELSEIF count == 2					; if secong go-around
			call two						; getTwo
			dec	count						; count - 1
		.ELSE
			call three						; getThree
			dec	count						; count - 1
		.ENDIF 
		loop Random ;--------------------------------------------
		
		;testing: 
			;call dumpRegs
		;	mov edx, offset results
		;	call writeString
		;	mov	edx, num1					; prep input to print (test)
		;	call WriteInt					; print to console
		;	mov	edx, num2					; prep input to print (test)
		;	call WriteInt					; print to console
		;	mov	edx, num3					; prep input to print (test)
		;	call WriteInt					; print to console
		;	ret
	ret
	
	one:
		push ecx							; save counter
		call random_num						; get random num
		pop ecx								; restore counter

		.IF ecx == 3 && eax != num1			; if first try and != num1
			mov num1, eax					; make first num
		.ELSEIF ecx == 3					; if it is the same 
			jmp Random						; try again
		.ENDIF
		ret

	two:
		; getTwo
		push ecx							; save counter
		call random_num						; get random num
		add eax, ecx						; alter
		pop ecx								; restore counter
		cmp eax, 10							; set cap
		jae two								; if over cap try again
		.IF ecx == 2 && eax != num1			; if sencond num and != num1
			mov num2, eax					; make num2
		.ELSEIF ecx == 2					; if the same as num1
			jmp	Random						; try again
		.ENDIF
		ret

	three:
		; getThree
		push ecx							; save counter
		call random_num						; get random num
		sub eax, ecx						; alter
		pop ecx								; restore counter
		cmp eax, 10							; is it below 10?
		jae three							; if not try again
		cmp eax, num2						; is it the same as num2?
		jae three							; if so try again
		.IF ecx == 1 && eax != num1 || eax != num2	; if first num and not same as num1 or num2
			mov num3, eax					; add to num3
		.ELSEIF ecx == 1					; if it is the same as either then try again
			jmp Random						; retry
		.ENDIF
		ret
;#region Messages

NotBalls:
	mov	edx, offset NotBallsMsg						; no balls message 
	jmp Print										; print
	ret

NotStrikes:
	mov	edx, offset NotStrikesMsg					; no strikes message
	jmp balls										; jump back to counting balls
	ret

AllBalls:
	mov	edx, offset Ball3Msg						; 3 balls message
	jmp Print										; print
	ret

BiBalls:
	mov	edx, offset Ball2Msg						; 2 balls message
	jmp Print										; print
	ret

MonoBall:
	mov	edx, offset Ball1Msg						; 1 ball message
	jmp Print										; print
	ret

StrikeOut:
	mov ebx,	 offset ResultMenu					; title
	mov	edx, offset StrikeOutMsg					; Strike Out message
	call	MsgBox									; display GUI

	mov edx, offset Tries							; load design
	call WriteString								; print to console
	mov	eax, 6										; sun track from total lives
	sub eax, dword ptr lives						; load a count of how many tries it took
	call WriteInt									; print to console
	ret

twoStrike:
	mov	edx, offset twoStrikeMsg					; 2 Strike message
	jmp balls										; jump back to counting balls
	ret

youllHaveToDoBetterThanThat:
	mov	edx, offset youllHaveToDoBetterThanThatMsg	; 1 Strike message
	jmp balls										; jump back to counting balls
	ret

;#endregion

Print: 
	mov ebx,	 offset ResultMenu		; title
	call	MsgBox						; display GUI
	;call	dumpRegs					; test
	call	LifeMeter					; how many lives left?
	jmp		Reset						; reset?
	ret

Quit:
	mov ebx, offset exitTitle			; title
	mov edx, offset exitBody			; message
	call MsgBox							; display GUI
	popad								; Restore gen-purpose registers
	exit								; clean exit
main ENDP

random_num PROC

.code
	call Randomize						; set seed
	mov eax, 10							; range from, 1 -10
	call RandomRange					; get random number
	ret
random_num ENDP
END main 
; Thanks for looking