# Progetto Assembly 2016
# File: check.s
# Autori: Noè Murr, Mirko Morati
#
# Descrizione: Funzione che chiude i file aperti precedentemente

.include "syscall.inc"

.section .text
	.globl 	_close_files 			 # Dichiaro la funzione globale
	.type 	_close_files, @function  # Dichiaro l' etichetta come una funzione

_close_files:

	pushl	%ebp
	movl 	%esp, %ebp

	# sys_close(input_fd);
	movl	$SYS_CLOSE, %eax
	movl	input_fd, %ebx
	int 	$SYSCALL

	# sys_close(output_fd);
	movl	$SYS_CLOSE, %eax
	movl	output_fd, %ebx
	int 	$SYSCALL


	movl    %ebp, %esp
    popl    %ebp

    ret
