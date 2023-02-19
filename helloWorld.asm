
	org $BFF0
	db "NES",$1a
	db $1
	db $1
	db %00000000
	db %00000000
	db 0
	db 0,0,0,0,0,0,0


curs_x equ $40
curs_y equ curs_x+1

vblanked equ $7f


nmihandler:
	pha
	php
		inc vblanked
	plp
	pla

backgroundupdate:
	ldx #$20
	stx $2006
	ldx #$00
	stx $2006
	ldx #$00
	stx $2007
	stx $2007

	
	ldx #$00 	; Set SPR-RAM address to 0
	stx $2003
spriteloop:
	lda hello,x
	sta $2004
	inx
	cpx #$34
	bne spriteloop
	rti


irqhandler:
	rti


startgame:
	sei
	cld

	ldx #$ff
	txs
	
	lda $2002
	ldx #$3F
	stx $2006
	ldx #$00
	stx $2006
copypalloop:
	lda initial_palette,x
	sta $2007
	inx
	cpx #4
	bcc copypalloop
	

	lda #%00011110
	sta $2001
	lda #$90
	sta $2000


forever:
	jmp forever



initial_palette:
	db $1F,$21,$33,$30

hello:
	db $00, $00, $00, $00 ; not sure why necessary
	db $00, $00, $00, $00 ; not sure why necessary

	db $6c, $00, $00, $3d ; H
	db $6c, $01, $00, $46 ; E
	db $6c, $02, $00, $4f ; L
	db $6c, $02, $00, $58 ; L
	db $6c, $03, $00, $61 ; O

	db $75, $04, $00, $3d ; W
	db $75, $03, $00, $46 ; O
	db $75, $05, $00, $4f ; R
	db $75, $02, $00, $58 ; L
	db $75, $06, $00, $62 ; D
	db $75, $07, $00, $6b ; !


	org $FFFA
	dw nmihandler
	dw startgame
	dw irqhandler

CHRROM_START:

	db %11000011	; H (00)
	db %11000011
	db %11000011
	db %11111111
	db %11111111
	db %11000011
	db %11000011
	db %11000011
	db $00, $00, $00, $00, $00, $00, $00, $00

	db %11111111	; E (01)
	db %11111111
	db %11000000
	db %11111100
	db %11111100
	db %11000000
	db %11111111
	db %11111111
	db $00, $00, $00, $00, $00, $00, $00, $00

	db %11000000	; L (02)
	db %11000000
	db %11000000
	db %11000000
	db %11000000
	db %11000000
	db %11111111
	db %11111111
	db $00, $00, $00, $00, $00, $00, $00, $00

	db %01111110	; O (03)
	db %11100111
	db %11000011
	db %11000011
	db %11000011
	db %11000011
	db %11100111
	db %01111110
	db $00, $00, $00, $00, $00, $00, $00, $00

	db %11000011	; W (04)
	db %11100111
	db %11000011
	db %11000011
	db %11011011
	db %11011011
	db %11100111
	db %01000010
	db $00, $00, $00, $00, $00, $00, $00, $00

	db %01111110	; R (05)
	db %11100111
	db %11000011
	db %11000011
	db %11111100
	db %11001100
	db %11100110
	db %11000011
	db $00, $00, $00, $00, $00, $00, $00, $00

	db %11110000	; D (06)
	db %11001110
	db %11000010
	db %11000011
	db %11000011
	db %11000010
	db %11001110
	db %11110000
	db $00, $00, $00, $00, $00, $00, $00, $00

	db %00011000	; ! (07)
	db %00011000
	db %00011000
	db %00011000
	db %00011000
	db %00000000
	db %00011000
	db %00011000
	db $00, $00, $00, $00, $00, $00, $00, $00


CHRROM_END:

; Pad chr-rom to 8k(to make valid file)
	ds 8192-(CHRROM_END-CHRROM_START)

