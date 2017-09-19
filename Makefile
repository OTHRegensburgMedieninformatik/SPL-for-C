# *******************************************************
# Makefile for SPL

# Base variables for the build process
PLATFORM = 
MAKE_FILE = 
SILENT = -s

ifeq ($(OS),Windows_NT)
    PLATFORM=windows
    MAKE_FILE = mingw
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        PLATFORM = linux
        MAKE_FILE = gnu
    endif
    ifeq ($(UNAME_S),Darwin)
        PLATFORM = macos
        MAKE_FILE = osx
    endif
endif

all:
	@echo Build $@ on $(PLATFORM) 
	@$(MAKE) $(SILENT) -fMakefile.$(MAKE_FILE) $@

freeimage:
	@echo Build $@ on $(PLATFORM)
	@$(MAKE) $(SILENT) -fMakefile.$(MAKE_FILE) $@

freeimage_clean:
	@echo Build $@ on $(PLATFORM)
	@$(MAKE) $(SILENT) -fMakefile.$(MAKE_FILE) $@

lib:
	@echo Build $@ on $(PLATFORM)
	@$(MAKE) $(SILENT) -fMakefile.$(MAKE_FILE) $@

install:
	@echo Build $@ on $(PLATFORM)
	@$(MAKE) $(SILENT) -fMakefile.$(MAKE_FILE) $@

examples:
	@echo Build $@ on $(PLATFORM)
	@$(MAKE) $(SILENT) -fMakefile.$(MAKE_FILE) $@

starter:
	@echo Build $@ on $(PLATFORM)
	@$(MAKE) $(SILENT) -fMakefile.$(MAKE_FILE) $@

mfile:
	@echo Build $@ on $(PLATFORM)
	@$(MAKE) $(SILENT) -fMakefile.$(MAKE_FILE) $@

codeblocks:
	@echo Build $@ on $(PLATFORM)
	@$(MAKE) $(SILENT) -fMakefile.$(MAKE_FILE) $@

clion:
	@echo Build $@ on $(PLATFORM)
	@$(MAKE) $(SILENT) -fMakefile.$(MAKE_FILE) $@

tidy:
	@echo Build $@ on $(PLATFORM)
	@$(MAKE) $(SILENT) -fMakefile.$(MAKE_FILE) $@

scratch clean:
	@echo Build $@ on $(PLATFORM)
	@$(MAKE) $(SILENT) -fMakefile.$(MAKE_FILE) $@

help:
	@echo "The following command could be called"
	@echo "make all => Builds the SPL-for-C library with examples"
	@echo "make lib => Builds the SPL-for-C library"
	@echo "make freeimage => Build the freeimage library"
	@echo "make freeimage_clean => Cleans the freeimage library"
	@echo "make install => Install the library"
	@echo "make examples => Build the examples"
	@echo "make starter => Create all starter project"
	@echo "make clion => Create as clion starter project"
	@echo "make codeblocks => Create as codeblocks starter project"
	@echo "make mfile => Create as makefile starter project"
	@echo "make clean => Cleans the whole project"
	@echo "make help => Show this message"