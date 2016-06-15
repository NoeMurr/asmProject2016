# Makefile per il progetto assembly

AS:=as
ASLAGS:=-m32
LD:=ld
LDFLAGS:=-m elf_i386
BINNAME=elaborato
OBJ=main.o 
HEADERS=syscall.inc
RM=rm -rf
ECHO=/bin/echo

.PHONY: all run clean rebuild help 

%.o: %.c $(HEADERS)
	@$(ECHO) -n "Compiling $< 	"
	@$(AS) -c -o $@ $< $(ASLAGS)
	@$(ECHO) "[ ok ]"

$(BINNAME): $(OBJ)
	@$(ECHO) -n "Linking $(BINNAME)		"
	@$(LD) -o $@ $^ $(LDFLAGS)
	@$(ECHO) "[ ok ]"

all: $(BINNAME)

debug: ASLAGS += -g
debug: LDFLAGS += -g
debug: $(BINNAME)

run: $(BINNAME)
	@$(ECHO) "Running $(BINNAME)"
	@./$(BINNAME)

clean:
	@$(ECHO) -n "Cleaning sources 	"
	@$(RM) *.o
	@$(RM) $(BINNAME)
	@$(ECHO) "[ ok ]"


rebuild: clean $(BINNAME)

help:
	@$(ECHO) "Cazzate sull'help scriverle qua"
