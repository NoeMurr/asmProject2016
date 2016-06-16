# file che serve per vedere se la funzione open_files funziona
.code32
.section .data

.section .text
	.globl 	_start

	_start:
		popl 	%eax
		popl 	%eax
		popl	%eax
		popl	%ebx

		call 	_open_files

		movl input_fd, %eax
		movl output_fd, %ebx

		ret
