
	<h1 id = "maincontent"> ASM 6502 Command Table</h1>
	<p>
		Here's a complete list of of all the 6502 commands that work with the NES. Be sure to look at the 
		page on coding basics if you haven't already, as it should give you a solid foundation to get started 
		coding:
		<a href="coding.html">Coding Basics</a>
	</p>

	<p> 
		I've written example snippets of code for each command. To see some of them in greater context with a 
		bigger program, you can look at the sample programs here:
		<a href="programs.html">Sample Programs</a>
	</p>

	<p>
		A big thanks to the ChibiAkumas 6502 website
		<a href="https://www.chibiakumas.com/6502"> (https://www.chibiakumas.com)</a>, which is a great site 
		for learning about ASM 6502, or many other assembly languages for a variety of gaming (and 
		general-purpose) systems. A lot of the information I gathered for the commands for the 6502 came from 
		this site, as it's one of the first places I learned about ASM6502/NES programming, and I still visit 
		the site frequently!
	</p>

	<p>
		Note: All comments in ASM6502 begin with a semi-colon(';')
	</p>

	<table>
		<tr>
			<td>Command</td>
			<td>Description</td>
			<td>Example</td>
			<td>Notes</td>
			<td>Flags Affected</td>
		</tr>

		<tr>
			<td>ADC</td>
			<td>Add with carry. Adds whatever number you choose, plus 1 if the carry flag is set.</td>
			<td>
	<pre><code>
		clc ;clears carry flag
		lda #1 ; load 1 into accumulator
		adc #3 ; adds 3 to accumulator (now 4)
	</code></pre>
			</td>
			<td>If carry flag is set, will add additional 1 to total - be sure to clear the carry with 
			CLC first, if necessary! </td>
			<td>N,Z,C,V</td>
		</tr>

		<tr>
			<td>AND</td>
			<td>Compares bit values in accumulator with another value, and returns a 1 to each bit of the 
			accumulator if that bit is a 1 in both.</td>
			<td>
	<pre><code>
		lda #$DF ; loads hex DF = 11011111 in binary
		and #$F0 ; compares hex F0 = 11110000 to 11011111, result is 11010000.
	</code></pre>
			</td>
			<td>Great way to check if conditions are met in a game (by using each bit as a separate 
			condition, for example).</td>
			<td>N,Z,C</td>
		</tr>
		
		<tr>
			<td>ASL</td>
			<td>Arithmetic shift left of the value in the accumulator. Moves all bits to the left. Bit 7 
			moves to the carry.</td>
			<td>
	<pre><code>
		lda #%10101010 
		asl ; results in %01010100 in accumulator, and sets the carry
		asl ; results in %10101000 in accumulator, carry no longer set
	</code></pre>
			</td>
		
			<td>Affects carry if bit in bit 7 is 1. </td>
			<td>C</td>
		</tr>

		<tr>
			<td><span class="branch">Branch Commands</span></td>
			<td>There are a number of branching commands. Let's go through them one at a time.</td>
			<td></td>
			<td></td>
			<td></td>		
		</tr>

		<tr>
			<td>BCC</td>
			<td>Branch Carry Clear. Jump to address specified if the carry flag is not set.</td>
			<td>
	<pre><code>
		lda #$FE
		clc ; clear carry flag
		adc #1 ; add 1 to $FE, gives $FF, which does not set carry flag
		bcc skip ; jump to 'skip' section of code, because carry flag is clear
	noskip:
		adc #1 ; will not occur, as carry flag is not set!
	skip:
		sta $00 ; stores value from accumulator, $FE, into address $00
	</code></pre>
			</td>
			<td>Any addition that results in less than 256 will not set the carry.</td>
			<td></td>
		</tr>

		<tr>
			<td>BCS</td>
			<td>Branch Carry Set. Jump to the specified section of code if the carry flag is not set.
			</td>
			<td>
	<pre><code>
		lda #$FF
		clc ; clear carry flag
		adc #1 ; add 1 to $FF, gives $00, which sets the carry flag
		bcc carryClear
		bcs carrySet
	carryClear:
		adc #1 ; This code will be skipped, as carry is set!
		jmp moreCode
	carrySet:
		sta $00 ; This code will execute
	moreCode:
		(other code here...)
	</code></pre>
			</td>
			<td>All of the branch commands have a complement or "opposite", BCS being the complement of 
			BCC. If BCC wouldn't result in a branch, than BCS would, or vice versa.</td>
			<td></td>		
		</tr>

		<tr>
			<td>BEQ</td>
			<td>Branch Equal. Jumps to specified section of code if value in accumulator is equal to 
			zero.
			<td>
	<pre><code>
		lda #1
		beq isZero
		lda #0
		beq isZero
	notZero:
		lda #2	; This will be skipped
	isZero:
		(more code)... ; This will be executed
	</code></pre>
			</td>	
				<td>Complement of BNE.</td>
				<td></td>		
		</tr>

		<tr>
			<td>BNE</td>
			<td>Branch Not Equal. Jump to specified section of code if accumulator value is 
			<em>not</em> equal to zero.</td>
			<td>
	<pre><code>
		lda #1
		bne notZero
		lda #0	; This will be skipped, as jump has already occurred
		beq isZero ; This will also be skipped
	notZero:
		lda #2	;
		jmp otherCode 
	isZero:
		(more code)... ; This will be skipped
	otherCode:
		(even more code)... ; Code continues here
	</code></pre>
			<td>Complement of BEQ.</td>
			<td></td>		
		</tr>
		
		<tr>
			<td>BMI</td>
			<td>Branch Minus (branch if negative). Jump to specified section of code if accumulator is 
			negative.</td>
			<td>
	<pre><code>
		lda #127 ; 0 to 127 is "positive" in 6502
		clc
		adc #1 ; now 128 (which is also -127 in 6502, see notes to the right)
		bmi itsNegative
		bpl itsPositive
	itsNegative:
		(other code...) ; Code will branch here
		jmp moreCode
	itsPositive
		(other code...) ; Code will not execute
	moreCode:
		(even more code...)
	</code></pre>
			</td>
			<td>The 6502 allows for the use of negative numbers by making 255 (or $FF) = 
			-1, 254 = -2, ..., etc.,, 128 = -127. A full explanation can be found here: 
			<a href="coding.html#negative">Negative Numbers on the 6502</a></td>
			<td></td>
		</tr>
		
		<tr>
			<td>BPL</td>
			<td>Branch Plus (branch if positive). Jump to specified section of code if accumulator is 
			positive.</td>
			<td>
	<pre><code>
		lda #255 ; 255 is also -1 in 6502 (see notes for BMI above)
		clc
		adc #1 ; Accumulator is now 0 which counts as positive
		bmi itsNegative
		bpl itsPositive
	itsNegative:
		(other code...) ; Code will not execute
		jmp moreCode
	itsPositive
		(other code...) ; Code will branch here
	moreCode:
		(even more code...)
	</code></pre>
		</td>	
			<td>Complement of BMI. Any number from 0 to 127 will branch with BPL.</td>
			<td></td>		
		</tr>
		
		<tr>
			<td>BVC</td>
			<td>Branch if Overflow Clear. Jump to specified section of code if overflow flag is 
			<em>not</em> set. (Overflow flag sets when sign changes on the number, I.e. adding 1 to 127, 
			since 128 also equals -127.)</td>
			<td>
	<pre><code>
		lda #126 ; Load decimal 126 into accumulator
		clc	 ; clear the carry
		adc #1   ; add 1 to 126, gives 127 which is still a positive number
		bvc stillPositive ; 127 is positive (128-255 are "negative"), so branch occurs
	notPositive:
		(some code...) ; Code will not execute since 127 is positive
	stillPositive:
		(some other code...) ; code continues from here
	</code></pre>
			</td>	
			<td>Complement of BVS.</td>
			<td></td>		
		</tr>
		
		<tr>
			<td>BVS</td>
			<td>Branch if Overflow Set. Jump to specified section of code if overflow flag is set.</td>
			<td>
	<pre><code>
		lda #127 ; Load decimal 126 into accumulator
		clc	 ; clear the carry
		adc #1   ; add 1 to 127, gives 128 = -127 which sets the overflow flag
		bvs notPositive ; 128 is positive (128-255 are "negative"), so branch occurs
	stillPositive:
		(some other code...) ; Code will not execute since -127 is negative
	notPositive:
		(some code...) ; Code continues from here
	
	</code></pre>
			</td>	
			<td>Complement of BVC</td>
			<td></td>		
		</tr>
		
		<tr>
			<td>BIT</td>
			<td>Essentially AND command, but it doesn't change the accumulator value, it just sets the 
			flags (if appropriate).</td>
			<td>
	<pre><code>
		lda %10111000 ; Load binary 10111000 = $B8 = 184 or -72
		bit %00000000 ; Sets Z,V flags
	</code></pre>
			</td>	
			<td>Useful when you want to use something similar to AND, but without changing the value in 
			the accumulator.</td>
			<td>N,Z,V</td>		
		</tr>
		
		<tr>
			<td>BRK</td>
			<td>Stop the CPU, execute an interrupt. Address called at $FFFE/FF is called as a subroutine 
			(which is your "irq" code).</td>
			<td>
	<pre><code>
		(some code...)
		brk ; Call "irq" subroutine
		lda #55 ; Will never execute, as brk already occurred
	</code></pre>
			</td>
			<td>If you don't have any code in your irq subroutine, the game basically freezes and 
			nothing further occurs.</td>
			<td></td>
		</tr>
		
		<tr>
			<td>CLC</td>
			<td>Clear the carry flag.</td>
			<td>
	<pre><code>
		clc
	</code></pre>
			</td>
			<td> Use this with ADC when adding, unless you specifically want to add carry as well 
			(assuming it is set).</td>
			<td>C</td>
		</tr>
		
		<tr>
			<td>CLD</td>
			<td>Clear Decimal, makes it so that you're not in Binary Decimal Mode</td>
			<td>
	<pre><code>
		cld
	</code></pre>
			</td>
			<td>
			Binary Decimal Mode doesn't actually exist for NES, but it's good practice to put this 
			command in the initialization/reset of your program, because the behaviour of the D flag is 
			not quite clear when the NES is either turned on or reset. <span class="important">Always 
			include this in the initialization of your program!</span></td>
			<td>D</td>
		</tr>
		
		<tr>
			<td>CLI</td>
			<td>Clear Interrupt Flag (allows for interrupts). Use this to turn interrupts back on.</td>
			<td>
	<pre><code>
		cli ; Interrupts enabled (disabled using SEI)
	</code></pre>
			</td>
			<td>Use this if you disabled interrupts using SEI and you want hardware interrupts turned 
			back on.</td>
			<td>I</td>
		</tr>
		
		<tr>
			<td>CLV</td>
			<td>Clear Overflow Flag.</td>
			<td>
	<pre><code>
		clv
	</code></pre>
			</td>
			<td>Overflow flag gets set every time a number changes from positive to negative or vice 
			versa.</td>
			<td>V</td>
		</tr>
		
		<tr>
			<td>CMP</td>
			<td>Compares value to accumulator, can be used to set negative, carry, or zero flags.</td>
			<td>
	<pre><code>
		lda #20
		cmp #21 ; This will set N flag since 20 - 21 = -1 is negative
		lda #21
		cmp #21 ; This will set Z flag since 21 - 21 = 0 is zero.
	</code></pre>
			</td>
			<td>Think of this command like subtracting from the accumulator (without actually changing 
			value inside of accumulator) and seeing what flags that would set.</td>
			<td>N,Z,C</td>
		</tr>
		
		<tr>
			<td>CPX</td>
			<td>Similar to CMP but compares against value in X register.</td>
			<td>
	<pre><code>
		ldx #20
		cpx #21 ; This will set N flag since 20 - 21 = -1 is negative
		ldx #21
		cpx #21 ; This will set Z flag since 21 - 21 = 0 is zero.
	</code></pre>
			</td>
			<td>(See notes in CMP above.)</td>
			<td>N,Z,C</td>
		</tr>
		
		<tr>
			<td>CPY</td>
			<td>Similar to CMP/CPX but compares against value in Y register.</td>
			<td>
	<pre><code>
		ldy #20
		cpy #21 ; This will set N flag since 20 - 21 = -1 is negative
		ldy #21
		cpy #21 ; This will set Z flag since 21 - 21 = 0 is zero.
	</code></pre>
			</td>
			<td>(See notes in CMP above.)</td>
			<td>N,Z,C</td>
		</tr>
		
		<tr>
			<td>DEC</td>
			<td>Decreases chosen value by 1.</td>
			<td>
	<pre><code>
		DEC $FF ; Decrease value stored in zero-page address $FF by one
	</code></pre>
			</td>
			<td>You will probably use dex and dey more often (for loops), but this has a similar 
			effect.</td>
			<td>N,Z</td>
		</tr>
		
		<tr>
			<td>DEX</td>
			<td>Decrease value stored in x register by 1.</td>
			<td>
	<pre><code>
		ldx #12 		; Load 12 into x register
	someloop:
		txa 			; transfer value in x-register to accumulator
		clc
		adc #1 			; add 1
		tay			; transfer accumulator value to y-register
		dex 			; Value in x register is now 11
		bne someloop		; loop until x is equal to zero
	</code></pre>
			</td>
			<td>
	Particularly useful for loops when used with branch commands.
			</td>

			<td>N,Z</td>
		</tr>
		
		<tr>
			<td>DEY</td>
			<td>Decrease value stored in y register by 1.</td>
			<td>
	<pre><code>
		ldy #10			; Load 10 into y register
	someloop:
		lda $02,y 		; load zero page address $02 + y
		clc
		adc #5 			; add 5
		sta $02,y 		; value in $02 + y is now 5 greater
		dey 			; decrease y-value
		bne someloop		; loop until y equals zero
	</code></pre>
			</td>
			<td> Useful in loops, can use with x register to create nested loops (which can be useful 
			for things like setting up your tile graphics).</td>

			<td>N,Z</td>
		</tr>
		
		<tr>
			<td>EOR</td>
			<td>Exclusive-OR command (often XOR in other languages/systems). Checks each bit in 
			accumulator and value to see if exactly one of them is one.</td>
			<td>
	<pre><code>
		lda %10110010
		eor %00001111 ; Value in accumulator becomes %10111101
		lda %11110000
		eor %00001111 ; value in accumulator becomes %11111111
		lda %11110000
		eor %00000000 ; value in accumulator is unchanged
	</code></pre>
			</td>
			<td>
			Every value of 1 in the eor command essentially flips the bits in the accumulator 
			from 1 to 0 or vice versa.
			</td>
			<td>N,Z</td>
		</tr>
		
		<tr>
			<td>INC</td>
			<td>Increases selected value by 1.</td>
			<td>
	<pre><code>
		inc $FA ; Increase value at address $FA by 1
	</code></pre>
			</td>
			<td>Complement to DEC.</td>
			<td>N,Z</td>
		</tr>
		
		<tr>
			<td>INX</td>
			<td>Increases value in x register by 1.</td>
			<td>
	<pre><code>
		ldx 12
		inx ; Value in x register is now 13
	</code></pre>
			</td>
			<td>
	Useful for loops when used with branch commands.
			</td>
			<td>N,Z</td>
		</tr>
		
		<tr>
			<td>INY</td>
			<td>Increases value in y register by 1.</td>
			<td>
	<pre><code>
		ldy 13
		iny ; Value in y register is now 14
	</code></pre>
			</td>
			<td>
	Useful for loops when used with branch commands.
			</td>
			<td>N,Z</td>
		</tr>
		
		<tr>
			<td>JMP</td>
			<td>Jump to selected address.</td>
			<td>
	<pre><code>
		jmp $3000 ; Jump to code at address $3000
	</code></pre>
			</td>
			<td>Using "jmp *" will cause an endless loop by jumping to itself, which can be useful when 
			you're just testing out a snippet of code.</td>
			<td></td>
		</tr>
		
		<tr>
			<td>JSR</td>
			<td>Jump to subroutine at selected address.</td>
			<td>
	<pre><code>
		jsr funLoop ; Jump to address with label "funLoop"
		lda #5 ; code in "funloop" will run before this
		jmp otherCode ; Skip over funLoop and go to "otherCode"
	funLoop:
		lda #6 ; 6 is loaded into accumulator
		rts ; Returns to command lda #5 above
	otherCode:
		(more code here...)
	</code></pre>
			</td>
			<td>
			Unlike jmp, can be paired with rts which allows you to resume running lines of code from 
			right after the jsr
			</td>
			<td></td>
		</tr>

		<tr>
			<td>LDA</td>
			<td>Loads selected value into accumulator.</td>
			<td>
	<pre><code>
		lda #55 ; Value in accumulator is now decimal 55
		lda #$55 ; Value is now hexidecimal 55 (or 85 decimal)
		lda #%10101010 ; Value is now binary 10101010 = $AA = 170 decimal
		lda $55 ; load Value from zero-page address $55
	</code></pre>
			</td>
			<td>This will probably be the command you use the most!</td>
			<td>N,Z</td>
		</tr>
		
		<tr>
			<td>LDX</td>
			<td>Loads selected value into x register.</td>
			<td>
	<pre><code>
		ldx #32 ; X register now contains decimal value 32
		ldx $32 ; X register now contains value stored at zero-page address $32
		ldx #%10001111 ; X register now contains binary value 10001111
	</code></pre>
			</td>
			<td>Often used with LDA when you need more than one variable at a time.</td>
			<td>N,Z</td>
		</tr>
		
		<tr>
			<td>LDY</td>
			<td>Loads selected value into y register.</td>
			<td>
	<pre><code>
		ldx #35 ; Y register now contains decimal value 35
		ldx $35 ; Y register now contains value stored at zero-page address $35
		ldx #%10001110 ; Y register now contains binary value 10001110
	</code></pre>
			</td>
			<td>LDY is particularly useful when combined with LDX when you have a loop inside of a 
			loop.</td>
			<td>N,Z</td>
		</tr>
		
		<tr>
			<td>LSR</td>
			<td>Shift bits of selected value to the right. Bit 0 becomes the new carry.</td>
			<td>
	<pre><code>
		lda %10101010
		sta $FE ; Store value %10101010 into zero-page address $FE
		lsr $FE ; Value stored at address $FE is now %01010101
	</code></pre>
			</td>
			<td>Can shift bits in accumulator by just typing LSR (i.e. with no address or value beside 
			it).</td>
			<td>N,Z,C</td>
		</tr>
		
		<tr>
			<td>NOP</td>
			<td>No operation.</td>
			<td>
	<pre><code>
		nop
	</code></pre>
			</td>
			<td>
			NOP is a 1-byte operation that essentially does nothing. It could be used as a delay, though
			it is not recommended (there are better ways of keeping track of time, like the use of 
			vblank). Can also be used as part of self-modifying code.
			</td>
			<td></td>
		</tr>
		
		<tr>
			<td>ORA</td>
			<td>OR command. Checks to see if either accumulator or selected value has a 1 at each digit.
			</td>
			<td>
	<pre><code>
		lda %10101010
		ora %01010101 ; Value in accumulator is now %11111111
	</code></pre>
			</td>
			<td>Great for turning certain bits "on" (into a 1) while making sure other bits are 
			unaffected.</td>
			<td>N,Z,C,V</td>
		</tr>
		
		<tr>
			<td>PHA</td>
			<td>Pushes value from accumulator onto the stack.</td>
			<td>
	<pre><code>
		lda #11
		pha ; 11 is on top of the stack
			lda #12
			sta $FE ; Store 12 in zero-page address $FE
		pla ; 11 is returned from stack to accumulator
	</code></pre>
			</td>
			<td>
			Value in accumulator remains after PHA, until you load a new value. Useful for times when an 
			operation using, say, the accumulator might be interrupted by a subroutine that also 
			requires the accumulator, and value needs to be "remembered" for later use.</td>
			<td></td>
		</tr>
		
		<tr>
			<td>PHP</td>
			<td>Push the flags onto the stack.</td>
			<td>
	<pre><code>
		lda #5
		sec
		sbc #5 		; This would set the zero flag
		php 		; Push flag values onto the stack.
			lda #5 	; Zero flag no longer set
		plp 		; Zero flag is set again
	</code></pre>
			</td>
			<td>
			Similar to PHA, this allows you to store the flag settings when you know that another 
			operation might occur that needs to use the flags, but you still need to "remember" the 
			flags from your first operation. Note: PHP is like LDA, LDX, etc., in that it doesn't "erase" 
			the values in your flags, it just puts a "copy" of them on the stack for future use.
			</td>
			<td></td>
		</tr>

		<tr>
			<td>PLA</td>
			<td>Complemntary command to PHA, pulls the "top" byte off the stack and puts it in the 
			accumulator.</td>
			<td>
	<pre><code>
		lda #5
		pha ; Accumulator value now on the stack
			lda #3
			sta $01		; store 3 into zero page address $01
		
		pla ; accumulator value is now 5 again
	</code></pre>
			</td>
			<td>Generally always follows shortly after a pha command, so that your stack doesn't have 
			data on it that goes unused.</td>
			<td></td>
		</tr>

		<tr>
			<td>PLP</td>
			<td>Complement to PHP, pulls the "top" byte off the stack and stores it as the flag values.
			</td>
			<td>
	<pre><code>
		lda #5
		sec
		sbc #5 		; This would set the zero flag
		php 		; Push flag values onto the stack.
			lda #5 	; Zero flag no longer set
		plp 		; Zero flag is set again
	</code></pre>
			</td>
			<td>Generally always follows shortly after a php command.</td>
			<td>N,Z,C,I,D,V</td>
		</tr>

		<tr>
			<td>ROL</td>
			<td>Shift bits in selected value one bit to the left (bit from carry goes to bit 0 in 
			selected value, and bit 7 from selected value goes to carry).</td>
			<td>
	<pre><code>
		clc ; Clear the carry
		lda %1111000
		sta $FF ; Value stored at $FF is now %11110000
		rol $FF ; Value stored at $FF is now %11100000, carry flag is also now set
	</code></pre>
			</td>
			<td>As with LSR and ROR, can shift bits in accumulator by calling command without a value, 
			e.g. ROL</td>
			<td>N,Z,C</td>
		</tr>

		<tr>	
			<td>ROR</td>
			<td>Similar to ROL but bits shift to the right instead of the left.</td>
			<td>
	<pre><code>
		clc ; Clear the carry
		lda %00001111
		sta $FF ; Value stored at $FF is now %00001111
		ror $FF ; Value stored at $FF is now %00000111, carry flag is now set
	</code></pre>
			</td>
			<td>Similar usage to LSR and ROL.</td>
			<td>N,Z,C</td>
		</tr>

		<tr>
			<td>RTI</td>
			<td>Return from interrupt.</td>
			<td>
	<pre><code>
		rti
	</code></pre>
			</td>
			<td>Similar to RTS but used at the end of an interrupt (e.g. NMI or IRQ).</td>
			<td>N,Z,C,I,D,V</td>
		</tr>

		<tr>
			<td>RTS</td>
			<td>Return from subroutine.</td>
			<td>
	<pre><code>
		lda #12 ; Value in accumulator is 12
		jsr someSubroutine ; Go to someSubroutine
		sta $FF ; Value stored at $FF is 11, not 12
	someSubroutine:
		sta $FE ; Value in accumulator stored at $FE
		lda #11 ; Value in accumulator is now 11
		rts  ; Return from subroutine
	</code></pre>
			</td>
			<td>Make sure to include this at the end of your subroutines to ensure your code flows in 
			the right order!</td>
			<td></td>
		</tr>

		<tr>
			<td>SBC</td>
				<td>Acts like normal subtraction if carry is set. See notes to the right.</td>
			<td>
	<pre><code>
		sec ; Set carry
		lda #1
		sbc #1 ; Value in accumulator now 0
	</code></pre>
			</td>
			<td>The SEC part is a bit tricky to understand when starting out, but it has to do with 
			two's-complement notation, and how the 6502 stores negative numbers. See more info on 
			negative numbers here:
			<a href = "coding.html#negative">Negative numbers on the 6502</a> page.
			</td>
			<td>N,Z,C,V</td>
		</tr>

		<tr>
			<td>SEC</td>
			<td>Sets the carry.</td>
			<td>
	<pre><code>
		(see code example for sbc above)
	</code></pre>
			</td>
			<td>(See notes for SBC above.)</td>
			<td>C</td>
		</tr>

		<tr>
			<td>SED</td>
			<td>Enables binary decimal mode, which doesn't work for the NES (so don't use this!)</td>
			<td>
	<pre><code>
		(None. Don't use this command!)
	</code></pre>
			</td>
			<td>
			Some 6502 devices can make use of binary decimal mode, but the NES is not one of them, so you 
			will never need this command. <span class="important">Don't use this command, ever!!!</span>
			</td>
			<td></td>
		</tr>

		<tr>
			<td>SEI</td>
			<td>Sets interrupt flag (most interrupts will no longer occur).</td>
			<td>
	<pre><code>
		sei
	</code>
	</pre>
			</td>
			<td>
			A great piece of code to put in your initialization/reset section of your code, if you want 
			greater control over what happens with the NES hardware. As vblank is an NMI (non-maskable 
			interrupt), this will not stop the screen from refreshing, so keep that in mind when using 
			SEI.</td>
			<td>I</td>
		</tr>

		<tr>
			<td>STA</td>
			<td>Stores the value in accumulator to selected address.</td>
			<td>
	<pre><code>
		lda #11 ; Value of accumulator is set to 11
		sta $2032 ; Stores value of 11 to address $2032
	</code>
	</pre>
			</td>
			<td>
			Can reuse the "same" accumulator value over and over again (aka STA doesn't reset or 
			eliminate value stored in accumulator).
			</td>
			<td></td>
		</tr>	

		<tr>
			<td>STX</td>
			<td>Similar to STA but for x register.</td>
			<td>
	<pre><code>
		ldx #$FE ; Hex value $FE loaded into x register
		stx $FD ; Value $FE stored at zero-page address $FD
	</code>
	</pre>
			</td>
			<td> Similar functionality to STA and STY.
			</td>
			<td></td>
		</tr>

		<tr>
			<td>STY</td>
			<td>Similar to STX but for y register.</td>
			<td>
	<pre><code>
		ldy #$AA ; Hex value $AA stored in y register
		sty $AB ; Value $AA store at zero-page register $AB
	</code>
	</pre>
			</td>
			<td>
				Similar functionality to STA and STX.
			</td>
			<td></td>
		</tr>

		<tr>
			<td>TAX</td>
			<td>Transfer value from accumulator to x register.</td>
			<td>
	<pre><code>
		lda $02	; Load value from zero page address $02
		asl		; Multiply accumulator by 2
		tax 	; Store value in x-register
	</code>
	</pre>
			</td>
			<td>Most common usage is when you need to modify an index using accumulator-based 
			commands like ASL, ADC, etc.</td>
			<td>N,Z</td>
		</tr>

		<tr>
			<td>TAY</td>
			<td>Transfer value from accumulator to y register.</td>
			<td>
	<pre><code>
		lda #55
		tay ; value in y-register and accumulator are now both 55
	</code>
	</pre>
			</td>
			<td>Similar usage to TAX.</td>
			<td>N,Z</td>
		</tr>

		<tr>
			<td>TSX</td>
			<td>Transfer value from "top" of stack to x register.</td>
			<td>
	<pre><code>
		lda #55
		pha ; Value from accumulator pushed to stack
		tsx ; Value in x-register is now 55
	</code>
	</pre>
	</td>
			<td>Usually follows somewhere after a TXS.</td>
			<td>N,Z</td>
		</tr>

		<tr>
			<td>TXA</td>
			<td>Transfer value from x register to accumulator.</td>
			<td>
	<pre><code>
		ldx #65
		txa ; value in x-register and accumulator are now both 65
	</code>
	</pre>
			</td>
			<td>There is no direct way to transfer from x register to y register, but you can create a 
			"TXY" of sorts by using TXA followed by TAY.</td>
			<td>N,Z</td>
		</tr>

		<tr>
			<td>TXS</td>
			<td>Transfer value from x register to "top" of stack.</td>
			<td>
	<pre><code>
		ldx #75
		txs ; Value on top of stack is now 75
		pla ; This would set accumulator to 75 and "pull" that off the stack
	</code>
	</pre>
			</td>
			<td>In most cases, a TXS has a complementary TSX somewhere nearby in the code.</td>
			<td></td>
		</tr>

		<tr>
			<td>TYA</td>
			<td>Transfer value from y register to accumulator.</td>
			<td>
	<pre><code>
		ldy #$85 ; Load hex value 85 into y register
		tya ; value in y-register and accumulator are now both hex 85 (or 133 in decimal)
	</code>
	</pre>
			</td>
			<td>To make a transfer from y register to x register, simply use TYA followed by TAX.</td>
			<td>N,Z</td>
		</tr>
	</table>
	
