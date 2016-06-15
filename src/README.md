#Readme dell'elaborato

Linee guida che vorrei venissero seguite (bhe poi fate come volete)

-   tutti i file del progetto devono avere estensione .s
    (teniamola pure minuscola)

-   le funzioni in file separati (come da richiesta)

-   tutti i file sorgenti in un unica directory (non voglio diventare matto
    per scrivere il Makefile, grazie)

-   per compilare si usa il Makefile

-   per compilare in modalità debug aggiustare le opzioni ASFLAGS ed LDFLAGS
    (magari modifico il makefile e aggiungo un comando debug ?)

-   divisioni in funzioni sensata

-   codice indentato correttamente (indentazione 4 spazi, niente tab, a parte
    nel Makefile dove i tab sono obbligatori)

-   codice commentato correttamente: un commento generale all'inizio di ogni
    funzione più un commento all'inizio di ogni blocco di codice di 3/4 righe,
    es questo codice apre il file, questo fa questo, questo fa ques'altro,
    evitare per quanto possibile un commento ad ogni riga

-   per quanto possibile, non tenere righe troppo lunghe, ma allinearsi ad 80
    caratteri

-   i nomi dei file si passano dalla riga di comando, e mettiamo un nome di
    default nel caso l'utente non abbia passato nulla (controllare argc)

-   fare controlli nel caso possano essrci errori
    (file non esistenti, file malformattati,ecc) e in caso di errore,
    stampare un messagggio e ritornare codice di errore
    (1 va bene), il programma non deve andare in segfault se non usato
    correttametne

-   i file vanno chiusi alla fine del programma
    (anche in caso di errore possibilmente)

-   possibilmente definire come macro tutti i codici delle chiamate di sistema
    che si usano con .equ, es .equ SYS_WRITE 4, .equ SYSCALL, 0x80, ecc

-   e poi bho basta, buon divertimento!
