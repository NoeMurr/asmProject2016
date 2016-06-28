#include <stdio.h>
#include <string.h>


// dichiarazione variabili globali 
FILE *input_fd;
FILE *output_fd;
int init, reset, rpm;
int alm, mod, numb;

// prototipi delle funzioni utilizzate
void check(void);

void show_usage(void);

int main(int argc, char **argv){
	// controllo gli argomenti
	if (argc != 3){
		show_usage();
		return EXIT_SUCCESS;
	}

	// apro i file 
	input_fd = fopen();
	output_fd = fopen();

	char *line;

	while();

}