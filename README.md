# Stanford Portable Library (SPL) for MacOS, Linux and Windows

This is OTH Regensburg's fork of the Harvard CS50 version Eric Roberts' Stanford Portable Library. This version contains a patch of Robert's original version so that the library can be compiled under Linux, MacOS and Windows.

## Building
To set the target platform, edit the Makefile and change like so:

### MacOS

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

### Compiling and running examples
You need to copy the compiled jar file from build/lib to c/examples.
From there run make to compile the examples.

## TODO

* Bug fixes

