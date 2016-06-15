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
    pushl %ebp
    movl %esp, %ebp

    # codice della funzone
    
    movl %ebp, %esp
    popl %ebp
    ret
