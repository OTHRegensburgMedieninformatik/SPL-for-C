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
# Project : Makefile for building examples for SPL
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

# SETTINGS - C COMPILER
# ---------------------
#     General settings for which C-Compiler to use and which flags should be 
#     added.

CC       = gcc
CFLAGS   = -std=c99

# SETTINGS - C++ COMPILER
# -----------------------
#     General settings for which C++-Compiler to use and which flags should 
#     be added. 

CXX      = g++
CXXFLAGS = -g -std=gnu++17

# SETTINGS - LINKER, LIBRARIES
# ----------------------------
#     The variable LDLIBS is used to specify global C/C++-Libraries, which 
#     have to be included, in order to get all dependencies.

LDFLAGS = -lcs -lm -lpthread -lunwind -ldl
ifeq ($(OS),Windows_NT)
LDFLAGS += -lshlwapi
endif

# FILES - SOURCE
# --------------
#     All the paths to the sourcefiles and their directories (C and Java) 
#     will be stored in variables. The variable PROJECT_DIR is used to get
#     the path the project is currently stored in.

PROJECT_DIR = $(shell pwd)
C_SRCDIR    = .
C_SRCFILES  = $(wildcard $(C_SRCDIR)/*.c)
C_INCLUDE   = $(PROJECT_DIR)/../include
LIBRARIES   = $(PROJECT_DIR)/../../build/$(PLATFORM)/lib

# FILE BUILD - TARGETGROUPS
# -------------------------
#     In every specific group of files are the filenames (also targetnames)
#     stored. Only the filenames are stored not the path to the files.

C_OBJFILES   = $(C_SRCFILES:$(C_SRCDIR)/%.c=%.o)
C_BINFILES   = $(C_SRCFILES:$(C_SRCDIR)/%.c=%)

# DIRECTORIES - BUILD
# -------------------
#     The path in the variable BUILDDIR has to be relative. If the path is
#     however an absolute one, the VARIABLE PROJECT_DIR has to be declared
#     as empty manualy.

BUILDDIR     = $(PROJECT_DIR)
OBJ_BUILDDIR = $(BUILDDIR)
BIN_BUILDDIR = $(BUILDDIR)

#############################################################################
#                            DEFAULT - TARGET                               #
#############################################################################

# TARGET: all
# -----------
#     This is the default target (will be called, if no target has been 
#     specified). Specifies how the project should be build/rebuild. 

all: directories $(C_OBJFILES) $(C_BINFILES) 

#############################################################################
#                                C - TARGETS                                #
#############################################################################

# TARGET: C_BINFILES
# ------------------
#     This target specifies, how the binaries (executables) for all examples, 
#     will be build.

$(C_BINFILES): %: %.o
	@echo "Build $@"
	@$(CXX) -D$(PLATFORM) $(CXXFLAGS) -o $(BIN_BUILDDIR)/$@ \
		-L$(LIBRARIES) -I$(C_INCLUDE) $(OBJ_BUILDDIR)/$< $(LDFLAGS)

# TARGET: C_OBJFILES
# ------------------
#     This target specifies, how all the obj-files for the examples, will be 
#     build.

$(C_OBJFILES): %.o: $(C_SRCDIR)/%.c
	@echo "Build $@"
	@$(CC) -D$(PLATFORM) $(CFLAGS) -c -o $(OBJ_BUILDDIR)/$@ -I$(C_INCLUDE) $< 

# TARGET: directories
# -------------------
#     This target builds all the directories needed for building the Project

.PHONY: directories
directories:
	@mkdir -p $(BUILDDIR) $(OBJ_BUILDDIR) $(BIN_BUILDDIR)

# ***************************************************************
# Standard entries to remove files from the directories
#    tidy  -- eliminate unwanted files
#    clean -- delete derived files in preparation for rebuild

tidy:
	@rm -f `find . -name ',*' -o -name '.,*' -o -name '*~'`
	@rm -f `find . -name '*.tmp' -o -name '*.err'`
	@rm -f `find . -name core -o -name a.out`
	@rm -f *.o

clean scratch: tidy
	@rm -f *.o *.a $(C_BINFILES)
