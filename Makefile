#########################################################################
# Stanford Portable Library                                             #
# Copyright (C) 2013 by Eric Roberts <eroberts@cs.stanford.edu>         #
#                                                                       #
# This program is free software: you can redistribute it and/or modify  #
# it under the terms of the GNU General Public License as published by  #
# the Free Software Foundation, either version 3 of the License, or     #
# (at your option) any later version.                                   #
#                                                                       #
# This program is distributed in the hope that it will be useful,       #
# but WITHOUT ANY WARRANTY; without even the implied warranty of        #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
# GNU General Public License for more details.                          #
#                                                                       #
# You should have received a copy of the GNU General Public License     #
# along with this program.  If not, see <http://www.gnu.org/licenses/>. #
#########################################################################

##
# Filename: Makefile
# Project : Makefile for building SPL
# Version : 2020/03/03-R1
#

# SETTINGS - OPERATING SYSTEM
# Sets the target platform for SPL
# Valid values for variable platform are unixlike and windows
ifeq ($(OS),Windows_NT)
PLATFORM=windows
else
PLATFORM=unixlike
endif

# SETTINGS - C COMPILER
# Additional compiler flags, add '-DPIPEDEBUG' for a debug build showing piped commands
CC       = gcc
CFLAGS   = -g -std=gnu11

# SETTINGS - C++ COMPILER
CXX      = g++
CXXFLAGS = -g -std=gnu++17

# SETTINGS - LINKER, LIBRARIES
LDLIBS   = -lpthread -lunwind -ldl
ifeq ($(OS),Windows_NT)
LDLIBS   += -lshlwapi
endif

# FILES - SOURCE
SRCDIR     = c/src
SRCFILES   = $(wildcard $(SRCDIR)/*.c)
TESTSRCDIR = c/tests

# FILES - BUILD
BUILDDIR     = build/$(PLATFORM)
OBJDIR       = $(BUILDDIR)/obj
TESTDIR      = $(BUILDDIR)/tests
LIBDIR       = $(BUILDDIR)/lib
JAVABINDIR   = $(BUILDDIR)/classes
OBJFILES     = $(SRCFILES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
DIRS         = \
	build \
	$(BUILDDIR) \
	$(OBJDIR) \
	$(TESTDIR) \
	$(LIBDIR) \
	$(JAVABINDIR)

# SETTINGS - STATIC EXPORT
LIBRARY      = $(LIBDIR)/libcs.a
TESTS        = \
	$(TESTDIR)/TestStanfordCSLib
JARLIB       = spl.jar
PROJECTBUILD = \
	StarterProject \
	StarterProjects


# ***************************************************************
# Entry to bring the package up to date
#    The "make all" entry should be the first real entry

all: directories $(OBJFILES) $(LIBRARY) $(TESTS) $(JARLIB) examples


# ***************************************************************
# directories

.PHONY: directories
directories:
	@echo "Build Directories"
	@mkdir -p $(DIRS)


# ***************************************************************
# Library compilations

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@echo "Build $@"
	@$(CC) $(CFLAGS) -D$(PLATFORM) -c -o $@ -Ic/include -Ic/include/private $^

# ***************************************************************
# Entry to reconstruct the library archive

$(LIBRARY): $(OBJFILES)
	@echo "Build $@"
	@-rm -f $@
	@(cd $(OBJDIR); ar -x ../../../c/lib/libzmq4.3.2-linux5.5.6.a)
	@ar cr $@ $(OBJDIR)/*.o 
	@ranlib $(LIBRARY)
	@cp -r c/include $(BUILDDIR)/


# ***************************************************************
# Test program

$(TESTDIR)/TestStanfordCSLib: $(TESTSRCDIR)/TestStanfordCSLib.c $(LIBDIR)/libcs.a
	@echo "Build $(OBJDIR)/TestStanfordCSLib.o"
	@$(CC) $(CFLAGS) -c -o $(OBJDIR)/TestStanfordCSLib.o -Ic/include $(TESTSRCDIR)/TestStanfordCSLib.c
	@echo "Build $@"
	@$(CXX) $(CXXFLAGS) -o $@ $(OBJDIR)/TestStanfordCSLib.o -L$(LIBDIR) -lcs -lm $(LDLIBS)


# ***************************************************************
# Java Back End

$(JARLIB): stanford/spl/JavaBackEnd.class
	@echo "Build $@"
	@mkdir -p $(LIBDIR)/.tmp
	@(cd $(LIBDIR)/.tmp; unzip -uoqq "../../../../java/lib/*.jar")
	@jar -cf $(LIBDIR)/spl.jar -C $(LIBDIR)/.tmp .
	@rm -rf $(LIBDIR)/.tmp
	@(cd $(BUILDDIR)/classes; jar ufm ../lib/spl.jar  ../../../java/include/JBEManifest.txt \
		`find stanford -name '*.class'`)
#	@echo jar cf $(LIBDIR)/spl.jar . . .

stanford/spl/JavaBackEnd.class: java/src/stanford/spl/*.java
	@echo "Build $@"
	@javac -g -d $(BUILDDIR)/classes -cp "java/lib/*" -sourcepath java/src \
		java/src/stanford/spl/JavaBackEnd.java


# ***************************************************************
# install

install: $(LIBDIR)/libcs.a $(JARLIB)
	rm -rf /usr/local/include/spl
	cp -r $(BUILDDIR)/include /usr/local/include/spl
	chmod -R a+rX /usr/local/include/spl
	cp $(LIBDIR)/{libcs.a,spl.jar} /usr/local/lib/
	chmod -R a+r /usr/local/lib/{libcs.a,spl.jar}

examples: $(LIBDIR)/libcs.a $(JARLIB)
	@echo "Build Examples"
	@cp $(LIBDIR)/spl.jar c/examples/
	@make -C c/examples

starterprojects: clean $(BUILD) $(OBJECTS) $(LIBRARIES) $(TESTS) $(JARLIB)
	@echo "Build StarterProjects"
	@rm -rf StarterProjects
	@mkdir StarterProjects
	@cp -r ide/clion StarterProjects/clion
	@cp -r ide/codeblocks StarterProjects/codeblocks
	@cp -r ide/makefile StarterProjects/makefile
	@echo "Build StarterProject for Clion on Windows"
	@cp ide/src/HelloGraphics.c StarterProjects/clion/windows
	@cp -r $(LIBDIR) StarterProjects/clion/windows/lib
	@cp -r $(BUILDDIR)/include StarterProjects/clion/windows/include
	@echo "Build StarterProject for Clion on Linux"
	@cp ide/src/HelloGraphics.c StarterProjects/clion/linux
	@cp -r $(LIBDIR) StarterProjects/clion/linux/lib
	@cp -r $(BUILDDIR)/include StarterProjects/clion/linux/include
	@echo "Build StarterProject for Clion on MacOS"
	@cp ide/src/HelloGraphics.c StarterProjects/clion/macos
	@cp -r $(LIBDIR) StarterProjects/clion/macos/lib
	@cp -r $(BUILDDIR)/include StarterProjects/clion/macos/include
	@echo "Build StarterProject for CodeBlocks on Windows"
	@cp ide/src/HelloGraphics.c StarterProjects/codeblocks/windows
	@cp -r $(LIBDIR) StarterProjects/codeblocks/windows/lib
	@cp -r $(BUILDDIR)/include StarterProjects/codeblocks/windows/include
	@echo "Build StarterProject for CodeBlocks on Linux"
	@cp ide/src/HelloGraphics.c StarterProjects/codeblocks/linux
	@cp -r $(LIBDIR) StarterProjects/codeblocks/linux/lib
	@cp -r $(BUILDDIR)/include StarterProjects/codeblocks/linux/include
	@echo "Build StarterProject for CodeBlocks on MacOS"
	@cp ide/src/HelloGraphics.c StarterProjects/codeblocks/macos
	@cp -r $(LIBDIR) StarterProjects/codeblocks/macos/lib
	@cp -r $(BUILDDIR)/include StarterProjects/codeblocks/macos/include
	@echo "Build StarterProject for Makefile Project"
	@cp ide/src/HelloGraphics.c StarterProjects/makefile
	@cp -r $(LIBDIR) StarterProjects/makefile/lib
	@cp -r $(BUILDDIR)/include StarterProjects/makefile/include
	@echo "Check the StarterProjects folder"

clion_windows: clean $(BUILD) $(OBJECTS) $(LIBRARIES) $(TESTS) $(JARLIB)
	@echo "Build StarterProject for Clion on Windows"
	@rm -rf StarterProject
	@cp -r ide/clion/windows StarterProject
	@cp -r $(LIBDIR) StarterProject
	@cp -r $(BUILDDIR)/include StarterProject
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

clion_linux: clean $(BUILD) $(OBJECTS) $(LIBRARIES) $(TESTS) $(JARLIB)
	@echo "Build StarterProject for Clion on Linux";
	@rm -rf StarterProject
	@cp -r ide/clion/linux StarterProject
	@cp -r $(LIBDIR) StarterProject
	@cp -r $(BUILDDIR)/include StarterProject
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

clion_macos: clean $(BUILD) $(OBJECTS) $(LIBRARIES) $(TESTS) $(JARLIB)
	@echo "Build StarterProject for Clion on MaxOS";
	@rm -rf StarterProject
	@cp -r ide/clion/macos StarterProject
	@cp -r $(LIBDIR) StarterProject
	@cp -r $(BUILDDIR)/include StarterProject
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

codeblocks_windows: clean $(BUILD) $(OBJECTS) $(LIBRARIES) $(TESTS) $(JARLIB)
	@echo "Build StarterProject for CodeBlocks on Windows";
	@rm -rf StarterProject
	@cp -r ide/codeblocks/windows StarterProject
	@cp -r $(LIBDIR) StarterProject
	@cp -r $(BUILDDIR)/include StarterProject
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

codeblocks_linux: clean $(BUILD) $(OBJECTS) $(LIBRARIES) $(TESTS) $(JARLIB)
	@echo "Build StarterProject for CodeBlocks on Linux";
	@rm -rf StarterProject
	@cp -r ide/codeblocks/linux StarterProject
	@cp -r $(LIBDIR) StarterProject/lib
	@cp -r $(BUILDDIR)/include StarterProject/include
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

codeblocks_macos: clean $(BUILD) $(OBJECTS) $(LIBRARIES) $(TESTS) $(JARLIB)
	@echo "Build StarterProject for CodeBlocks on MacOS";
	@rm -rf StarterProject
	@cp -r ide/codeblocks/macos StarterProject
	@cp -r $(LIBDIR) StarterProject
	@cp -r $(BUILDDIR)/include StarterProject
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

makefile: clean $(BUILD) $(OBJECTS) $(LIBRARIES) $(TESTS) $(JARLIB)
	@echo "Build StarterProject for Makefile Project";
	@rm -rf StarterProject
	@cp -r ide/makefile StarterProject
	@cp -r $(LIBDIR) StarterProject
	@cp -r $(BUILDDIR)/include StarterProject
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

# ***************************************************************
# Standard entries to remove files from the directories
#    tidy    -- eliminate unwanted files
#    scratch -- delete derived files in preparation for rebuild

tidy: examples-tidy
	@echo "Clean Project Directory"
	@rm -f `find . -name ',*' -o -name '.,*' -o -name '*~'`
	@rm -f `find . -name '*.tmp' -o -name '*.err'`
	@rm -f `find . -name core -o -name a.out`
	@rm -rf build/classes
	@rm -rf build/obj
	@make tidy -C c/examples

examples-tidy:
	@rm -f c/examples/*.o
	@rm -f c/examples/*.exe

scratch clean: tidy
	@rm -f -r $(DIRS) $(OBJFILES) $(LIBRARIES) $(TESTS) $(PROJECTBUILD)
	@make clean -C c/examples
	@echo "Cleaning Done"
