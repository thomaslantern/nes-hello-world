
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

	lda #$02
	sta $4014
	
	rti


irqhandler:
	rti


startgame:
	sei
	cld

	ldx #$ff
	txs
	inx
	stx $2000
	stx $2001
	stx $4015
	stx $4010
	lda #$40
	sta $4017
	lda #0	
waitvblank:
	bit $2002
	bpl waitvblank
	lda #0
clearmemory:
	sta $0000,x
	sta $0100,x
	sta $0300,x
	sta $0400,x
	sta $0500,x
	sta $0600,x
	sta $0700,x
	lda #$FF
	sta $0200,x
	lda #$00
	inx
	cpx #$00
	bne clearmemory
		



waitvblank2:
	bit $2002
	bpl waitvblank2

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
	lda #$02
	sta $4014

;LOADING SPRITES
	LDX #$00
LOADSPRITES:
	LDA hello,x
	STA $0200,x
	INX
	CPX #$2C
	BNE LOADSPRITES

	lda #%10010000
	sta $2000

	lda #%00011110
	sta $2001


forever:
	jmp forever



initial_palette:
	db $1F,$21,$33,$30

hello:
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

