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
# Version : 2020/03/18-R1
#

#############################################################################
#                        SETTINGS, CONFIGURATIONS                           #
#############################################################################

# SETTINGS - OPERATING SYSTEM
# ---------------------------
#     Evaluates the target platform for SPL. Valid values for variable platform 
#     are unixlike and windows

ifeq ($(OS),Windows_NT)
PLATFORM = windows
else
PLATFORM = unixlike
endif

# FILES - SOURCE
# --------------
#     All the paths to the sourcefiles and their directories (C and Java) 
#     will be stored in variables. The variable PROJECT_DIR is used to get
#     the path the project is currently stored in.

PROJECT_DIR    = $(shell pwd)
C_SRCDIR       = c/src
C_LIBDIR       = c/lib
C_SRCFILES     = $(wildcard $(C_SRCDIR)/*.c)
CTEST_SRCDIR   = c/tests
CTEST_SRCFILES = $(wildcard $(CTEST_SRCDIR)/*.c)

# FILE BUILD - TARGETGROUPS
# -------------------------
#     In every specific group of files are the filenames (also targetnames)
#     stored. Only the filenames are stored not the path to the files.

C_OBJFILES         = $(C_SRCFILES:$(C_SRCDIR)/%.c=%.o)
CTEST_OBJFILES     = $(CTEST_SRCFILES:$(CTEST_SRCDIR)/%.c=%.o)
CTEST_BINFILES     = $(CTEST_SRCFILES:$(CTEST_SRCDIR)/%.c=%)
C_STATIC_LIBRARIES = libcs.a
JAVA_SPL           = spl.jar

# DIRECTORIES - BUILD
# -------------------
#     The path in the variable BUILDDIR has to be relative. If the path is
#     however an absolute one, the VARIABLE PROJECT_DIR has to be declared
#     as empty manualy.

BUILDDIR          = $(PROJECT_DIR)/build/$(PLATFORM)
CLASSES_BUILDDIR  = $(BUILDDIR)/classes
EXAMPLES_BUILDDIR = $(BUILDDIR)/examples
INCLUDE_BUILDDIR  = $(BUILDDIR)/include
LIB_BUILDDIR      = $(BUILDDIR)/lib
OBJ_BUILDDIR      = $(BUILDDIR)/obj
TESTS_BUILDDIR    = $(BUILDDIR)/tests

# SETTINGS - C COMPILER
# ---------------------
#     General settings for which C-Compiler to use and which flags should be 
#     added. Additional compiler flags:
#       ->  add '-DPIPEDEBUG' for a debug build showing piped commands
#       ->  add '-DZMQDEBUG' for a debug build showing ZeroMQ commands

CC       = gcc
CFLAGS   = -g -std=gnu11

# SETTINGS - C++ COMPILER
# -----------------------
#     General settings for which C++-Compiler to use and which flags should 
#     be added. Additional compiler flags:
#       ->  add '-DPIPEDEBUG' for a debug build showing piped commands
#       ->  add '-DZMQDEBUG' for a debug build showing ZeroMQ commands

CXX      = g++
CXXFLAGS = -g -std=gnu++17

# SETTINGS - LINKER, LIBRARIES
# ----------------------------
#     The variable LDLIBS is used to specify global C/C++-Libraries, which 
#     have to be included, in order to get all dependencies. The variable
#     CXX_LIBZMQ has to be changed depending on your Operating System. Inside
#     this project are three different libraries included. But if you want,
#     are able to include your own version of the libzmq.
#
#     included_libraries: {
#         MacOS Catalina x64: libzmq4.3.2-darwin19.3.0.a, 
#         Linux Kernerl 5.5.6 x64: libzmq4.3.2-linux5.5.6.a, 
#         Windows Visual Studio 15 (2017) x64: libzmq4.3.2-vs15.2017.lib
#     }

LDLIBS =
ifeq ($(OS),Windows_NT)
LDLIBS += -lshlwapi
endif

#############################################################################
#                            DEFAULT - TARGET                               #
#############################################################################

# TARGET: all
# -----------
#     This is the default target (will be called, if no target has been 
#     specified). Specifies how the project should be build/rebuild. Calls 
#     all targets, except the ones, which build the Starterprojects.

all: directories $(C_OBJFILES) $(C_STATIC_LIBRARIES) $(CTEST_BINFILES) \
	$(JAVA_SPL) examples

#############################################################################
#                                C - TARGETS                                #
#############################################################################

# TARGET: libcs.a
# ---------------
#     This target specifies, how the static C-Library libcs.a is build. 

libcs.a: $(C_OBJFILES)
	@echo "Build lics.a"
	@-rm -f $(LIB_BUILDDIR)/libcs.a
	#@mkdir -p $(OBJ_BUILDDIR)/.libzmq
	# @(cd $(OBJ_BUILDDIR)/.libzmq; ar -x ${CXX_LIBZMQ})
	@(cd $(OBJ_BUILDDIR); ar cr $(LIB_BUILDDIR)/libcs.a $(C_OBJFILES))
	@ranlib $(LIB_BUILDDIR)/libcs.a
	#@rm -rf $(OBJ_BUILDDIR)/.libzmq
	@cp -r c/include/* $(INCLUDE_BUILDDIR)

# TARGET: C_OBJFILES
# ------------------
#     This traget specifies, how all obj-files of C_OBJFILES will be build.

$(C_OBJFILES): %.o: $(C_SRCDIR)/%.c
	@echo "Build $@"
	@$(CC) $(CFLAGS) -D$(PLATFORM) -c -o $(OBJ_BUILDDIR)/$@ -Ic/include \
		-Ic/include/private $<

# TARGET: CTEST_BINFILES
# ----------------------
#     This target specifies, how the binaries (executables) for all tests, 
#     will be build.

$(CTEST_BINFILES): %: %.o $(C_STATIC_LIBRARIES)
	@echo "Build $@"
	@$(CXX) $(CXXFLAGS) -o $(TESTS_BUILDDIR)/$@ $(OBJ_BUILDDIR)/$< \
		-L$(LIB_BUILDDIR) -lcs -lm $(LDLIBS)

# TARGET: CTEST_OBJFILES
# ----------------------
#     This target specifies, how all the obj-files for the tests, will be 
#     build.

$(CTEST_OBJFILES): %.o: $(CTEST_SRCDIR)/%.c
	@echo "Build $@"
	@$(CC) $(CFLAGS) -c -o $(OBJ_BUILDDIR)/$@ -Ic/include -Ic/include/private $<

# TARGET: examples
# ----------------
#     This target builds the example-files of the SPL. However this target
#     does not specify, how to build the examples. Therefore an other Makefile
#     inside $(PROJECT_DIR)/c/examples will be called.

examples: $(C_STATIC_LIBRARIES) $(JAVA_SPL)
	@echo "Build Examples"
	@cp $(LIB_BUILDDIR)/spl.jar $(EXAMPLES_BUILDDIR)
	@cp -r c/examples/images $(EXAMPLES_BUILDDIR)
	@cp -r c/examples/sounds $(EXAMPLES_BUILDDIR)
#	@make all -C c/examples
	@make BUIDLDIR=$(BUILDDIR) BIN_BUILDDIR=$(EXAMPLES_BUILDDIR) \
		OBJ_BUILDDIR=$(OBJ_BUILDDIR) -C c/examples

#############################################################################
#                               JAVA - TARGETS                              #
#############################################################################

# TARGET: spl.jar
# ---------------
#     This target builds the executable .jar-file for the JavaBackEnd

spl.jar: stanford/spl/JavaBackEnd.class
	@echo "Build $@"
	@mkdir -p $(LIB_BUILDDIR)/.tmp
	@(cd $(LIB_BUILDDIR)/.tmp; unzip -uoqq "$(PROJECT_DIR)/java/lib/*.jar")
	@jar -cf $(LIB_BUILDDIR)/spl.jar -C $(LIB_BUILDDIR)/.tmp .
	@rm -rf $(LIB_BUILDDIR)/.tmp
	@(cd $(CLASSES_BUILDDIR); jar ufm $(LIB_BUILDDIR)/spl.jar \
		$(PROJECT_DIR)/java/include/JBEManifest.txt \
		`find stanford -name '*.class'`)

# TARGET: stanford/spl/JavaBackEnd.class
# --------------------------------------
#     This target builds the binary .class-Javafile of the JavaBackEnd

stanford/spl/JavaBackEnd.class: java/src/stanford/spl/*.java
	@echo "Build $@"
	@javac -g -d $(CLASSES_BUILDDIR) -cp "java/lib/*" -sourcepath \
		java/src java/src/stanford/spl/JavaBackEnd.java


#############################################################################
#                          INSTALLATION - TARGETS                           #
#############################################################################

# TARGET: install
# ---------------
#     This target installs all C- and Java-Libraries included in 
#     $(C_STATIC_LIBRARIES) $(JAVA_SPL) globaly to your System, so that you 
#     can import all .h-files globaly and don't rely on an local copy. 

install: $(C_STATIC_LIBRARIES) $(JAVA_SPL)
	rm -rf /usr/local/include/spl
	cp -r $(INCLUDE_BUILDDIR) /usr/local/include/spl
	chmod -R a+rX /usr/local/include/spl
	cp $(LIB_BUILDDIR)/{libcs.a,spl.jar} /usr/local/lib/
	chmod -R a+r /usr/local/lib/{libcs.a,spl.jar}

#############################################################################
#                        STARTERPROJECTS - TARGETS                          #
#############################################################################

# TARGET: starterprojects
# -----------------------
#     Builds all StarterProjects (clion_windows, clion_linux, ... ) into one 
#     combined folder.

# TODO: needs a cleanup
starterprojects: clean directories $(C_OBJFILES) $(C_STATIC_LIBRARIES) $(CTEST_BINFILES) $(JAVA_SPL)
	@echo "Build StarterProjects"
	@rm -rf StarterProjects
	@mkdir StarterProjects
	@cp -r ide/clion StarterProjects/clion
	@cp -r ide/codeblocks StarterProjects/codeblocks
	@cp -r ide/makefile StarterProjects/makefile
	@echo "Build StarterProject for Clion on Windows"
	@cp ide/src/HelloGraphics.c StarterProjects/clion/windows
	@cp -r $(LIB_BUILDDIR) StarterProjects/clion/windows/lib
	@cp -r $(INCLUDE_BUILDDIR) StarterProjects/clion/windows/include
	@echo "Build StarterProject for Clion on Linux"
	@cp ide/src/HelloGraphics.c StarterProjects/clion/linux
	@cp -r $(LIB_BUILDDIR) StarterProjects/clion/linux/lib
	@cp -r $(INCLUDE_BUILDDIR) StarterProjects/clion/linux/include
	@echo "Build StarterProject for Clion on MacOS"
	@cp ide/src/HelloGraphics.c StarterProjects/clion/macos
	@cp -r $(LIB_BUILDDIR) StarterProjects/clion/macos/lib
	@cp -r $(INCLUDE_BUILDDIR) StarterProjects/clion/macos/include
	@echo "Build StarterProject for CodeBlocks on Windows"
	@cp ide/src/HelloGraphics.c StarterProjects/codeblocks/windows
	@cp -r $(LIB_BUILDDIR) StarterProjects/codeblocks/windows/lib
	@cp -r $(INCLUDE_BUILDDIR) StarterProjects/codeblocks/windows/include
	@echo "Build StarterProject for CodeBlocks on Linux"
	@cp ide/src/HelloGraphics.c StarterProjects/codeblocks/linux
	@cp -r $(LIB_BUILDDIR) StarterProjects/codeblocks/linux/lib
	@cp -r $(INCLUDE_BUILDDIR) StarterProjects/codeblocks/linux/include
	@echo "Build StarterProject for CodeBlocks on MacOS"
	@cp ide/src/HelloGraphics.c StarterProjects/codeblocks/macos
	@cp -r $(LIB_BUILDDIR) StarterProjects/codeblocks/macos/lib
	@cp -r $(INCLUDE_BUILDDIR) StarterProjects/codeblocks/macos/include
	@echo "Build StarterProject for Makefile Project"
	@cp ide/src/HelloGraphics.c StarterProjects/makefile
	@cp -r $(LIB_BUILDDIR) StarterProjects/makefile/lib
	@cp -r $(INCLUDE_BUILDDIR) StarterProjects/makefile/include
	@echo "Check the StarterProjects folder"

clion_windows: clean directories $(C_OBJFILES) $(C_STATIC_LIBRARIES) $(CTEST_BINFILES) $(JAVA_SPL)
	@echo "Build StarterProject for Clion on Windows"
	@rm -rf StarterProject
	@cp -r ide/clion/windows StarterProject
	@cp -r $(LIB_BUILDDIR) StarterProject
	@cp -r $(INCLUDE_BUILDDIR) StarterProject
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

clion_linux: clean directories $(C_OBJFILES) $(C_STATIC_LIBRARIES) $(CTEST_BINFILES) $(JAVA_SPL)
	@echo "Build StarterProject for Clion on Linux";
	@rm -rf StarterProject
	@cp -r ide/clion/linux StarterProject
	@cp -r $(LIB_BUILDDIR) StarterProject
	@cp -r $(INCLUDE_BUILDDIR) StarterProject
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

clion_macos: clean directories $(C_OBJFILES) $(C_STATIC_LIBRARIES) $(CTEST_BINFILES) $(JAVA_SPL)
	@echo "Build StarterProject for Clion on MaxOS";
	@rm -rf StarterProject
	@cp -r ide/clion/macos StarterProject
	@cp -r $(LIB_BUILDDIR) StarterProject
	@cp -r $(INCLUDE_BUILDDIR) StarterProject
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

codeblocks_windows: clean directories $(C_OBJFILES) $(C_STATIC_LIBRARIES) $(CTEST_BINFILES) $(JAVA_SPL)
	@echo "Build StarterProject for CodeBlocks on Windows";
	@rm -rf StarterProject
	@cp -r ide/codeblocks/windows StarterProject
	@cp -r $(LIB_BUILDDIR) StarterProject
	@cp -r $(INCLUDE_BUILDDIR) StarterProject
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

codeblocks_linux: clean directories $(C_OBJFILES) $(C_STATIC_LIBRARIES) $(CTEST_BINFILES) $(JAVA_SPL)
	@echo "Build StarterProject for CodeBlocks on Linux";
	@rm -rf StarterProject
	@cp -r ide/codeblocks/linux StarterProject
	@cp -r $(LIB_BUILDDIR) StarterProject/lib
	@cp -r $(INCLUDE_BUILDDIR) StarterProject/include
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

codeblocks_macos: clean directories $(C_OBJFILES) $(C_STATIC_LIBRARIES) $(CTEST_BINFILES) $(JAVA_SPL)
	@echo "Build StarterProject for CodeBlocks on MacOS";
	@rm -rf StarterProject
	@cp -r ide/codeblocks/macos StarterProject
	@cp -r $(LIB_BUILDDIR) StarterProject
	@cp -r $(INCLUDE_BUILDDIR) StarterProject
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

makefile: clean directories $(C_OBJFILES) $(C_STATIC_LIBRARIES) $(CTEST_BINFILES) $(JAVA_SPL)
	@echo "Build StarterProject for Makefile Project";
	@rm -rf StarterProject
	@cp -r ide/makefile StarterProject
	@cp -r $(LIB_BUILDDIR) StarterProject
	@cp -r $(INCLUDE_BUILDDIR) StarterProject
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

#############################################################################
#                             .PHONY - TARGETS                              #
#############################################################################

# TARGET: directories
# -------------------
#     This target builds all the directories needed for building the Project

.PHONY: directories
directories:
	@echo "Build Directories"
	@mkdir -p build $(BUILDDIR) $(CLASSES_BUILDDIR) $(EXAMPLES_BUILDDIR) \
		$(INCLUDE_BUILDDIR) $(LIB_BUILDDIR) $(OBJ_BUILDDIR) $(TESTS_BUILDDIR)

# TARGET: tidy
# ------------
#     This target eliminates unwanted files.

.PHONY: tidy
tidy: examples-tidy
	@echo "Clean Project Directory"
	@rm -f `find . -name ',*' -o -name '.,*' -o -name '*~'`
	@rm -f `find . -name '*.tmp' -o -name '*.err'`
	@rm -f `find . -name core -o -name a.out`
	@rm -rf $(CLASSES_BUILDDIR)
	@rm -rf $(OBJ_BUILDDIR)

# TARET: examples-tidy
# ---------------------
#     This target eliminates unwanted files in the c/examples directory.

.PHONY: examples-tidy
examples-tidy:
	@rm -f $(PROJECT_DIR)/c/examples/*.o
	@rm -f $(PROJECT_DIR)/c/examples/*.exe

# TARGET: scratch, clean
# ----------------------
#     This target deletes derived files in preparation for rebuild.

.PHONY: scratch clean
scratch clean: tidy
	@rm -f -r build $(BUILDDIR) $(CLASSES_BUILDDIR) $(EXAMPLES_BUILDDIR) \
		$(INCLUDE_BUILDDIR) $(LIB_BUILDDIR) $(OBJ_BUILDDIR) $(TESTS_BUILDDIR) \
		$(C_OBJFILES) $(C_STATIC_LIBRARIES) $(CTEST_BINFILES) $(JAVA_SPL) \
		StarterProject StarterProjects
	@make clean BUIDLDIR=$(BUILDDIR) BIN_BUILDDIR=$(EXAMPLES_BUILDDIR) \
		OBJ_BUILDDIR=$(OBJ_BUILDDIR) -C c/examples
	@make clean -C c/examples
	@rm -f c/examples/spl.jar
	@echo "Cleaning Done"
