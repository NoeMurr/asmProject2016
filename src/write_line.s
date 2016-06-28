# Funzione che scrive una riga alla volta nel file di output

.code32								# per indicare all' assemblatore di assemblare
									# a 32 bit
.include "syscall.inc"

.section .bss

    .equ OUTPUT_BUFF_LEN, 9
    output_buff: .space OUTPUT_BUFF_LEN

.section .text
    .globl  _write_line
    .type   _write_line, @function
    MOD_00: .ascii "00"
    MOD_01: .ascii "01"
    MOD_10: .ascii "10"
    MOD_11: .ascii "11"
    .equ MOD_LEN, 2

_write_line:

    pushl   %ebp
    movl    %esp, %ebp

    leal    output_buff, %edi
    movl    alm, %eax

    call    _itoa

    leal    output_buff, %edi
    addl    %eax, %edi
    movl    $44, (%edi)
    incl    %edi

    cmpl    $1, mod
    je      _mod_1
    cmpl    $2, mod
    je      _mod_2
    cmpl    $3, mod
    je      _mod_3

    #_mod_0
    movl    MOD_00, %eax
    movl    %eax, (%edi)
    jmp _print_numb

_mod_1:
    movl    MOD_01, %eax
    movl    %eax, (%edi)
    jmp _print_numb

_mod_2:
    movl    MOD_10, %eax
    movl    %eax, (%edi)
    jmp _print_numb

_mod_3:
    movl    MOD_11, %eax
    movl    %eax, (%edi)

_print_numb:
    addl    $2, %edi
    movl    $44, (%edi)
    incl    %edi

    cmpl    $10, numb
    jl      _numb_one_digit

_print_numb_2:

    movl    numb, %eax

    call    _itoa


    leal    output_buff, %edi
    addl    $8, %edi
    movl    $10, (%edi)
    incl    %edi

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
    jmp     _print_numb_2
