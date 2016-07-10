# Progetto Assembly 2016
# File: open_files.s
# Autori: Noè Murr, Mirko Morati
#
# Descrizione: File di definizione delle chiamate di sistema linux

.equ    SYS_EXIT, 1
.equ    SYS_READ, 3
.equ    SYS_WRITE, 4
.equ    SYS_OPEN, 5
.equ    SYS_CLOSE, 6

.equ    STDIN, 0
.equ    STDOUT, 1
.equ    STDERR, 2

.equ    SYSCALL, 0x80
