# funzione che chiude i file aperti precedentemente
.include "syscall.inc"

.text
.globl 	close_files 				# dichiaro la funzione globale
.type 	close_files, @function 	# dichiaro l' etichetta come una funzione
close_files:

	## sys_close(input_fd);
	movl $SYS_CLOSE, %eax
	movl input_fd, %ebx
	int  $SYSCALL 

	## sys_close(output_fd);
	movl $SYS_CLOSE, %eax
	movl output_fd, %ebx
	int  $SYSCALL 

    ret 
    