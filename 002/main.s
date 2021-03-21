;==========================================================================================
; Project:  
; Date:     
; Author:   
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;
;  <inserire una breve descrizione del progetto>
;
;  <specifiche del progetto>
;  <specifiche del collaudo>
;
; Ver   Date        Comment
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 1.0  01/01/01     Versione iniziale
; <Descrivere per ogni revisione o cambio di versione le modifiche apportate>
;
;==========================================================================================
		THUMB

;------------------------------------------------------------------------------------------
;=== COSTANTI =============================================================================
;------------------------------------------------------------------------------------------
GPIOB_MODER   EQU 0x48000400
GPIOB_ODR     EQU 0x48000414
GPIOE_MODER   EQU 0x48001000
GPIOE_ODR     EQU 0x48001014
RCC_CR_AHB2   EQU 0X4002104C

PB2_PORT_AHB2_BIT EQU 0x1
PB2_MODERH_BIT    EQU 0x5
PB2_MODERL_BIT    EQU 0x4
PB2_ODR_BIT       EQU 0x2

;------------------------------------------------------------------------------------------
;=== AREA ISTRUZIONI ======================================================================
;------------------------------------------------------------------------------------------
		AREA MyCode, CODE, READONLY
		ALIGN
		;------------------
		; EXPORT/IMPORT
		;------------------
		EXPORT __main
		ENTRY

;------------------------------------------------------------------------------------------
;=== MAIN ROUTINE =========================================================================
;------------------------------------------------------------------------------------------
__main
		; Inizializzazioni
		BL LedRossoInit
		;BL LedVerdeInit

		; Autodiagnostica
		;BL LedTest

		; Loop infinito
MainLoop
		MOV R0,#1000
		BL	DelayMs
		BL	LedRossoToggle
		B MainLoop 

;------------------------------------------------------------------------------------------
;=== SUB ROUTINE ==========================================================================
;------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------
; Configurazione del pin dove è collegato il led rosso come output digitale
;  INPUT:  none
;  OUTPUT: none
;  AUTORE: Filippo Bilardo
;  29/03/19  1.0  Versione iniziale
;-----------------------------------------------------------------------------------------
LedRossoInit
		PUSH{LR, R0-R1}
		LDR R0,=RCC_CR_AHB2
		LDR R1,[R0]
		ORR R1,#1<<PB2_PORT_AHB2_BIT
		STR R1,[R0]
		LDR R0,=GPIOB_MODER
		LDR R1,[R0]
		BIC R1,#1<<PB2_MODERH_BIT
		ORR R1,#1<<PB2_MODERL_BIT
		STR R1,[R0]
		POP{LR, R0-R1}
		BX LR

;-----------------------------------------------------------------------------------------
; LedToggle - Exor con 1 del bit corrispondente al pin dove è collegato il LED
;  INPUT:  none
;  OUTPUT: none
;  AUTORE: Filippo Bilardo
;  29/03/19  1.0  Versione iniziale
;-----------------------------------------------------------------------------------------
LedRossoToggle
		PUSH{LR, R0-R1}
		LDR R0,=GPIOB_ODR
		LDR R1,[R0]
		EOR R1,#1<<PB2_ODR_BIT
		STR R1,[R0]
		PUSH{LR, R0-R1}
		BX LR

;-----------------------------------------------------------------------------------------
; Lampeggio del led rosso presente nella scheda
;
;  INPUT:  R0 numero di lampeggi; R1 ritardo in ms
;  OUTPUT: none
;  AUTORE: 
;  01/01/01  1.0  Versione iniziale
;-----------------------------------------------------------------------------------------
LedRossoBlink
		BX LR
		
;-----------------------------------------------------------------------------------------
; 10 lampeggi dei led rosso e verde ad intervalli di 100ms;
;  INPUT:  none
;  OUTPUT: none
;  AUTORE: 
;  01/01/01  1.0  Versione iniziale
;-----------------------------------------------------------------------------------------
LedTest
    BX LR
		
;-----------------------------------------------------------------------------------------
; Esegue R0 volte il ritardo di 1ms. (+1,75us)
; A 4Mhz ogni istruzione viene esguita in 250ns
; Il ciclo DelayMs_1ms è composto da 5 x nCICLI istruzioni.
; Quindi 5*nCICLI*250ns = 1ms -> nCICLI = 1.000.000/5/250 = 800
;  INPUT:  R0 -> Ritardo in millisecondi
;  OUTPUT: none
;  AUTORE: Filippo Bilardo
;  21/03/21  1.0  Versione iniziale
;-----------------------------------------------------------------------------------------	
DelayMs
		PUSH {R1-R2, LR}    ;1 
		MOV R2,#800         ;2 - nCICLI da eseguire per ogni ms
		MUL R0,R0,R2        ;3 - converto i millisecondi in num cicli
		MOV R1,#0x0         ;4 - i=0
DelayMs_1ms
		CMP R0,R1           ;n1 - Comparo il valore del registro r2 con r1
		BEQ DelayMs_end     ;n2 - Se è uguale salto a end
		ADD R1,#0x1         ;n3 - Incremento la i 
		B DelayMs_1ms       ;n4,n5 - Salto a Inizio (consuma due cicli istruzione)
DelayMs_end
		POP {R1-R2, LR}     ;5
		BX LR               ;6,7

;------------------------------------------------------------------------------------------
		ALIGN
		END
;------------------------------------------------------------------------------------------
		
	

