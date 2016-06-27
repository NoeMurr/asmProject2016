# Makefile per il progetto assembly

AS:=as
ASFLAGS:=-gstabs --32
LD:=ld
LDFLAGS:=-m elf_i386
BINNAME=elaborato
OBJ=main.o open_files.o read_line.o atoi.o itoa.o
HEADERS=syscall.inc
RM=rm -rf
ECHO=/bin/echo

.PHONY: all run clean rebuild help

%.o: %.s $(HEADERS)
	@$(ECHO) -n "Compiling $< 	"
	@$(AS) -c -o $@ $< $(ASFLAGS)
	@$(ECHO) "[ ok ]"

$(BINNAME): $(OBJ)
	@$(ECHO) -n "Linking $(BINNAME)		"
	@$(LD) -o $@ $^ $(LDFLAGS)
	@$(ECHO) "[ ok ]"

all: $(BINNAME)

debug: ASFLAGS += -g
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
