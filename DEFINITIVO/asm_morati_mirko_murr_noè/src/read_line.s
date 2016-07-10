# Progetto Assembly 2016
# File: read_line.s
# Autori: Noè Murr, Mirko Morati
#
# Descrizione: Funzione che legge una riga alla volta del file di input.

.include "syscall.inc"

.section .bss
    .equ	INPUT_BUFF_LEN, 9
    input_buff:	.space INPUT_BUFF_LEN	# Input buffer di 9 byte

.section .text
    .globl 	_read_line
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

    cmpl    $0, %eax                    # Se eax == 0 EOF
    je      _eof

    # Estrazione dei valori di init, reset, rpm dal buffer
    leal    input_buff, %edi
    call    _atoi
    movl    %eax, init

    incl    %edi						# Salto il carattere ','

    call    _atoi
    movl    %eax, reset

    incl    %edi						# Salto il carattere ','

    call    _atoi
    movl    %eax, rpm

    movl    %ebp, %esp
    popl    %ebp

    xorl    %ebx, %ebx					# ebx = 0 permette di proseguire
    ret

_eof:
    # in caso di EOF %ebx = -1
    movl    %ebp, %esp
    popl    %ebp

    movl    $-1, %ebx
    ret
