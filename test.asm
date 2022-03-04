.org $0000

OSHeader:
    jr Boot
    .db 0,0,0,0,0,0
    .db 0, 0 ; rst 08h
    .db 0,0,0,0,0
    .db 0, 0   ; rst 10h
    .db 0,0,0,0,0
    .db 0,0   ; rst 18h
    .db 0,0,0,0,0
    .db 0, 0 ; rst 20h
    .db 0,0,0,0,0
    .db 0,0   ; rst 28h
    .db 0,0,0,0,0
    .db 0,0   ; rst 30h
    .db 0,0,0,0,0,0,0
    .db 0,0 ; rst 38h / System Interrupt
    .db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    .db 0,0,0,0,0,0,0,0,0
    jp Boot
    .dw 0A55Ah
Boot:
        ; This executes at boot
    ld a, $ff
    halt

;     ; LCD setup
;     ld a, 40h
;     out (10h), a
;     ld a, 05h
;     call LCDDelay
;     out (10h), a
;     ld a, 01h
;     call LCDDelay
;     out (10h), a
;     ld a, 3
;     call LCDDelay
;     out (10h), a
;     ld a, 0F6h
;     call LCDDelay
;     out (10h), a
; 
; ; System Interrupt Routines
; SysInterrupt:
;     exx
;     ex af, af'
;     in a, (04h)
;     bit 0, a
;     jr nz, HandleON
;     bit 1, a
;     jr nz, HandleTimer1
;     bit 2, a
;     jr nz, HandleTimer2
;     bit 4, a
;     jr nz, HandleLink
;     jr InterruptDone
; HandleON:
;     in a, (03h)
;     res 0, a
;     out (03h), a
;     set 0, a
;     out (03h), a
;     ; ON interrupt
;     jr InterruptDone
; HandleTimer1:
;     in a, (03h)
;     res 1, a
;     out (03h), a
;     set 1, a
;     out (03h), a
;     ; Timer one interrupt (might be best to merge with timer 2)
;     jr InterruptDone
; HandleTimer2:
;     in a, (03h)
;     res 2, a
;     out (03h), a
;     set 2, a
;     out (03h), a
;     ; Timer two interrupt
;     jr InterruptDone
; HandleLink:
;     in a, (03h)
;     res 4, a
;     out (03h), a
;     set 4, a
;     out (03h), a
;     ; Link interrupt
; InterruptDone:
;     ex af, af'
;     exx
;     ei
;     ret