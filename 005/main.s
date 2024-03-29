;==========================================================================================
; Project:  <nome del progetto/modulo/file>
; Date:     <data>
; Author:   <autore>
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  <inserire una breve descrizione del progetto/modulo/libreria>
;  <specifiche del progetto/modulo/libreria>
;  <specifiche del collaudo>
;
; Ver   Date        Comment
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 1.0   24/10/16    Versione iniziale
; <Descrivere per ogni revisione o cambio di versione le modifiche apportate>
; 
;==========================================================================================
;------------------------------------------------------------------------------------------
;=== COSTANTI =============================================================================
;------------------------------------------------------------------------------------------

	THUMB
;------------------------------------------------------------------------------------------
;=== AREA DATI RAM ========================================================================
;------------------------------------------------------------------------------------------
	AREA MyDataRam, DATA, ALIGN = 2
 
;------------------------------------------------------------------------------------------
;=== AREA DATI FLASH ======================================================================
;------------------------------------------------------------------------------------------
	AREA MyDataFlash, CODE, ALIGN = 2

;------------------------------------------------------------------------------------------
;=== AREA ISTRUZIONI ======================================================================
;------------------------------------------------------------------------------------------
	AREA MyCode, CODE, READONLY
	;------------------
	; EXPORT/IMPORT
	;------------------
	EXPORT __main

	ENTRY
;------------------------------------------------------------------------------------------
;=== MAIN ROUTINE =========================================================================
;------------------------------------------------------------------------------------------
__main

	;Scrivere in memoria all'indirizzo 
	;0x2000 0000 la costante 0xABB1FEDE
	MOV  R0, #0xFEDE
	MOVT R0, #0xABB1
	
	MOV  R1, #0x0000
	MOVT R1, #0x2000
	
	STR  R0, [R1]
	
	LDR R1,=0x20000004 

	LDR r0, [r1] ; load value of x from memory
	ADD r0, r0, #1 ; x = x + 1 # means “immediate”
	STR r0, [r1] ; store x into memory

	

stop B stop
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	ALIGN
	END

	

