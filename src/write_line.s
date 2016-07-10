# Progetto Assembly 2016
# File: check.s
# Autori: Noè Murr, Mirko Morati
#
# Descrizione: Funzione che scrive una riga alla volta nel file di output

.include "syscall.inc"

.section .bss
    .equ	OUTPUT_BUFF_LEN, 8
    output_buff: .space OUTPUT_BUFF_LEN

.section .text
    .globl  _write_line
    .type   _write_line, @function
    MOD_00: .ascii "00"           # motore spento
    MOD_01: .ascii "01"           # motore sotto giri
    MOD_10: .ascii "10"           # motore in stato ottimale
    MOD_11: .ascii "11"           # motore fuori giri
    .equ 	MOD_LEN, 2

_write_line:
    pushl   %ebp
    movl    %esp, %ebp

    leal    output_buff, %edi     # spostiamo il puntatore
								  # del buffer di output in EDI

    cmpl    $1, alm               # se l'allarme è 1 stampiamo 1
							      # altrimenti 0 senza chiamare funzioni
    je      _alm_1

_alm_0:
    movl    $48, (%edi)
    jmp     _print_mod

_alm_1:
    movl    $49, (%edi)

_print_mod:
    movl    $44, 1(%edi)          # aggiungiamo la virgola dopo
								  # il segnale di allarme
    addl    $2, %edi              # spostiamo un immaginario cursore
								  # nella posizione dove stampare la mod

    cmpl    $1, mod               # controlliamo il valore di mod
								  # e stampiamo la stringa corretta in base
								  # alla giusta modalita' di funzionamento
    je      _mod_1
    cmpl    $2, mod
    je      _mod_2
    cmpl    $3, mod
    je      _mod_3

_mod_0:
    movl    MOD_00, %eax
    jmp _end_print_mod

_mod_1:
    movl    MOD_01, %eax
    jmp _end_print_mod

_mod_2:
    movl    MOD_10, %eax
    jmp _end_print_mod

_mod_3:
    movl    MOD_11, %eax

_end_print_mod:
    movl    %eax, (%edi)          # mettiamo la stringa nell' output_buff
    addl    $MOD_LEN, %edi        # spostato il cursore (la posizione di edi)
								  # nel punto esatto dove scrivere
    movl    $44, (%edi)           # aggiungiamo la virgola
    incl    %edi                  # spostiamo il cursore

    cmpl    $10, numb             # controlliamo se il numero di secondi
								  # è ad una sola cifra, in tal caso
								  # aggiungiamola cifra 0
    jl      _numb_one_digit

_print_numb:
    movl    numb, %eax            # prepariamo la chiamata per itoa

    call    _itoa                 # chiamiamo itoa


    leal    output_buff, %edi     # mettiamo il puntatore di output_buff in edi
    addl    $7, %edi              # ci aggiungiamo 7 per arrivare
								  # alla fine della stringa,
    movl    $10, (%edi)           # punto nel quale aggiungiamo un \n

    movl    $SYS_WRITE, %eax
    movl    output_fd, %ebx
    leal    output_buff, %ecx
    movl    $OUTPUT_BUFF_LEN, %edx
    int     $SYSCALL


    movl    %ebp, %esp
    popl    %ebp

    ret

_numb_one_digit:
    movl    $48, (%edi)
    incl    %edi
    jmp     _print_numb
