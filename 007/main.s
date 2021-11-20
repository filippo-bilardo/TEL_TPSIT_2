;==========================================================================================
; Project:  ES03 - Istruzioni di spostamento dati
; Date:     20/11/21
; Author:   <autore> 
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  Collaudo di istruzioni di spostamento dati
;
; Ver   Date        Comment
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 1.0   20/11/21    Versione iniziale
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

	;Esempio 1
	; x = x + 1
	LDR R1,=0x20000000 
	LDR r0, [r1] 	;load value of x from memory [r1]
	ADD r0, r0, #1  ;Aggiungo a R0 #1 ; '#' means "immediate"; R0=R0+1
	STR r0, [r1] 	;Salvo r0 in memoria [r1] 

	;Esercizio a - Esempi LOAD
	;caricare in memoria 4 byte a piacere all'indirizzo 0x20000000
	LDR   R0,=0x20000000 
	LDRB  r1,[r0]   ;load value of x from memory
	LDRH  r2,[r0]   ;load value of x from memory
	LDRSB r3,[r0]   ;load value of x from memory
	LDRSH r4,[r0]   ;load value of x from memory

	;Esercizio b - Esempi STORE
	;Tramite le opportune catture del debugger e commenti, 
	; dimostrare di aver codificato correttamente le istruzioni di store seguenti
	LDR R0,=0x20000000 
	LDR R1,=0xA0201504
	STR R1, [R0]
	LDR R0,=0x20000004 
	STRB R1, [R0]
	LDR R0,=0x20000008 
	STRH R1, [R0]
	
	;Esercizio c - LOAD e STORE con indirizzamento indicizzato
	;Tramite le opportune catture del debugger e commenti, 
	; dimostrare di aver codificato correttamente le istruzioni di 
	; LOAD e STORE con indirizzamento indicizzato
	LDR R0,=0x20000000 
	LDR R1, [R0, #4]
	LDR R1, [R0], #4
	LDR R1, [R0, #4]!
	;
	LDR R0,=0x20000004
	LDR R1,=0xA0201504
	STR r1, [r0,#4]
	STR r1, [r0],#4
	STR r1, [r0,#4]!

	;Esercizio d - Istruzione di spostamento dato tra registri
	MOV r1,r0 		;scrive il contenuto di r0 in r1
	MOV r1,#0xA2 	;scrive la costante 0xA2 in r1 r1=0x000000A2
	;Caricare la costante 0x20000010 nel registro r0
	MOV r0,#0x0010
	MOVT r0,#0x2000
	
	;Esercizio e
	;Copiare il contenuto del registro r4 in r2
	;Scrivere la costante 0x3A nel registro r0
	;Scrivere in memoria il contenuto del registro r0 all'indirizzo contenuto nel registro r4
	;Scrivere in memoria un byte contenuto in r0 all'indirizzo contenuto in r4 più un offset di 4
	;Scrivere le istruzioni per caricare in memoria all'indirizzo 0x20000020 il numero 0xABB1FEDE
	
	;Esercizio f
	;scrivere in memoria a partire dall'indirizzo 0x20000000 
	;11 byte a piacere. Scrivere qui i valori caricati in memoria.
	;riportare nei commenti il contenuto di r0 e di r1 dopo 
	;l'esecuzione di ognuna delle seguenti istruzioni:
	LDRB  r1,[r0]       ;r1= ,r0=
	LDRH  r1,[r0,#6]    ;r1= ,r0=		
	LDR   r1,[r0,#4]!   ;r1= ,r0=
	LDRSB r1,[r0]       ;r1= ,r0=
	LDRB  r1,[r0],#2    ;r1= ,r0=

stop B stop
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	ALIGN
	END

	

