# file contenente la funzione che si occupa di aprire i file di input e di
# output, i file descriptor vengono inseriti in variabili globali
# si suppone che il nome dei due file siano salvati negli indirizzi contenuti
# rispettivamente in %eax(input) ed in %ebx(output)
.include "syscall.inc"

.section .text
    # variabili globali costanti
    error_opening_files: .asciz "Errore nell' apertura dei file\n"
    .equ    ERROR_OPENING_LENGHT, .-error_opening_files

# funzione open files, apre i file e gestisce eventuali errori nell'apertura    
# parametri della funzione
# EDI -> puntatore alla stringa del nome file input
# ESI -> puntatore alla stringa del nome file output
# Prototipo C-style
# void open_files(const char *input_filename, const char *output_filename);
# la funzione modifica la variabili globali input_fd ed output_fd (sta cosa non 
# mi piace comunque, però)
.globl  _open_files             # dichiaro la funzione globale
.type   _open_files, @function  # dichiaro l' etichetta come una funzione
_open_files:

    ## result = sys_open(input_filename, O_READ);
    movl    $SYS_OPEN, %eax
    movl    %edi, %ebx
    movl    $0, %ecx
    int     $SYSCALL

    ## if (result <= 0) goto _error_opening_files;
    cmpl    $0, %eax
    jle      _error_opening_files

    ## input_fd = result;
    movl    %eax, input_fd

    ## result = sys_open(output_filename, O_WRITE | O_CREAT, 0744);
    movl    $SYS_OPEN, %eax
    movl    %esi, %ebx
    movl    $65, %ecx
    movl    $0744, %edx
    int     $SYSCALL

    ## if (result <= 0) goto _error_opening_files
    cmpl    $0, %eax
    jl      _error_opening_files

    ## output_fd = result;
    movl    %eax, output_fd         

    ret

# piccola label che gestisce l'uscita in caso di errore.
_error_opening_files:

    ## sys_write(stdout, usage, USAGE_LENGHT);
    movl $SYS_WRITE, %eax
    movl $STDOUT, %ebx
    movl $error_opening_files, %ecx
    movl $ERROR_OPENING_LENGHT, %edx
    int $SYSCALL

    ## sys_exit(1);
    movl $SYS_EXIT, %eax
    movl $2, %ebx
    int $SYSCALL
