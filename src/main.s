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

.section .bss
last_state: .space 1
counter: .space 1

.equ INPUT_BUFF_LEN, 9
input_buff: .space INPUT_BUFF_LEN

.equ OUTPUT_BUFF_LEN, 8
output_buff: .space OUTPUT_BUFF_LEN



# codice del programma
.section .text
    input_filename: .asciz "input.txt"
    output_filename: .asciz "output.txt"
    .globl input_fd
    .globl output_fd
    usage: .asciz "usage: programName inputFilePath outputFilePath\n"
    .equ USAGE_LENGHT, .-usage

.globl _start
_start:
    # recupero i parametri del main
    popl %eax   # numero parametri

    # controllo argomenti
    cmpl $3, %eax
    jne  _show_usage

    popl %eax   # nome programma
    popl %eax   # primo parametro
    popl %ebx   # secondo parametro
    # NB: non salvo ebp in quanto non ha alcuna utilità farlo
    # nella funzione start che comunque non ritorna
    movl %esp, %ebp

    call _open_files

    # cosa va implementato qua:
    # 2) apertura dei file, controllo corretta apertura dei file
    # 3) entro un un loop in cui
    #   a) leggo una riga dal file input, se EOF salto a 4
    #   b) elaboro la riga in una struttura dati da definire
    #   c) scelgo cosa fare in base allo stato precedente
    #   d) scrivo una rida nel file di output
    # 4) chiudo tutti i file, esco dal programma correttamente

_main_loop:

    # sys_read(input_fd, input_buff, INPUT_BUFF_LEN)
    movl $SYS_READ, %eax
    movl input_fd, %ebx
    movl $input_buff, %ecx
    movl $INPUT_BUFF_LEN, %edx
    int $SYSCALL

    # esco se EOF
    testl %eax, %eax
    jz _end

    # sys_write(output_fd, output_buff, INPUT_BUFF_LEN)
    movl $SYS_WRITE, %eax
    movl $STDOUT, %ebx
    movl $input_buff, %ecx
    movl $INPUT_BUFF_LEN, %edx
    int $SYSCALL

    jmp _main_loop

_end:
    # sys_exit(0);
    movl $SYS_EXIT, %eax
    movl $0, %ebx
    int $SYSCALL

_show_usage:
    # esce in caso di errore
    # sys_write(stdout, usage, USAGE_LENGHT);
    movl $SYS_WRITE, %eax
    movl $STDOUT, %ebx
    movl $usage, %ecx
    movl $USAGE_LENGHT, %edx
    int $SYSCALL

    # sys_exit(1);
    movl $SYS_EXIT, %eax
    movl $1, %ebx
    int $SYSCALL
