# Progetto Assembly 2016
# File: open_files.s
# Autori: Noè Murr, Mirko Morati
#
# Descrizione: File contenente la funzione che si occupa di aprire i file di input e di
# output, i file descriptor vengono inseriti in variabili globali.
# Si suppone che il nome dei due file siano salvati negli indirizzi contenuti
# rispettivamente in %eax (input) ed in %ebx (output).

.include "syscall.inc"

.section .text

	error_opening_files: .asciz "errore nell' apertura dei file\n"
	.equ	ERROR_OPENING_LENGTH, .-error_opening_files

	.globl	_open_files				# Dichiaro la funzione globale
	.type 	_open_files, @function 	# Dichiaro l'etichetta come una funzione

_open_files:

	pushl	%ebp
	movl 	%esp, %ebp

	pushl	%ebx					# Pusho l' indirizzo del file di output
									# sullo stack

	movl 	%eax, %ebx 				# Sposto l' indirizzo del file che vado
									# ad aprire in %ebx

	movl 	$SYS_OPEN, %eax 		# Chiamata di sistema open
	movl 	$0, %ecx 				# read-only mode
	int 	$SYSCALL 				# Apro il file

	cmpl 	$0, %eax
	jl		_error_opening_files

	movl 	%eax, input_fd			# Metto il file descriptor nella
									# sua variabile

	popl 	%ebx 					# Riprendo l' indirizzo del nome del file
									# di output che avevo messo sullo stack

	movl 	$SYS_OPEN, %eax 		# Chiamata di sistema open
	movl 	$01101, %ecx 			# read and write mode
    movl    $0666, %edx            	# flags
	int 	$SYSCALL 				# Apro il file

	cmpl 	$0, %eax
	jl		_error_opening_files

	movl 	%eax, output_fd			# Metto il file descriptor nella
									# sua variabile

	movl 	%ebp, %esp
  	popl	%ebp
	ret 							# Ritorna al chiamante

_error_opening_files:
	# Esce con codice di errore 2
	# sys_write(stdout, usage, USAGE_LENGTH);
	movl 	$SYS_WRITE, %eax
	movl 	$STDERR, %ebx
	movl 	$error_opening_files, %ecx
	movl 	$ERROR_OPENING_LENGTH, %edx
	int 	$SYSCALL

	# sys_exit(2);
    movl 	$SYS_EXIT, %eax
    movl 	$2, %ebx
    int 	$SYSCALL
