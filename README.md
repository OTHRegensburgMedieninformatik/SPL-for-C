<<<<<<< HEAD
# C version of the Stanford Portable Library (SPL) for MacOS, Linux and Windows

SPL is a simple graphics library that can be used in introductory 
university-level CS courses. This is a fork of the Harvard CS50 version of 
Eric Roberts' Stanford Portable Library. This version contains a patch of 
Robert's original version so that the library can also be compiled under Windows.

## Building C and Java sources
The Makefile automatically detects your system and switches between the 
Windows and Linux version (no configuration required).

### MacOS (also tested with Ubuntu and Fedora)

    git clone https://github.com/OTHRegensburgMedieninformatik/SPL-for-C.git
    cd Spl-for-C
    make
    sudo make install

### Windows

The Windows version needs MSYS (http://www.mingw.org/wiki/MSYS) in order for 
make to run. Once MSYS is installed, make sure to edit the PATH variable, so 
that the MSYS bin folder is the first in the list. This is important, since 
the Windows find command used in the makefile behaves differently than the 
MSYS version. Once this is set, the library should compile without errors.

    git clone https://github.com/OTHRegensburgMedieninformatik/SPL-for-C.git
    cd Spl-for-C
    make
    make install

## Compiling and running the C example programs
The library comes with several example programs that demonstrate the 
capability of the library but can also be used as student assignments. 
The examples are automatically compiled together with the library by running 
make from the top level directory of the code.

Examples can be compiled seperately from c/examples.
From there run make to compile.

## Create StartProject
The library comes with a StartProject for Clion that have all needed files included.

The StartProject can be created with one of the following commands

    IDE = [ "clion", "codeblocks"]
    PLATFORM = ["windows","linux","macos"]

    make IDE_PLATFORM
    >make clion_windows
    >make clion_linux
    >make clion_macos

    Or a simple Makefile Project

    >make makefile

And is located in Spl-for-C/StartProject

Additional you can also build all StarterProjects with

>make starterprojects

## Notes

>Tue to Clion use PTY for running Code the graphical window will closed 
immediately after the main routine is finished
>
>As a workaround set the run.processes.with.pty to flase
>Help -> Find Action ... -> Registry -> uncheck run.processes.with.pty -> close 

## TODO

* Fix display bug that seems to omit drawing graphical objects at the start of the program
=======
# C version of the Stanford Portable Library (SPL) for MacOS, Linux and Windows

SPL is a simple graphics library that can be used in introductory 
university-level CS courses. This is a fork of the Harvard CS50 version of 
Eric Roberts' Stanford Portable Library. This version contains a patch of 
Robert's original version so that the library can also be compiled under Windows.

## Building C and Java sources
The Makefile automatically detects your system and switches between the 
Windows and Linux version (no configuration required).

### MacOS (also tested with Ubuntu and Fedora)

    git clone https://github.com/OTHRegensburgMedieninformatik/SPL-for-C.git
    cd Spl-for-C
    make
    sudo make install

### Windows

The Windows version needs MSYS (http://www.mingw.org/wiki/MSYS) in order for 
make to run. Once MSYS is installed, make sure to edit the PATH variable, so 
that the MSYS bin folder is the first in the list. This is important, since 
the Windows find command used in the makefile behaves differently than the 
MSYS version. Once this is set, the library should compile without errors.

    git clone https://github.com/OTHRegensburgMedieninformatik/SPL-for-C.git
    cd Spl-for-C
    make
    make install

## Compiling and running the C example programs
The library comes with several example programs that demonstrate the 
capability of the library but can also be used as student assignments. 
The examples are automatically compiled together with the library by running 
make from the top level directory of the code.

Examples can be compiled seperately from c/examples.
From there run make to compile.

## Create StartProject
The library comes with a StartProject for Clion that have all needed files included.

The StartProject can be created with one of the following commands

    IDE = [ "clion", "codeblocks"]
    PLATFORM = ["windows","linux","macos"]

    make IDE_PLATFORM
    >make lion_linux

    Or a simple Makefile Project

    >make makefile

And is located in Spl-for-C/StartProject

Additional you can also build all StarterProjects with

>make starterprojects

## Notes

>Tue to Clion use PTY for running Code the graphical window will closed 
immediately after the main routine is finished
>
>As a workaround set the run.processes.with.pty to flase
>Help -> Find Action ... -> Registry -> uncheck run.processes.with.pty -> close 

## TODO

* Fix display bug that seems to omit drawing graphical objects at the start of the program
>>>>>>> 590e64b
