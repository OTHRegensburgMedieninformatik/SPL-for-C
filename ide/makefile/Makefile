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
# Project : StarterProject for SPL-FOR-C
# Version : 2020/03/03-R1
#

# SETTINGS - OPERATING SYSTEM
# Sets the target platform for the SPL
ifeq ($(OS),Windows_NT)
PLATFORM = windows
else
PLATFORM = unixlike
endif

# SETTINGS - C COMPILER
CC       = gcc
CFLAGS   = -std=gnu11 -g -Wall

# SETTINGS - C++ COMPILER
CXX		 = g++
CXXFLAGS = -std=gnu++17 -g -Wall

# SETTINGS - LINKER, LIBRARIES
LDLIBS   = lib/libcs.a
ifeq ($(OS),Windows_NT)
LDLIBS   += -lshlwapi
else
LDLIBS   += -lm
endif

# SETTINGS - APPLICATION
APPNAME  = HelloGraphics

# FILES - SOURCE
SRCDIR   = .
SRCFILES = \
	$(SRCDIR)/HelloGraphics.c

# FILES - BUILD
BUILDDIR = build/$(PLATFORM)
OBJDIR   = $(BUILDDIR)/obj
OBJFILES = $(SRCFILES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
DIRS     = build $(BUILDDIR) $(OBJDIR)

##
# INFO-TARGET OF MAKEFILE
#

# Variables for styling font inside CI
bold := $(shell tput bold)
sgr0 := $(shell tput sgr0)

.PHONY: info
info:
	@echo "$(bold)DESCRIPTION$(sgr0)"
	@echo ""
	@echo "    No target has been specified. Use one of the targets below."
	@echo ""
	@echo "$(bold)TARGETS$(sgr0)"
	@echo ""
	@echo "    $(bold)info$(sgr0)          Shows this message"
	@echo "    $(bold)all$(sgr0)           Builds all targets, except clean and tidy"
	@echo "    $(bold)directories$(sgr0)   Builds the export-directories"
	@echo "    $(bold)tidy$(sgr0)          Eliminates unwanted files"
	@echo "    $(bold)clean$(sgr0)         Deletes derived files in preparation for rebuild"

##
# TARGETS OF MAKEFILE
#

all: directories $(BUILDDIR)/$(APPNAME)

$(BUILDDIR)/$(APPNAME): $(OBJFILES)
	@echo "Build $@"
	@$(CXX) $(CXXFLAGS) -o $@ $^ $(LDLIBS) -lpthread -lunwind -ldl
	@cp lib/spl.jar $(BUILDDIR)

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@echo "Build $@"
	@$(CC) $(CFLAGS) -o $@ -c $^ -Iinclude

# Building the export-directories 
.PHONY: directories 
directories:
	@echo "Build Directories"
	@mkdir -p $(DIRS)

.PHONY: tidy
tidy:
	@echo "Clean Project Directory"
	@rm -f `find . -name ',#' -o -name '.,#' -o -name '#~'`
	@rm -f `find . -name '#.tmp' -o -name '#.err'`
	@rm -f `find . -name core -o -name a.out`
	@rm -rf $(OBJDIR)

.PHONY: scratch clean
scratch clean: tidy
	@rm -f -r build
	@echo "Cleaning Done"
