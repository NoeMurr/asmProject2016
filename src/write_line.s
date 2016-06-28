# Funzione che legge una riga alla volta del file di input

.code32								# per indicare all' assemblatore di assemblare
									# a 32 bit
.include "syscall.inc"

.section .bss

    .equ OUTPUT_BUFF_LEN, 8
    output_buff: .space OUTPUT_BUFF_LEN
   
.section .text
    .globl  _write_line
    .type   _write_line, @function

_write_line:
    
    pushl   %ebp
    movl    %esp, %ebp

    cmpl    $0, mod
    je      _spento

    leal    output_buff, %edi 
    movl    alm, %eax

    call    _itoa

    decl    %eax

_spento:
    movl    $SYS_WRITE, %eax
    movl    output_fd, %ebx
    leal    output_buff, %ecx
    movl    OUTPUT_BUFF_LEN, %edx
    int     $SYSCALL 
    

    movl    %ebp, %esp
    popl    %ebp

    ret
    
