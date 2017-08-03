# *******************************************************
# Makefile for SPL Examples 

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
	$(MAKE) $(SILENT) -fMakefile.$(MAKE_FILE) $@

tidy:
	echo Build $@ on $(PLATFORM)
	$(MAKE) $(SILENT) -fMakefile.$(MAKE_FILE) $@

scratch clean:
	echo Build $@ on $(PLATFORM)
	$(MAKE) $(SILENT) -fMakefile.$(MAKE_FILE) $@
