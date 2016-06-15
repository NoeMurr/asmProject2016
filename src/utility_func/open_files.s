# file contenente la funzione che si occupa di aprire il file di input e di
# output, i file descriptor vengono inseriti in variabili globali
# si suppone che il nome dei due file siano salvati nell'indirizzi contenuti
# rispettivamente in %eax(input) ed in %ebx(output)
.code32														# per indicare all' assemblatore di assemblare
																	# a 32 bit
.section .data
	input_fd: .long 0 							# variabile globale che conterra' il file
									  							# descriptor del file di input

	output_fd:  .long 0 						# variabile globale che conterra' il file
	                   							# descriptor del file di output
.section .text
	.globl 	_open_files 						# dichiaro la funzione globale
	.type 	_open_files, @function 	# dichiaro l' etichetta come una funzione

	.globl 	input_fd 								#dichiaro la variabile come globale
	.globl 	output_fd 							#dichiaro la variabile come globale

_open_files:
	pushl		%ebx 									 	#pusho l' indirizzo del file di output sullo
																	# stack

	movl 		%eax, %ebx 							# sposto l' indirizzo del file che vado
																	# ad aprire in %ebx

	movl 		$5, %eax 								# chiamata di sistema open
	movl 		$0, %ecx 								# read-only mode
	int 		$0x80 									# apro il file

	movl 		%eax, input_fd					# metto il file descriptor nella sua variabile

	popl 		%ebx 										# riprendo l' indirizzo del nome del file
																	# di output che avevo messo sullo stack

	movl 		$5, %eax 								# chiamata di sistema open
	movl 		$0, %ecx 								# read-only mode
	int 		$0x80 									# apro il file

	movl 		%eax, output_fd		 			# metto il file descriptor nella sua
																	# variabile come prima

	ret 														# fine della funzione ed anche del file.
