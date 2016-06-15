# file di definizione delle chiamate di sistema linux

.equ SYS_EXIT, 0
.equ SYS_READ, 3
.equ SYS_WRITE, 4
.equ SYS_OPEN, 5
.equ SYS_CLOSE, 6

.equ STDIN, 0
.equ STDOUT, 1
.equ STDERR, 2

.equ SYS_CALL, 0x80