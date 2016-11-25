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

The Windows version needs MSYS in order for make to run. Once MSYS is installed, the library should compile without errors.
    
    git clone https://github.com/OTHRegensburgMedieninformatik/SPL-for-C.git
    cd Spl-for-C
    make
    sudo make install

## TODO

* Bug fixes
* Fix compilation of Jar File on windows
