# C version of the Stanford Portable Library (SPL) for MacOS, Linux and Windows

SPL is a simple graphics library that can be used in introductory university-level CS courses.
This is a fork of the Harvard CS50 version of Eric Roberts' Stanford Portable Library. This version contains a patch of Robert's original version so that the library can also be compiled under Windows.

## Building C and Java sources
The Makefile automatically detects your system and switches between the Windows and Linux version (no configuration required).

### MacOS (also tested with Ubuntu and Fedora)

    git clone https://github.com/OTHRegensburgMedieninformatik/SPL-for-C.git
    cd Spl-for-C
    make
    sudo make install

### Windows

The Windows version needs MSYS (http://www.mingw.org/wiki/MSYS) in order for make to run. Once MSYS is installed, make sure to edit the PATH variable, so that the MSYS bin folder is the first in the list. This is important, since the Windows find command used in the makefile behaves differently than the MSYS version. Once this is set, the library should compile without errors.
    
    git clone https://github.com/OTHRegensburgMedieninformatik/SPL-for-C.git
    cd Spl-for-C
    make
    make install

## Compiling and running the C example programs
The library comes with several example programs that demonstrate the capability of the library but can also be used as student assignments.

**Caution:** You need to copy the compiled jar file from build/lib to c/examples.
From there run make to compile the examples.

## TODO

* Bug fixes

