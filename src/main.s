# Progetto Assembly 2016
# File: main.s
# Autori: Noè Murr, Mirko Morati
#
# Descrizione: File principale, punto di inizio del programma.
.include    "syscall.inc"

.section    .data
    input_fd:   .long 0         # variabile globale che conterrà il file
                                # descriptor del file di input

    output_fd:  .long 0         # variabile globale che conterrà il file
                                # descriptor del file di output

    # Variabili globali per i segnali di input
    init:   .long 0
    reset:  .long 0
    rpm:    .long 0

    # Variabili globali per i segnali di output
    alm:    .long 0
    numb:   .long 0
    mod:    .long 0

# Codice del programma

.section    .text
    .globl  input_fd
    .globl  output_fd
    .globl  init
    .globl  reset
    .globl  rpm
    .globl  alm
    .globl  numb
    .globl  mod
    .globl  _start

    # Stringa per mostrare l'utilizzo del programma in caso di parametri errati
    usage:  .asciz "usage: programName inputFilePath outputFilePath\n"
    .equ    USAGE_LENGTH, .-usage

_start:
    # Recupero i parametri del main
    popl    %eax                # Numero parametri

    # Controllo argomenti, se sbagliati mostro l'utilizzo corretto
    cmpl    $3, %eax
    jne     _show_usage

    popl    %eax                # Nome programma
    popl    %eax                # Primo parametro (nome file di input)
    popl    %ebx                # Secondo parametro (nome file di output)

    # NB: non salvo ebp in quanto non ha alcuna utilità
    # nella funzione start che comunque non ritorna

    movl    %esp, %ebp

    call    _open_files         # Apertura dei file

_main_loop:

    call    _read_line          # Leggiamo la riga

    cmpl    $-1, %ebx           # EOF se ebx == -1
    je      _end

    call    _check              # Controllo delle variabili

    call    _write_line         # Scrittura delle variabili di output su file

    jmp     _main_loop          # Leggi un altra riga finché non è EOF

_end:

    call    _close_files        # Chiudi correttamente i file

    # sys_exit(0);
    movl    $SYS_EXIT, %eax
    movl    $0, %ebx
    int     $SYSCALL

_show_usage:
    # esce in caso di errore con codice 1
    # sys_write(stdout, usage, USAGE_LENGTH);
    movl    $SYS_WRITE, %eax
    movl    $STDOUT, %ebx
    movl    $usage, %ecx
    movl    $USAGE_LENGTH, %edx
    int     $SYSCALL

    # sys_exit(1);
    movl    $SYS_EXIT, %eax
    movl    $1, %ebx
    int     $SYSCALL
