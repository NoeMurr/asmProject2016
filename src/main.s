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
    .globl input_fd   # troppe
    .globl output_fd  # variabili
    .globl init       # globali
    .globl reset      # non
    .globl rpm        # vanno
    .globl alm        # affatto
    .globl numb       # bene
    .globl mod        # cattiva
    .globl _start     # programmazione

    # Stringa per mostrare l'utilizzo del programma in caso di parametri errati
    usage: .asciz "usage: programName inputFilePath outputFilePath\n"     
    .equ USAGE_LENGTH, .-usage

_start:
    movl %esp, %ebp

    # Composizione stack:
    # (%ebp)   - argc
    # 4(%ebp)  - argv[0] - nome eseguibile
    # 8(%ebp)  - argv[1] - file di input
    # 12(%ebp) - argv[2] - file di output

    ## if (argc < 3) goto _show_usage
    cmpl $3, (%ebp)
    jne  _show_usage

    ## (input_fd, output_fd) = open_files(argv[1], argv[2]); 
    movl 8(%ebp), %edi
    movl 12(%ebp), %esi
    call open_files
    movl %edi, input_fd
    movl %esi, output_fd

_main_loop:

    # Leggiamo la riga 
    call    read_line

    # Caso EOF
    cmpl $-1, %ebx
    je _end

    # Controllo delle variabili 
    call    check

    # Scrittura della riga di output su file 
    call    write_line

    # Leggi un altra riga fino che non trovi la fine del file
    jmp _main_loop

_end:
    
    ## close_files(input_fd, output_fd)
    call close_files

    ## sys_exit(0);
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
