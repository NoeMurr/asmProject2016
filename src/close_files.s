# funzione che chiude i file aperti precedentemente
.code32									# per indicare all' assemblatore di
										# assemblare a 32 bit
.include "syscall.inc"

.section .text
	.globl 	_close_files 				# dichiaro la funzione globale
	.type 	_close_files, @function 	# dichiaro l' etichetta come una funzione

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
    