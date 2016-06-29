# file contenente la funzione che si occupa di aprire i file di input e di
# output, i file descriptor vengono inseriti in variabili globali
# si suppone che il nome dei due file siano salvati negli indirizzi contenuti
# rispettivamente in %eax(input) ed in %ebx(output)
.include "syscall.inc"

.text
    # variabili globali costanti
    error_opening_files: .asciz "Errore nell' apertura dei file\n"
    .equ ERROR_OPENING_LENGHT, .-error_opening_files

# funzione open files, apre i file e gestisce eventuali errori nell'apertura    
# parametri della funzione
# EDI -> puntatore alla stringa del nome file input
# ESI -> puntatore alla stringa del nome file output
# Prototipo C-style
# (FILE, FILE) open_files(const char *input_filename, const char *output_filename);
# Ritorna rispettivamente in EDI ed ESI l'fd del file input e del file output
.globl open_files             # dichiaro la funzione globale
.type open_files, @function  # dichiaro l' etichetta come una funzione
open_files:

    ## input_fd = sys_open(input_filename, O_READ);
    movl $SYS_OPEN, %eax
    movl %edi, %ebx
    movl $0, %ecx
    int  $SYSCALL
    movl %eax, %edi

    ## if (input_fd <= 0) goto _error_opening_files;
    cmpl $0, %edi
    jle  _error_opening_files


    ## output_fd = sys_open(output_filename, O_WRITE | O_CREAT, 0744);
    movl $SYS_OPEN, %eax
    movl %esi, %ebx
    movl $65, %ecx
    movl $0744, %edx
    int  $SYSCALL
    movl %eax, %esi

    ## if (output_fd <= 0) goto _error_opening_files
    cmpl    $0, %esi
    jl      _error_opening_files

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
