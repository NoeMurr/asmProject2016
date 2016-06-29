# Funzione che legge una riga alla volta del file di input
.include "syscall.inc"

.bss
    .equ INPUT_BUFF_LEN, 9
    input_buff: .space INPUT_BUFF_LEN

.text
.globl  read_line
.type   read_line, @function
read_line:
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

    xorl    %ebx, %ebx
    ret

_eof:
    # in caso di EOF %ebx = -1
    movl    $-1, %ebx
    ret
