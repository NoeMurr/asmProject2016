# file che serve per vedere se la funzione open_files funziona
.section .data
	input_file: .asciz "prova1.txt"
	output_file: .asciz "prova2.txt"

.section .text
	.globl 	_start

	_start:
		movl 	input_file, %eax
		movl 	output_file, %ebx

		call 	_open_files

		movl input_fd, %eax
		movl output_fd, %ebx
		
