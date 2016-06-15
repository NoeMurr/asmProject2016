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
	
    # sys_exit(0); 
    movl $SYS_EXIT, %eax
    movl $0, %ebx
    int $SYSCALL
 
