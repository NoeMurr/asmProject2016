# Progetto assembly 2016
# File: itoa.s
# Data: 2016
# Autori: Alessandro Righi, Noè Murr, Mirko Morati
# Descrizione: converte un intero in stringa

.text
.global itoa
.type itoa, @function

# Funzione che converte un intero in stringa
# Prototipo C-style:
#   uint32_t itoa(uint32_t val, char *string);
# Parametri di input: 
#   EAX - Valore intero unsigned a 64bit da convertire 
#   EDI - Puntatore alla stringa su cui salvare il risultato
# Parametri di output:  
#   EAX - Lunghezza della stringa convertita (compresiva di \0 finale)
itoa: 
    movl $10, %ecx   # porto il fattore moltiplicativo in RCX
    movl %eax, %ebx  # salvo temporaneamente il valore di RAX in RBX
    xorl %esi, %esi  # azzero il registro RSI

_itoa_dividi: 
    xorl %edx, %edx  # azzero RDX per fare la divisione
    divl %ecx        # divide RAX per RCX, salva il resto in RDX
    incl %esi        # incrementa il contatore
    testl %eax, %eax # se il valore di RAX non è zero ripeti il ciclo
    jnz _itoa_dividi

    addl %esi, %edi  # somma all'indirizzo del buffer il numero di caratteri del numero
    movl %ebx, %eax  # rimette il valore da convertire in RAX
    movl %esi, %ebx  # salvo il valore della lunghezza della stringa in RBX

    movl $0, (%edi)   # aggiungo un null terminator alla fine della stringa
    decl %edi         # decremento il contatore della stringa di 1

_itoa_converti:
    xorl %edx, %edx  # azzero RDX per fare la divisione
    divl %ecx        # divido RAX per RCX, salvo il valore del resto in RDX
    addl $48, %edx   # sommo 48 a RDX
    movb %dl, (%edi) # sposto il byte inferiore di RDX (DL) nella locazione di memoria puntata da RDI
    decl %edi        # decremento il puntatore della stringa
    decl %esi        # decremento il contatore
    testl %esi, %esi # se il contatore non è 0 continua ad eseguire il loop
    jnz _itoa_converti

    movl %ebx, %eax  # porto il valore della lunghezza della stringa in RAX per ritornarlo
    incl %eax    # incremento di 2 RAX (in modo da includere il carattere newline e \0)
    ret 
