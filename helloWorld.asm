	; Code starts at $C000.
	; org jump to $BFFO for header info

	org $BFF0	
	db "NES",$1a		; Default NES header info
	db $1			; Number of PRG-ROM pages
	db $1			; Number of CHR-ROM pages
	db %00000000		; Mapper and otherinfo.
	db %00000000		; More mapper/other info.
	db 0			; Number of Ram pages
	db 0,0,0,0,0,0,0	; Unused 7 bytes

; The nmihandler is basically the code that runs
; every time the screen refreshes, which happens
; about 60 times a second.


nmihandler:
	lda #$02 	; Transfer sprite data from
	sta $4014	; from $0200 to DMA
	rti

irqhandler:
	rti


; startgame is code that runs everytime the game 
; is turned on or reset.

startgame:
	sei		; Disable interrupts
	cld		; Clear decimal mode

	ldx #$ff	
	txs		; Set-up stack
	inx		; x is now 0
	stx $2000	; Disable/reset graphic options 
	stx $2001	; Make sure screen is off
	stx $4015	; Disable sound
	stx $4010	; Disable DMC (sound samples)
	lda #$40
	sta $4017	; Disable sound IRQ
	lda #0	
waitvblank:
	bit $2002	; check PPU Status to see if
	bpl waitvblank	; vblank has occurred.
	lda #0
clearmemory:		; Clear all memory info
	sta $0000,x
	sta $0100,x
	sta $0300,x
	sta $0400,x
	sta $0500,x
	sta $0600,x
	sta $0700,x
	lda #$FF
	sta $0200,x	; Load $FF into $0200 to 
	lda #$00	; hide sprites 
	inx		; x goes to 1, 2... 255
	cpx #$00	; loop ends after 256 times
	bne clearmemory ; clearing all memory
		



waitvblank2:
	bit $2002	; check PPU Status one more time
	bpl waitvblank2	; before we start loading in graphics

	lda $2002	; read PPU status to reset high-low latch
	ldx #$3F	; Load high byte of $3F00 into $2006
	stx $2006
	ldx #$00	; Load low byte of $3F00 into $2006
	stx $2006
copypalloop:	
	lda initial_palette,x	; start storing palette info
	sta $2007
	inx
	cpx #4			
	bcc copypalloop

	lda #$02	; store sprite info 
	sta $4014	; into OAM DMA

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

