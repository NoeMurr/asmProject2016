# Funzione che legge una riga alla volta del file di input

.code32								# per indicare all' assemblatore di assemblare
									# a 32 bit
.include "syscall.inc"

.section .bss
    .equ INPUT_BUFF_LEN, 9
    input_buff: .space INPUT_BUFF_LEN

    .equ OUTPUT_BUFF_LEN, 8
    output_buff: .space OUTPUT_BUFF_LEN

.section .text
    .globl  _read_line
    .type   _read_line, @function

_read_line:

    pushl	%ebp
    movl 	%esp, %ebp

    movl    input_fd, %ebx              # metto il descrittore dell'input in ebx

    movl    $SYS_READ, %eax
    leal    input_buff, %ecx
    movl    $INPUT_BUFF_LEN, %edx
    int     $SYSCALL

    # Estraggo valori da input_buff
    cmpl    $0, %eax                    # Se eax == 0 eof
    je      _eof

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

    movl    %ebp, %esp
    popl    %ebp

    movl    $-1, %ebx
    ret
