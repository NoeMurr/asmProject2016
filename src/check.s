# Funzione che controlla le variabili init, reset, rpm e setta le variabili 
# alm, mod e numb

.code32

.section .data

.section .text
    .globl  _check
    .type   _check, @function

_check:
    
    pushl   %ebp
    movl    %esp, %ebp

    # Caso init == 0 -> alm =0; mod = 0; numb = 0;
    cmpl    $0, init
    je      _init_0

    # Caso SG -> alm = 0; mod = 1; numb = reset == 1 ? 0 : numb + 1;
    cmpl    $2000, rpm
    jl      _sg

    # Caso OPT -> alm = 0; mod = 2; numb = reset == 1 ? 0 : numb + 1;
    cmpl    $4000, rpm
    jle     _opt

    # Caso Fg -> alm = numb >= 15? 1 : 0; mod = 3; numb = reset == 1 ? 0 : numb + 1;
_fg:
    # salviamo la nuova modalita' in %eax e controlliamo reset
    movl    $3, %eax       
    cmpl    $1, reset
    je      _reset_numb

    # Se la nuova modalita' non e` la stessa si resetta il numero di secondi
    cmpl    $3, mod
    jne     _reset_numb

    incl    numb
    movl    %eax, mod

    # Se il numero di secondi e' maggiore o uguale a 15 viene alzata l'allarme 
    cmpl    $15, numb
    jge      _set_alm

    jmp     _end_check


_opt:
    movl    $2, %eax
    cmpl    $1, reset
    je      _reset_numb

    cmpl    $2, mod
    jne     _reset_numb

    incl    numb
    movl    %eax, mod

    jmp     _end_check


_sg:
    movl    $1, %eax
    cmpl    $1, reset
    je      _reset_numb

    cmpl    $1, mod
    jne      _reset_numb

    incl    numb
    movl    %eax, mod

    jmp     _end_check

_reset_numb:
    movl    %eax, mod
    movl    $0, numb
    movl    $0, alm

    jmp     _end_check

_set_alm:
    movl    $1, alm


    jmp     _end_check

_init_0:
    movl    $0, alm
    movl    $0, numb
    movl    $0, mod

_end_check:
    
    # Se il numero di secondi supera i 99 allora dobbiamo ricominciare il conteggio
    cmpl    $99, numb 
    jg      _numb_overflow
    movl    %ebp, %esp
    popl    %ebp

    ret

_numb_overflow:
    movl    $0, numb
    jmp     _end_check
    