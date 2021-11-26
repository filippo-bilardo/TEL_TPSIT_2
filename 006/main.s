;==========================================================================================
; Project:  Istruzioni artmetiche
; Date:     26/11/21
; Author:   
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;  Collaudo istruzioni artimetiche
;
; Ver   Date        Comment
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 1.0   26/11/21    Versione iniziale
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

	; ESEMPIO 1 - Collaudo del codice con il Debugger
	; Azzerare il bit 10 della word con indirizzo 0x20000004
	MOV r0,#0x4
	MOVT r0,#0x2000 ;indirizzo della parola
	LDR r1,[r0]     ;carico in r1 la parola
	;Prima soluzione
	BIC r1,#0x400   ;0x400=0b100.0000.0000 bit 10
	;Seconda soluzione
	BIC r1,#1<<10   ;1 spostato a sinistra di 10 posti
	STR r1,[r0]     ;scrivo il valore modificato

	; ESEMPIO 2 - This program will calculate the value 
	; of the following function:
	; f(x) = 5x^2 - 6x + 8   when x=10.
	MOV R0, #10     ;x=10
	MUL R1, R0, R0	;R1=x^2
	MOV R4, #5
	MUL R1, R1, R4	;R1=5X^2
	MOV R5, #6
	MUL R2, R0, R5	;R2=6x
	SUB R3, R1, R2	;R3=5x^2-6x
	ADD R3, R3, #8  ;R3=5x^2-6x+8 - f(x)=0x1C0=448
	
	;ESERCIZIO a - Collaudare il seguente codice
	;Mettere a 1 il bit 15 della parola con indirizzo 0x20000018
	MOV r0,#0x18
	MOVT r0,#0x2000 ;indirizzo della parola
	LDR r1,[r0]     ;carico in r1 la parola
	;Prima soluzione
	ORR r1,#0x8000  ;0x8000=0b1000.0000.0000.0000 bit 15
	;Seconda soluzione
	ORR r1,#1<<15   ;1 spostato a sinistra di 15 posti
	STR r1,[r0]     ;scrivo il valore modificato


	;ESERCIZIO b - Collaudare il seguente codice
	;Azzerare i bit 5, 6 e 7 della parola 
	;con indirizzo 0x20000014
	MOV r0,#0x14
	MOVT r0,#0x2000 ;indirizzo della parola
	LDR r1,[r0]     ;carico in r1 la parola
	BFC r1,#5,#3    ;lsb=5 width=3
	STR r1,[r0]     ;scrivo il valore modificato	


	;ESERCIZIO c - Collaudare il seguente codice
	;Scrivere un programma che legga tre word agli indirizzi 
	;0x20000000, 0x20000004 e 0x20000008, li sommi e salvi 
	;il risultato all'indirizzo 0x2000000C.
	;Prima soluzione
	MOV r2,#0x0     ;azzero registro risultato
	MOV r0,#0x0
	MOVT r0,#0x2000 ;indirizzo del primo numero
	LDR r1,[r0]     ;carico in r1 il primo numero
	ADD r2,r1       ;prima somma r2= 0 + num1
	MOV r0,#0x4
	MOVT r0,#0x2000 ;indirizzo del secondo numero
	LDR r1,[r0]     ;carico il secondo numero
	ADD r2,r1       ;seconda somma r2=num1+num2
	MOV r0,#0x8
	MOVT r0,#0x2000 ;indirizzo del terzo numero
	LDR r1,[r0]     ;carico il terzo numero
	ADD r2,r1       ;terza somma r2=num3 + num1+num2
	MOV r0,#0xC
	MOVT r0,#0x2000 ;indirizzo del risultato
	STR r2,[r0]     ;scrivo il risultato in memoria

	;Seconda soluzione 
	MOV r2,#0x0     ;azzero registro risultato
	MOV r0,#0x0
	MOVT r0,#0x2000 ;indirizzo del primo numero
	LDR r2,[r0],#4  ;r2 <- primo numero, r0=0x20000004
	LDR r1,[r0],#4  ;r1 <- secondo numero, r0=0x20000008
	ADD r2,r1       ;somma r2=num1+num2
	LDR r1,[r0],#4  ;r1 <- terzo numero r0=0x2000000C
	ADD r2,r1       ;terza somma r2=num1+num2+num3
	STR r2,[r0]     ;scrivo il risultato in memoria


	;ESERCIZIO d - Collaudare il seguente codice
	;Sommare 2 vettori di 2 byte. Il primo si trova
	;all'indirizzo 0x20000000 e il secondo all'indirizzo
	;0x20000006. Salvare il risultato nel vettore a partire
	;dall'indirizzo 0x2000000A.
	;Prima soluzione
	MOV  r0,#0x0
	MOVT r0,#0x2000 ;indirizzo del primo vettore vet1
	MOVT r1,#0x6
	MOVT r1,#0x2000 ;indirizzo del secondo vettore vet2
	MOVT r2,#0xA
	MOVT r2,#0x2000 ;indirizzo vettore risultato
	LDRB r3,[r0],#1 ;r3 <- primo numero vet1 r0=0x20000001
	LDRB r4,[r1],#1 ;r4 <- primo numero vet2 r1=0x20000007
	ADD  r4,r3      ;r4=r4+r3
	STRB r4,[r2],#1 ;salvo il primo termine r2=0x2000000B
	LDRB r3,[r0]    ;r3 <- secondo numero vet1
	LDRB r4,[r0]    ;r4 <- secondo numero vet2
	ADD  r4,r3      ;terza somma r2=num1+num2+num3
	STRB r4,[r2]    ;salvo il secondo termine
	
	;Seconda soluzione
	MOV  r0,#0x0
	MOVT r0,#0x2000 ;indirizzo del primo vettore vet1
	LDRB r1,[r0]    ;r1 <- primo numero vet1
	LDRB r2,[r0,#6] ;r2 <- primo numero vet2
	ADD  r2,r1      ;r2=r2+r1
	STRB r2,[r0,#0xA] ;salvo il primo termine
	ADD  r0,#1
	LDRB r1,[r0]    ;r1 <- secondo numero vet1
	LDRB r2,[r0,#6] ;r2 <- secondo numero vet2
	ADD  r2,r1      ;r2=r2+r1
	STRB r2,[r0,#0xA] ;salvo il secondo termine


stop B stop
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	ALIGN
	END
