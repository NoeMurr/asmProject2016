# Progetto assembly 2016
# File: main.s
# Date: 2016
# Authors: Alessandro Righi, Noè Murr, Mirko Morati
# Descrizione: entry point del programma

.incluce "syscall.inc"

# variabili globali
.text
input_filename: "input.txt"
output_filename: "output.txt"
.data
# variabili modificabili
.bss
# variabili modificalibi inizializzate a 0

# codice del programma
.text
.global funzione
.type funzione, @function
_start:
    pushl %ebp
    movl %esp, %ebp

    # codice della funzone
    
    movl %ebp, %esp
    popl %ebp
    ret
