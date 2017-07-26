# ****************************************************************
# Makefile for SPL

SHELL=/bin/bash

# Sets the target platform for SPL
# Valid values for variable platform are unixlike and windows
MAKE_PARALLEL=-j5

ifeq ($(OS),Windows_NT)
PLATFORM=windows
FREEIMAGE_MAKEFILE=-f Makefile.mingw
else
PLATFORM=unixlike
FREEIMAGE_MAKEFILE=
endif

# Additional compiler flags, add '-DPIPEDEBUG' for a debug build showing piped commands
CFLAGS=-std=gnu11 #-DPIPEDEBUG -march=x86-64
LDLIBS=

ifeq ($(OS),Windows_NT)
LDLIBS +=-lFreeImage
LDLIBS +=-lshlwapi -llibstdc++ -lws2_32 
else
LDLIBS +=-lfreeimage -lstdc++
endif

BUILD = \
    build \
    build/$(PLATFORM) \
    build/$(PLATFORM)/classes \
    build/$(PLATFORM)/lib \
    build/$(PLATFORM)/obj \
    build/$(PLATFORM)/tests

OBJECTS = \
    build/$(PLATFORM)/obj/bst.o \
    build/$(PLATFORM)/obj/charset.o \
    build/$(PLATFORM)/obj/cmpfn.o \
    build/$(PLATFORM)/obj/cslib.o \
    build/$(PLATFORM)/obj/exception.o \
    build/$(PLATFORM)/obj/filelib.o \
    build/$(PLATFORM)/obj/foreach.o \
    build/$(PLATFORM)/obj/generic.o \
    build/$(PLATFORM)/obj/gevents.o \
    build/$(PLATFORM)/obj/gobjects.o \
    build/$(PLATFORM)/obj/gmath.o \
    build/$(PLATFORM)/obj/graph.o \
    build/$(PLATFORM)/obj/gtimer.o \
    build/$(PLATFORM)/obj/gtypes.o \
    build/$(PLATFORM)/obj/gwindow.o \
    build/$(PLATFORM)/obj/hashmap.o \
    build/$(PLATFORM)/obj/iterator.o \
    build/$(PLATFORM)/obj/loadobj.o \
    build/$(PLATFORM)/obj/map.o \
    build/$(PLATFORM)/obj/options.o \
    build/$(PLATFORM)/obj/platform.o \
    build/$(PLATFORM)/obj/pqueue.o \
    build/$(PLATFORM)/obj/queue.o \
    build/$(PLATFORM)/obj/random.o \
    build/$(PLATFORM)/obj/ref.o \
    build/$(PLATFORM)/obj/set.o \
    build/$(PLATFORM)/obj/simpio.o \
    build/$(PLATFORM)/obj/sound.o \
    build/$(PLATFORM)/obj/stack.o \
    build/$(PLATFORM)/obj/strbuf.o \
    build/$(PLATFORM)/obj/strlib.o \
    build/$(PLATFORM)/obj/tokenscanner.o \
    build/$(PLATFORM)/obj/unittest.o \
    build/$(PLATFORM)/obj/winfile.o \
    build/$(PLATFORM)/obj/unixfile.o \
    build/$(PLATFORM)/obj/vector.o

LIBRARIES = build/$(PLATFORM)/lib/libcs.a

RESOURCES = FreeImage

TESTOBJECTS = \
    build/$(PLATFORM)/obj/TestStanfordCSLib.o

TESTS = \
    TestStanfordCSLib

JAR = spl.jar

PROJECT = StarterProject \
		  StarterProjects


# ***************************************************************
# Entry to bring the package up to date
#    The "make all" entry should be the first real entry

all: $(BUILD) $(OBJECTS) $(LIBRARIES) $(TESTS) $(JAR) examples

lib: $(BUILD) $(OBJECTS) $(LIBRARIES) $(TESTS) $(JAR)

# ***************************************************************
# directories

$(BUILD):
	@echo "Build Directories"
	@mkdir -p $(BUILD)


# ***************************************************************
# Library compilations

build/$(PLATFORM)/obj/bst.o: c/src/bst.c c/include/bst.h c/include/cmpfn.h c/include/cslib.h \
           c/include/exception.h c/include/foreach.h c/include/generic.h \
           c/include/iterator.h c/include/itertype.h c/include/strlib.h \
           c/include/unittest.h
	@echo "Build bst.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/bst.o -Ic/include c/src/bst.c

build/$(PLATFORM)/obj/charset.o: c/src/charset.c c/include/charset.h c/include/cmpfn.h \
               c/include/cslib.h c/include/exception.h c/include/foreach.h \
               c/include/generic.h c/include/iterator.h c/include/itertype.h \
               c/include/strlib.h c/include/unittest.h
	@echo "Build charset.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/charset.o -Ic/include c/src/charset.c

build/$(PLATFORM)/obj/cmdscan.o: c/src/cmdscan.c c/include/cmdscan.h c/include/cmpfn.h \
               c/include/cslib.h c/include/exception.h c/include/generic.h \
               c/include/hashmap.h c/include/iterator.h c/include/itertype.h \
               c/include/private/tokenpatch.h c/include/simpio.h \
               c/include/strlib.h c/include/tokenscanner.h
	@echo "Build cmdscan.o"               
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/cmdscan.o -Ic/include c/src/cmdscan.c

build/$(PLATFORM)/obj/cmpfn.o: c/src/cmpfn.c c/include/cmpfn.h c/include/cslib.h c/include/generic.h \
             c/include/strlib.h
	@echo "Build cmpfn.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/cmpfn.o -Ic/include c/src/cmpfn.c

build/$(PLATFORM)/obj/cslib.o: c/src/cslib.c c/include/cslib.h c/include/exception.h
	@echo "Build cslib.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/cslib.o -Ic/include c/src/cslib.c

build/$(PLATFORM)/obj/exception.o: c/src/exception.c c/include/cmpfn.h c/include/cslib.h \
                 c/include/exception.h c/include/generic.h c/include/strlib.h \
                 c/include/unittest.h
	@echo "Build exception.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/exception.o -Ic/include c/src/exception.c

build/$(PLATFORM)/obj/filelib.o: c/src/filelib.c c/include/cmpfn.h c/include/cslib.h \
               c/include/exception.h c/include/filelib.h c/include/generic.h \
               c/include/iterator.h c/include/itertype.h c/include/strlib.h \
               c/include/unittest.h
	@echo "Build filelib.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/filelib.o -Ic/include c/src/filelib.c

build/$(PLATFORM)/obj/foreach.o: c/src/foreach.c c/include/cslib.h c/include/foreach.h \
               c/include/iterator.h
	@echo "Build foreach.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/foreach.o -Ic/include c/src/foreach.c

build/$(PLATFORM)/obj/generic.o: c/src/generic.c c/include/charset.h c/include/cmpfn.h \
               c/include/cslib.h c/include/exception.h c/include/generic.h \
               c/include/gevents.h c/include/gobjects.h c/include/gtimer.h \
               c/include/gtypes.h c/include/gwindow.h c/include/hashmap.h \
               c/include/iterator.h c/include/map.h c/include/pqueue.h \
               c/include/queue.h c/include/ref.h c/include/set.h c/include/stack.h \
               c/include/strbuf.h c/include/strlib.h c/include/vector.h
	@echo "Build generic.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/generic.o -Ic/include c/src/generic.c

build/$(PLATFORM)/obj/gevents.o: c/src/gevents.c c/include/cmpfn.h c/include/cslib.h \
               c/include/exception.h c/include/generic.h c/include/gevents.h \
               c/include/ginteractors.h c/include/gobjects.h c/include/gtimer.h \
               c/include/gtypes.h c/include/gwindow.h c/include/hashmap.h \
               c/include/iterator.h c/include/platform.h c/include/sound.h \
               c/include/strlib.h c/include/unittest.h c/include/vector.h
	@echo "Build gevents.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/gevents.o -Ic/include c/src/gevents.c

build/$(PLATFORM)/obj/gmath.o: c/src/gmath.c c/include/gmath.h
	@echo "Build gmath.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/gmath.o -Ic/include c/src/gmath.c

FreeImage:  
	@echo "Build FreeImage started"
	@echo "This could take some realy long time ..."
	@echo "Building ..."
	@make $(MAKE_PARALLEL) -s -C resources/FreeImage $(FREEIMAGE_MAKEFILE) FREEIMAGE_LIBRARY_TYPE=STATIC
	@echo "Build FreeImage finished"

FreeImage_Clean:
	@echo "Cleaning FreeImage started"
	@echo "Cleaning ..."
	@make -s -C resources/FreeImage $(FREEIMAGE_MAKEFILE) clean FREEIMAGE_LIBRARY_TYPE=STATIC
	@echo "Cleaning FreeImage finished"

build/$(PLATFORM)/obj/gobjects.o: FreeImage c/src/gobjects.c c/include/cmpfn.h c/include/cslib.h \
                c/include/generic.h c/include/gevents.h c/include/ginteractors.h \
                c/include/gmath.h c/include/gobjects.h c/include/gtimer.h \
                c/include/gtypes.h c/include/gwindow.h c/include/platform.h \
                c/include/sound.h c/include/vector.h resources/FreeImage/Dist/FreeImage.h 
	@echo "Build gobjects.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/gobjects.o -Ic/include -Iresources/FreeImage/Dist/ c/src/gobjects.c

build/$(PLATFORM)/obj/graph.o: c/src/graph.c c/include/cmpfn.h c/include/cslib.h \
             c/include/exception.h c/include/foreach.h c/include/generic.h \
             c/include/graph.h c/include/hashmap.h c/include/iterator.h \
             c/include/itertype.h c/include/set.h c/include/strlib.h \
             c/include/unittest.h
	@echo "Build graph.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/graph.o -Ic/include c/src/graph.c

build/$(PLATFORM)/obj/gtimer.o: c/src/gtimer.c c/include/cmpfn.h c/include/cslib.h \
              c/include/generic.h c/include/gevents.h c/include/ginteractors.h \
              c/include/gobjects.h c/include/gtimer.h c/include/gtypes.h \
              c/include/gwindow.h c/include/platform.h c/include/sound.h \
              c/include/vector.h
	@echo "Build gtimer.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/gtimer.o -Ic/include c/src/gtimer.c

build/$(PLATFORM)/obj/gtypes.o: c/src/gtypes.c c/include/cmpfn.h c/include/cslib.h \
              c/include/exception.h c/include/generic.h c/include/gtypes.h \
              c/include/unittest.h
	@echo "Build gtypes.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/gtypes.o -Ic/include c/src/gtypes.c

build/$(PLATFORM)/obj/gwindow.o: c/src/gwindow.c c/include/cmpfn.h c/include/cslib.h \
               c/include/generic.h c/include/gevents.h c/include/ginteractors.h \
               c/include/gmath.h c/include/gobjects.h c/include/gtimer.h \
               c/include/gtypes.h c/include/gwindow.h c/include/platform.h \
               c/include/sound.h c/include/vector.h
	@echo "Build gwindow.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/gwindow.o -Ic/include c/src/gwindow.c

build/$(PLATFORM)/obj/hashmap.o: c/src/hashmap.c c/include/cmpfn.h c/include/cslib.h \
               c/include/exception.h c/include/foreach.h c/include/generic.h \
               c/include/hashmap.h c/include/iterator.h c/include/itertype.h \
               c/include/strlib.h c/include/unittest.h
	@echo "Build hashmap.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/hashmap.o -Ic/include c/src/hashmap.c

build/$(PLATFORM)/obj/iterator.o: c/src/iterator.c c/include/cmpfn.h c/include/cslib.h \
                c/include/iterator.h c/include/itertype.h
	@echo "Build iterator.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/iterator.o -Ic/include c/src/iterator.c

build/$(PLATFORM)/obj/loadobj.o: c/src/loadobj.c c/include/cmpfn.h c/include/cslib.h \
               c/include/filelib.h c/include/generic.h c/include/iterator.h \
               c/include/loadobj.h c/include/strlib.h
	@echo "Build loadobj.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/loadobj.o -Ic/include c/src/loadobj.c

build/$(PLATFORM)/obj/map.o: c/src/map.c c/include/bst.h c/include/cmpfn.h c/include/cslib.h \
           c/include/exception.h c/include/foreach.h c/include/generic.h \
           c/include/iterator.h c/include/itertype.h c/include/map.h \
           c/include/strlib.h c/include/unittest.h
	@echo "Build map.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/map.o -Ic/include c/src/map.c

build/$(PLATFORM)/obj/options.o: c/src/options.c c/include/cmpfn.h c/include/cslib.h \
               c/include/exception.h c/include/generic.h c/include/hashmap.h \
               c/include/iterator.h c/include/options.h c/include/strlib.h \
               c/include/unittest.h c/include/vector.h
	@echo "Build options.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/options.o -Ic/include c/src/options.c

build/$(PLATFORM)/obj/platform.o: c/src/platform.c c/include/cmpfn.h c/include/cslib.h \
                c/include/filelib.h c/include/generic.h c/include/gevents.h \
                c/include/ginteractors.h c/include/gobjects.h c/include/gtimer.h \
                c/include/gtypes.h c/include/gwindow.h c/include/hashmap.h \
                c/include/iterator.h c/include/platform.h \
                c/include/private/tokenpatch.h c/include/queue.h \
                c/include/simpio.h c/include/sound.h c/include/strbuf.h \
                c/include/strlib.h c/include/tokenscanner.h c/include/vector.h
	@echo "Build platform.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/platform.o -Ic/include c/src/platform.c

build/$(PLATFORM)/obj/pqueue.o: c/src/pqueue.c c/include/cmpfn.h c/include/cslib.h \
              c/include/exception.h c/include/generic.h c/include/pqueue.h \
              c/include/unittest.h c/include/vector.h
	@echo "Build pqueue.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/pqueue.o -Ic/include c/src/pqueue.c

build/$(PLATFORM)/obj/queue.o: c/src/queue.c c/include/cmpfn.h c/include/cslib.h \
             c/include/exception.h c/include/generic.h c/include/queue.h \
             c/include/unittest.h
	@echo "Build queue.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/queue.o -Ic/include c/src/queue.c

build/$(PLATFORM)/obj/random.o: c/src/random.c c/include/cslib.h c/include/exception.h \
              c/include/private/randompatch.h c/include/random.h \
              c/include/unittest.h
	@echo "Build random.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/random.o -Ic/include c/src/random.c

build/$(PLATFORM)/obj/ref.o: c/src/ref.c c/include/cslib.h c/include/ref.h
	@echo "Build ref.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/ref.o -Ic/include c/src/ref.c

build/$(PLATFORM)/obj/set.o: c/src/set.c c/include/bst.h c/include/cmpfn.h c/include/cslib.h \
           c/include/exception.h c/include/foreach.h c/include/generic.h \
           c/include/iterator.h c/include/itertype.h c/include/map.h \
           c/include/set.h c/include/strlib.h c/include/unittest.h
	@echo "Build set.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/set.o -Ic/include c/src/set.c

build/$(PLATFORM)/obj/simpio.o: c/src/simpio.c c/include/cmpfn.h c/include/cslib.h \
              c/include/generic.h c/include/simpio.h c/include/strlib.h
	@echo "Build simpio.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/simpio.o -Ic/include c/src/simpio.c

build/$(PLATFORM)/obj/sound.o: c/src/sound.c c/include/cmpfn.h c/include/cslib.h c/include/generic.h \
             c/include/gevents.h c/include/ginteractors.h c/include/gobjects.h \
             c/include/gtimer.h c/include/gtypes.h c/include/gwindow.h \
             c/include/platform.h c/include/sound.h c/include/vector.h
	@echo "Build sound.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/sound.o -Ic/include c/src/sound.c

build/$(PLATFORM)/obj/stack.o: c/src/stack.c c/include/cmpfn.h c/include/cslib.h \
             c/include/exception.h c/include/generic.h c/include/stack.h \
             c/include/unittest.h
	@echo "Build stack.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/stack.o -Ic/include c/src/stack.c

build/$(PLATFORM)/obj/strbuf.o: c/src/strbuf.c c/include/cmpfn.h c/include/cslib.h \
              c/include/exception.h c/include/generic.h c/include/strbuf.h \
              c/include/strlib.h c/include/unittest.h
	@echo "Build strbuf.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/strbuf.o -Ic/include c/src/strbuf.c

build/$(PLATFORM)/obj/strlib.o: c/src/strlib.c c/include/cmpfn.h c/include/cslib.h \
              c/include/exception.h c/include/generic.h c/include/strlib.h \
              c/include/unittest.h
	@echo "Build strlib.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/strlib.o -Ic/include c/src/strlib.c

build/$(PLATFORM)/obj/tokenscanner.o: c/src/tokenscanner.c c/include/cmpfn.h c/include/cslib.h \
                    c/include/exception.h c/include/generic.h \
                    c/include/private/tokenpatch.h c/include/strbuf.h \
                    c/include/strlib.h c/include/tokenscanner.h \
                    c/include/unittest.h
	@echo "Build tokenscanner.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/tokenscanner.o -Ic/include c/src/tokenscanner.c

build/$(PLATFORM)/obj/unittest.o: c/src/unittest.c c/include/cmpfn.h c/include/cslib.h \
                c/include/exception.h c/include/generic.h c/include/strlib.h \
                c/include/unittest.h
	@echo "Build unittest.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/unittest.o -Ic/include c/src/unittest.c

build/$(PLATFORM)/obj/unixfile.o: c/src/unixfile.c c/include/cmpfn.h c/include/cslib.h \
                c/include/filelib.h c/include/generic.h c/include/iterator.h \
                c/include/strlib.h c/include/vector.h
	@echo "Build unixfile.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/unixfile.o -Ic/include c/src/unixfile.c

build/$(PLATFORM)/obj/winfile.o: c/src/unixfile.c c/include/cmpfn.h c/include/cslib.h \
                c/include/filelib.h c/include/generic.h c/include/iterator.h \
                c/include/strlib.h c/include/vector.h
	@echo "Build winfile.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/winfile.o -Ic/include c/src/winfile.c

build/$(PLATFORM)/obj/vector.o: c/src/vector.c c/include/cmpfn.h c/include/cslib.h \
              c/include/exception.h c/include/generic.h c/include/iterator.h \
              c/include/itertype.h c/include/strlib.h c/include/unittest.h \
              c/include/vector.h
	@echo "Build vector.o"
	@gcc $(CFLAGS) -D$(PLATFORM) -c -o build/$(PLATFORM)/obj/vector.o -Ic/include c/src/vector.c


# ***************************************************************
# Entry to reconstruct the library archive

build/$(PLATFORM)/lib/libcs.a: $(OBJECTS) resources/FreeImage/Dist/libFreeImage.a
	@echo "Build libcs.a"
	@-rm -f build/$(PLATFORM)/lib/libcs.a
	@-rm -f build/$(PLATFORM)/lib/libFreeImage.a
	@ar cr build/$(PLATFORM)/lib/libcs.a \
			 $(OBJECTS) 

	@ranlib build/$(PLATFORM)/lib/libcs.a 
	@cp -r c/include build/$(PLATFORM)/
	@cp resources/FreeImage/Dist/FreeImage.h build/$(PLATFORM)/include/
	@cp resources/FreeImage/Dist/libfreeimage.a build/$(PLATFORM)/lib/


# ***************************************************************
# Test program

build/$(PLATFORM)/obj/TestStanfordCSLib.o: c/tests/TestStanfordCSLib.c c/include/cslib.h \
	c/include/strlib.h c/include/unittest.h
	@echo "Build TestStanfordCSLib.o"
	@gcc $(CFLAGS) -c -o build/$(PLATFORM)/obj/TestStanfordCSLib.o -Ic/include \
            c/tests/TestStanfordCSLib.c 

TestStanfordCSLib: $(TESTOBJECTS) resources/FreeImage/Dist/libFreeImage.a build/$(PLATFORM)/lib/libcs.a
	@echo "Build TestStanfordCSLib"
	@gcc $(CFLAGS) -o build/$(PLATFORM)/tests/TestStanfordCSLib $(TESTOBJECTS) -Lbuild/$(PLATFORM)/lib -lcs -lm $(LDLIBS)

# ***************************************************************
# Java Back End

$(JAR): stanford/spl/JavaBackEnd.class
	@echo "Build spl.jar"
	@cp java/lib/acm.jar build/$(PLATFORM)/lib/spl.jar
	@(cd build/$(PLATFORM)/classes; jar ufm ../lib/spl.jar ../../../java/include/JBEManifest.txt \
		`find stanford -name '*.class'`)
#	@echo jar cf build/$(PLATFORM)/lib/spl.jar . . .

stanford/spl/JavaBackEnd.class: java/src/stanford/spl/*.java
	@echo "Build JavaBackEnd.class"
	@javac -d build/$(PLATFORM)/classes -classpath java/lib/acm.jar -sourcepath java/src \
		java/src/stanford/spl/JavaBackEnd.java


# ***************************************************************
# install

install: build/$(PLATFORM)/lib/libcs.a $(JAR)
	rm -rf /usr/local/include/spl
	cp -r build/$(PLATFORM)/include /usr/local/include/spl
	chmod -R a+rX /usr/local/include/spl
	cp build/$(PLATFORM)/lib/{libcs.a,spl.jar} /usr/local/lib/
	chmod -R a+r /usr/local/lib/{libcs.a,spl.jar}

examples: build/$(PLATFORM)/lib/libcs.a $(JAR)
	@echo "Build Examples"
	@cp build/$(PLATFORM)/lib/spl.jar c/examples/
	@make -C c/examples

starterprojects: clean $(BUILD) $(OBJECTS) $(LIBRARIES) $(TESTS) $(JAR)
	@echo "Build StarterProjects"
	@rm -rf StarterProjects
	@mkdir StarterProjects
	@cp -r ide/clion StarterProjects/clion
	@cp -r ide/codeblocks StarterProjects/codeblocks
	@cp -r ide/makefile StarterProjects/makefile
	@echo "Build StarterProject for Clion on Windows"
	@cp ide/src/HelloGraphics.c StarterProjects/clion/windows
	@cp -r build/$(PLATFORM)/lib StarterProjects/clion/windows/lib
	@cp -r build/$(PLATFORM)/include StarterProjects/clion/windows/include
	@echo "Build StarterProject for Clion on Linux"
	@cp ide/src/HelloGraphics.c StarterProjects/clion/linux
	@cp -r build/$(PLATFORM)/lib StarterProjects/clion/linux/lib
	@cp -r build/$(PLATFORM)/include StarterProjects/clion/linux/include
	@echo "Build StarterProject for Clion on MacOS"
	@cp ide/src/HelloGraphics.c StarterProjects/clion/macos
	@cp -r build/$(PLATFORM)/lib StarterProjects/clion/macos/lib
	@cp -r build/$(PLATFORM)/include StarterProjects/clion/macos/include
	@echo "Build StarterProject for CodeBlocks on Windows"
	@cp ide/src/HelloGraphics.c StarterProjects/codeblocks/windows
	@cp -r build/$(PLATFORM)/lib StarterProjects/codeblocks/windows/lib
	@cp -r build/$(PLATFORM)/include StarterProjects/codeblocks/windows/include
	@echo "Build StarterProject for CodeBlocks on Linux"
	@cp ide/src/HelloGraphics.c StarterProjects/codeblocks/linux
	@cp -r build/$(PLATFORM)/lib StarterProjects/codeblocks/linux/lib
	@cp -r build/$(PLATFORM)/include StarterProjects/codeblocks/linux/include
	@echo "Build StarterProject for CodeBlocks on MacOS"
	@cp ide/src/HelloGraphics.c StarterProjects/codeblocks/macos
	@cp -r build/$(PLATFORM)/lib StarterProjects/codeblocks/macos/lib
	@cp -r build/$(PLATFORM)/include StarterProjects/codeblocks/macos/include
	@echo "Build StarterProject for Makefile Project"
	@cp ide/src/HelloGraphics.c StarterProjects/makefile
	@cp -r build/$(PLATFORM)/lib StarterProjects/makefile/lib
	@cp -r build/$(PLATFORM)/include StarterProjects/makefile/include
	@echo "Check the StarterProjects folder"

clion_windows: clean $(BUILD) $(OBJECTS) $(LIBRARIES) $(TESTS) $(JAR)
	@echo "Build StarterProject for Clion on Windows"
	@rm -rf StarterProject
	@cp -r ide/clion/windows StarterProject
	@cp -r build/$(PLATFORM)/lib StarterProject
	@cp -r build/$(PLATFORM)/include StarterProject
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

clion_linux: clean $(BUILD) $(OBJECTS) $(LIBRARIES) $(TESTS) $(JAR)
	@echo "Build StarterProject for Clion on Linux";
	@rm -rf StarterProject
	@cp -r ide/clion/linux StarterProject
	@cp -r build/$(PLATFORM)/lib StarterProject
	@cp -r build/$(PLATFORM)/include StarterProject
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

clion_macos: clean $(BUILD) $(OBJECTS) $(LIBRARIES) $(TESTS) $(JAR)
	@echo "Build StarterProject for Clion on MaxOS";
	@rm -rf StarterProject
	@cp -r ide/clion/macos StarterProject
	@cp -r build/$(PLATFORM)/lib StarterProject
	@cp -r build/$(PLATFORM)/include StarterProject
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

codeblocks_windows: clean $(BUILD) $(OBJECTS) $(LIBRARIES) $(TESTS) $(JAR)
	@echo "Build StarterProject for CodeBlocks on Windows";
	@rm -rf StarterProject
	@cp -r ide/codeblocks/windows StarterProject
	@cp -r build/$(PLATFORM)/lib StarterProject
	@cp -r build/$(PLATFORM)/include StarterProject
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

codeblocks_linux: clean $(BUILD) $(OBJECTS) $(LIBRARIES) $(TESTS) $(JAR)
	@echo "Build StarterProject for CodeBlocks on Linux";
	@rm -rf StarterProject
	@cp -r ide/codeblocks/linux StarterProject
	@cp -r build/$(PLATFORM)/lib StarterProject/lib
	@cp -r build/$(PLATFORM)/include StarterProject/include
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

codeblocks_macos: clean $(BUILD) $(OBJECTS) $(LIBRARIES) $(TESTS) $(JAR)
	@echo "Build StarterProject for CodeBlocks on MacOS";
	@rm -rf StarterProject
	@cp -r ide/codeblocks/macos StarterProject
	@cp -r build/$(PLATFORM)/lib StarterProject
	@cp -r build/$(PLATFORM)/include StarterProject
	@cp ide/src/HelloGraphics.c StarterProject
	@echo "Check the StarterProject folder"

makefile: clean $(BUILD) $(OBJECTS) $(LIBRARIES) $(TESTS) $(JAR)
	@echo "Build StarterProject for Makefile Project";
	@rm -rf StarterProject
	@cp -r ide/makefile StarterProject
	@cp -r build/$(PLATFORM)/lib StarterProject
	@cp -r build/$(PLATFORM)/include StarterProject
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

examples-tidy:
	@rm -f c/examples/*.o
	@rm -f c/examples/*.exe

scratch clean: tidy FreeImage_Clean
	@rm -f -r $(BUILD) $(OBJECTS) $(LIBRARIES) $(TESTS) $(TESTOBJECTS) $(PROJECT)
	@echo "Cleaning Done"
