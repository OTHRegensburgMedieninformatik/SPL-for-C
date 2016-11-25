# Stanford Portable Library (SPL)

This is OTH Regensburg's fork of the Harvard CS50 version Eric Roberts' Stanford Portable Library. This version contains a patch of Robert's original version so that the library can be compiled under Linux, MacOS and Windows.

## Building
To set the target platform, edit the Makefile and change like so:

### MacOS

    sudo yum install -y bash binutils coreutils findutils gcc java-1.?.0-openjdk-devel
    git clone git@github.com:cs50/spl.git
    cd spl
    make
    sudo make install

### Windows

The Windows version needs MSYS in order for make to run. Once MSYS is installed, the library should compile without errors.

## TODO

* Bug fixes
* Edit makefile to allow windows and Unix compilation
