# Funzione che legge una riga alla volta del file di input

.code32								# per indicare all' assemblatore di assemblare
									# a 32 bit
.include "syscall.inc"
.section .data
    buff_size:  .long 9
.section .bss
    .lcomm  line, 9

.section .text
    .globl  _read_line
    .type   _read_line, @function

_read_line:

    pushl	%ebp
    movl 	%esp, %ebp

    movl    input_fd, %ebx              # metto il descrittore dell'input in ebx

    movl    $SYS_READ, %eax
    leal    line, %ecx
    movl    buff_size, %edx
    int     $SYSCALL

    popl    %ebx

    movl    %ebp, %esp
    popl    %ebp

    ret
