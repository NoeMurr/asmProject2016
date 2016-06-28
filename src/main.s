# Progetto assembly 2016
# File: main.s
# Data: 2016
# Autori: Alessandro Righi, Noè Murr, Mirko Morati
# Descrizione: entry point del programma

.include "syscall.inc"

# variabili globali

.section .data
#NB: per ora teniamo di default STDIN ed STDOUT, se uno non apre file
input_fd: .long 0 				# variabile globale che conterra' il file
                                # descriptor del file di input

output_fd:  .long 0 			# variabile globale che conterra' il file
                                # descriptor del file di output

# Variabili globali per i segnali di input 
init: .long 0                                                                 
reset: .long 0                  
rpm: .long 0

# Variabili globali per i sengali di output 
alm: .long 0
numb: .long 0
mod: .long 0

.section .bss

# codice del programma
.section .text
    .globl input_fd
    .globl output_fd
    .globl init
    .globl reset
    .globl rpm
    .globl alm
    .globl numb
    .globl mod
    .globl _start

    # Stringa per mostrare l'utilizzo del programma in caso di parametri errati
    usage: .asciz "usage: programName inputFilePath outputFilePath\n"     
    .equ USAGE_LENGTH, .-usage

_start:
    # recupero i parametri del main
    popl %eax   # numero parametri

    # Controllo argomenti se sbagliati mostro l'utilizzo corretto
    cmpl $3, %eax
    jne  _show_usage

    popl %eax   # nome programma
    popl %eax   # primo parametro
    popl %ebx   # secondo parametro

    # NB: non salvo ebp in quanto non ha alcuna utilità farlo
    # nella funzione start che comunque non ritorna
    movl %esp, %ebp

    # Apertura dei file 
    call _open_files

    # 4) chiudo tutti i file, esco dal programma correttamente

_main_loop:

    # Leggiamo la riga 
    call    _read_line

    # Caso EOF
    cmpl $-1, %ebx
    je _end

    # Controllo delle variabili 
    call    _check

    # Scrittura della riga di output su file 
    call    _write_line

    # Leggi un altra riga fino che non trovi la fine del file
    jmp _main_loop

_end:
    
    call _close_files

    # sys_exit(0);
    movl $SYS_EXIT, %eax
    movl $0, %ebx
    int $SYSCALL

_show_usage:
    # esce in caso di errore
    # sys_write(stdout, usage, USAGE_LENGTH);
    movl $SYS_WRITE, %eax
    movl $STDOUT, %ebx
    movl $usage, %ecx
    movl $USAGE_LENGTH, %edx
    int $SYSCALL

    # sys_exit(1);
    movl $SYS_EXIT, %eax
    movl $1, %ebx
    int $SYSCALL
