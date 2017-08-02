# *******************************************************
# Makefile for SPL

# Base variables for the build process
PLATFORM = 
MAKE_FILE = 
CALL = make -s

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
	$(CALL) -fMakefile.$(MAKE_FILE) $@

freeimage:
	@echo Build $@ on $(PLATFORM)
	$(CALL) -fMakefile.$(MAKE_FILE) $@

freeimage_clean:
	@echo Build $@ on $(PLATFORM)
	$(CALL) -fMakefile.$(MAKE_FILE) $@

lib:
	@echo Build $@ on $(PLATFORM)
	$(CALL) -fMakefile.$(MAKE_FILE) $@

install:
	@echo Build $@ on $(PLATFORM)
	$(CALL) -fMakefile.$(MAKE_FILE) $@

examples:
	@echo Build $@ on $(PLATFORM)
	$(CALL) -fMakefile.$(MAKE_FILE) $@

starter:
	@echo Build $@ on $(PLATFORM)
	$(CALL) -fMakefile.$(MAKE_FILE) $@

makefile:
	@echo Build $@ on $(PLATFORM)
	$(CALL) -fMakefile.$(MAKE_FILE) $@

codeblocks:
	@echo Build $@ on $(PLATFORM)
	$(CALL) -fMakefile.$(MAKE_FILE) $@

clion:
	@echo Build $@ on $(PLATFORM)
	$(CALL) -fMakefile.$(MAKE_FILE) $@

tidy:
	@echo Build $@ on $(PLATFORM)
	$(CALL) -fMakefile.$(MAKE_FILE) $@

scratch clean:
	@echo Build $@ on $(PLATFORM)
	$(CALL) -fMakefile.$(MAKE_FILE) $@

