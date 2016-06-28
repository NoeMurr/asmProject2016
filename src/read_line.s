# Funzione che legge una riga alla volta del file di input

.code32								# Per indicare all' assemblatore di assemblare
									# a 32 bit
.include "syscall.inc"

.section .bss
    .equ INPUT_BUFF_LEN, 9
    input_buff: .space INPUT_BUFF_LEN

.section .text
    .globl  _read_line
    .type   _read_line, @function

_read_line:

    pushl	%ebp
    movl 	%esp, %ebp

    # Lettura riga 

    # sys_read(input_fd, input_buff, INPUT_BUFF_LEN);
    movl    input_fd, %ebx
    movl    $SYS_READ, %eax 
    leal    input_buff, %ecx
    movl    $INPUT_BUFF_LEN, %edx
    int     $SYSCALL

    # Controllo EOF
    cmpl    $0, %eax                    # Se eax == 0 eof
    je      _eof

    # Estrazione valori dalla stringa
    leal    input_buff, %edi
    call    _atoi
    movl    %eax, init

    incl    %edi
    call    _atoi
    movl    %eax, reset

    incl    %edi
    call    _atoi
    movl    %eax, rpm


    movl    %ebp, %esp
    popl    %ebp

    xorl    %ebx, %ebx
    ret

_eof:
    # in caso di EOF %ebx = -1
    movl    %ebp, %esp
    popl    %ebp

    movl    $-1, %ebx
    ret
