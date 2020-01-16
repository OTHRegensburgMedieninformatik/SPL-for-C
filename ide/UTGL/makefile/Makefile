# ****************************************************************
# Makefile for Makefile StartProject

SHELL=/bin/bash

# Sets the target platform for SPL
# Valid values for variable platform are unixlike and windows
ifeq ($(OS),Windows_NT)
PLATFORM=windows
else
PLATFORM=unixlike
endif

# Additional compiler flags
CFLAGS=-std=gnu11 -g -Wall
LDLIBS = lib/libcs.a 


ifeq ($(OS),Windows_NT)
LDLIBS += -lshlwapi
else
LDLIBS += -lm 
endif

BUILD = \
	build \
    build/$(PLATFORM) \
    build/$(PLATFORM)/obj

OBJECTS = \
    build/$(PLATFORM)/obj/UnitTestGLabel.o

PROGRAMMS = \
	build/$(PLATFORM)/UnitTestGLabel


# ***************************************************************
# Entry to bring the package up to date
#    The "make all" entry should be the first real entry

all: $(BUILD) $(OBJECTS) $(PROGRAMMS) 

# ***************************************************************
# Directories

$(BUILD):
	@echo "Build Directories"
	@mkdir -p $(BUILD)

# ***************************************************************
# Programm


build/$(PLATFORM)/UnitTestGLabel:
	@echo "Build UnitTestGLabel"
	@gcc -o build/$(PLATFORM)/UnitTestGLabel build/$(PLATFORM)/obj/UnitTestGLabel.o $(LDLIBS)

build/$(PLATFORM)/obj/UnitTestGLabel.o: UnitTestGLabel.c
	@echo "Build UnitTestGLabel.o"
	@gcc $(CFLAGS) -Iinclude -c -o build/$(PLATFORM)/obj/UnitTestGLabel.o UnitTestGLabel.c
	@cp lib/spl.jar build/$(PLATFORM)/



# ***************************************************************
# Standard entries to remove files from the directories
#    tidy    -- eliminate unwanted files
#    scratch -- delete derived files in preparation for rebuild

tidy:
	@echo "Clean Project Directory"
	@rm -f `find . -name ',*' -o -name '.,*' -o -name '*~'`
	@rm -f `find . -name '*.tmp' -o -name '*.err'`
	@rm -f `find . -name core -o -name a.out`
	@rm -rf build/obj
	
scratch clean: tidy
	@rm -f -r $(BUILD) $(OBJECTS) $(LIBRARIES) $(PROJECT)
	@echo "Cleaning Done"
