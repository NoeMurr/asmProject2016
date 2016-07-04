# file contenente la funzione che si occupa di aprire i file di input e di
# output, i file descriptor vengono inseriti in variabili globali
# si suppone che il nome dei due file siano salvati negli indirizzi contenuti
# rispettivamente in %eax(input) ed in %ebx(output)
.code32								# per indicare all' assemblatore di
									# assemblare a 32 bit
.include "syscall.inc"

.section .text

	error_opening_files: .asciz "errore nell' apertura dei file\n"
	.equ 	ERROR_OPENING_LENGHT, .-error_opening_files

	.globl 	_open_files 			# dichiaro la funzione globale
	.type 	_open_files, @function 	# dichiaro l' etichetta come una funzione

_open_files:

	pushl	%ebp
	movl 	%esp, %ebp

	pushl	%ebx 			 		# pusho l' indirizzo del file di output sullo
									# stack

	movl 	%eax, %ebx 				# sposto l' indirizzo del file che vado
									# ad aprire in %ebx

	movl 	$SYS_OPEN, %eax 		# chiamata di sistema open
	movl 	$0, %ecx 				# read-only mode
	int 	$SYSCALL 				# apro il file

	cmpl 	$0, %eax
	jl		_error_opening_files

	movl 	%eax, input_fd			# metto il file descriptor nella sua
									# variabile

	popl 	%ebx 					# riprendo l' indirizzo del nome del file
									# di output che avevo messo sullo stack

	movl 	$SYS_OPEN, %eax 		# chiamata di sistema open
	movl 	$01101, %ecx 				# read and write, mode
    movl    $0744, %edx            # flags
	int 	$SYSCALL 				# apro il file

	cmpl 	$0, %eax
	jl		_error_opening_files

	movl 	%eax, output_fd			# metto il file descriptor nella sua
									# variabile come prima

	movl 	%ebp, %esp
  	popl	%ebp
	ret 							# ritorna al chiamante

_error_opening_files:
	# sys_write(stdout, usage, USAGE_LENGHT);
	movl $SYS_WRITE, %eax
	movl $STDOUT, %ebx
	movl $error_opening_files, %ecx
	movl $ERROR_OPENING_LENGHT, %edx
	int $SYSCALL

	# sys_exit(1);
    movl $SYS_EXIT, %eax
    movl $2, %ebx
    int $SYSCALL
