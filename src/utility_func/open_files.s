.section .data
	input_fd: .long 0 # variabile globale che conterra' il file descriptor
									  # del file di input

	output_fd: .long 0 # variabile globale che conterra' il file descriptor
	                   # del file di output
.section .bss

.section .text
	.global _open_file

	.type _open_file, @function

_open_file:
