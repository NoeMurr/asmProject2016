# Progetto assembly 2016
# File: main.s
# Data: 2016
# Autori: Alessandro Righi, Noè Murr, Mirko Morati
# Descrizione: entry point del programma

.include "syscall.inc"

# variabili globali
.text
input_filename: .asciz "input.txt"
output_filename: .asciz "output.txt"
.data
# variabili modificabili
.bss
# variabili modificalibi inizializzate a 0

# codice del programma
.text
.global _start
_start:
    # NB: non salvo ebp in quanto non ha alcuna utilità farlo
    # nella funzione start che comunque non ritorna
    movl %esp, %ebp
	
    # cosa va implementato qua:
    # 1) controllo e parsing degli argomenti della riga di comando
    # 2) apertura dei file, controllo corretta apertura dei file
    # 3) entro un un loop in cui 
    #   a) leggo una riga dal file input, se EOF salto a 4
    #   b) elaboro la riga in una struttura dati da definire
    #   c) scelgo cosa fare in base allo stato precedente
    #   d) scrivo una rida nel file di output 
    # 4) chiudo tutti i file, esco dal programma correttamente

    # sys_exit(0); 
    movl $SYS_EXIT, %eax
    movl $0, %ebx
    int $SYSCALL
 
