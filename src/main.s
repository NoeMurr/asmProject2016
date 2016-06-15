# Progetto assembly 2016
# File: main.s
# Data: 2016
# Autori: Alessandro Righi, Noè Murr, Mirko Morati
# Descrizione: entry point del programma

.include "syscall.inc"

# variabili globali
.text
input_filename: .asciz "input.txt"
output_filename: .asciz "output.txt"
.data
#NB: per ora teniamo di default STDIN ed STDOUT, se uno non apre file
input_fd: .long STDIN 
output_fd: .long STDOUT
.bss
last_state: .space 1
counter: .space 1


.equ INPUT_BUFF_LEN, 9
input_buff: .space INPUT_BUFF_LEN

.equ OUTPUT_BUFFER_LEN, 8
output_buff: .space OUTPUT_BUFFER_LEN



# codice del programma
.text
.global _start
_start:
    # NB: non salvo ebp in quanto non ha alcuna utilità farlo
    # nella funzione start che comunque non ritorna
    movl %esp, %ebp
	
    # cosa va implementato qua:
    # 1) controllo e parsing degli argomenti della riga di comando
    # 2) apertura dei file, controllo corretta apertura dei file
    # 3) entro un un loop in cui 
    #   a) leggo una riga dal file input, se EOF salto a 4
    #   b) elaboro la riga in una struttura dati da definire
    #   c) scelgo cosa fare in base allo stato precedente
    #   d) scrivo una rida nel file di output 
    # 4) chiudo tutti i file, esco dal programma correttamente

_main_loop:
    
    # sys_read(input_fd, input_buff, INPUT_BUFF_LEN)
    movl $SYS_READ, %eax
    movl input_fd, %ebx
    movl $input_buff, %ecx
    movl $INPUT_BUFF_LEN, %edx
    int $SYSCALL

    # esco se EOF
    testl %eax, %eax
    jz _end

    # sys_write(output_fd, output_buff, INPUT_BUFF_LEN)
    movl $SYS_WRITE, %eax
    movl output_fd, %ebx
    movl $output_buff, %ecx
    movl $OUTPUT_BUFF_LEN, %edx
    int $SYSCALL

_end:
    # sys_exit(0); 
    movl $SYS_EXIT, %eax
    movl $0, %ebx
    int $SYSCALL
 
