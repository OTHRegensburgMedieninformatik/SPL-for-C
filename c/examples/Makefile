# Makefile for spl
#****************************************************************

ifeq ($(OS),Windows_NT)
PLATFORM=windows
FLAGS = -L../../build/$(PLATFORM)/lib -lcs -lm 
FLAGS += -lshlwapi
CSTD =
else
PLATFORM=unixlike
FLAGS = -L../../build/$(PLATFORM)/lib -lcs -lm -lfreeimage -lstdc++
#FLAGS += -syslibroot $(SDK_PATH)
CSTD = -std=c11 -stdlib=libstdc++ 
endif
SDK_PATH = /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk
INCFLAGS = -I../../build/$(PLATFORM)/include -I../include -isysroot $(SDK_PATH)

CC = gcc
CPP = g++


PROGRAMS = \
    Breakout \
    DrawLines \
    DrawRectangles \
    GHelloWorld \
    PacMan \
    StopSign \
    TestGraphics \
    TestInteractors \
    TestPixelArray \
    FlipImage \
    CarSimulator \
    BrickPyramid \
    DrawTarget \
    CarSimulatorStructs \
    USFlag

# ***************************************************************
# Entry to bring the package up to date
#    The "make all" entry should be the first real entry

all: $(PROGRAMS)

Breakout: Breakout.o
	@echo Build $@
	@$(CC) -D$(PLATFORM) -o Breakout Breakout.o $(FLAGS)

Breakout.o: Breakout.c
	@echo Build $@
	@$(CC) -D$(PLATFORM) -c Breakout.c  $(INCFLAGS) $(CSTD)

DrawLines: DrawLines.o
	@echo Build $@
	@$(CC) -D$(PLATFORM) -o DrawLines DrawLines.o $(FLAGS)

DrawLines.o: DrawLines.c
	@echo Build $@
	@$(CC) -D$(PLATFORM) -c -I../include DrawLines.c $(CSTD)

DrawRectangles: DrawRectangles.o
	@echo Build $@
	@$(CC) -D$(PLATFORM) -o DrawRectangles DrawRectangles.o $(FLAGS)

DrawRectangles.o: DrawRectangles.c
	@echo Build $@
	@$(CC) -D$(PLATFORM) -c -I../include DrawRectangles.c $(CSTD)

GHelloWorld: GHelloWorld.o
	@echo Build $@
	@$(CC) -D$(PLATFORM) -o GHelloWorld GHelloWorld.o $(FLAGS)

GHelloWorld.o: GHelloWorld.c
	@echo Build $@
	@$(CC) -D$(PLATFORM) -c -I../include GHelloWorld.c $(CSTD)

PacMan: PacMan.o
	@echo Build $@
	@$(CC) -D$(PLATFORM) -o PacMan PacMan.o $(FLAGS)

PacMan.o: PacMan.c
	@echo Build $@
	@$(CC) -D$(PLATFORM) -c -I../include PacMan.c $(CSTD)

StopSign: StopSign.o
	@echo Build $@
	@$(CC) -D$(PLATFORM) -o StopSign StopSign.o $(FLAGS)

StopSign.o: StopSign.c
	@echo Build $@
	@$(CC) -D$(PLATFORM) -c -I../include StopSign.c $(CSTD)

TestGraphics: TestGraphics.o
	@echo Build $@
	@$(CC) -D$(PLATFORM) -o TestGraphics TestGraphics.o $(FLAGS)

TestGraphics.o: TestGraphics.c
	@echo Build $@
	@$(CC) -D$(PLATFORM) -c -I../include TestGraphics.c $(CSTD)
	
TestPixelArray: TestPixelArray.o
	@echo Build $@
	@$(CC) -D$(PLATFORM) -o TestPixelArray TestPixelArray.o $(FLAGS)
	
TestPixelArray.o: TestPixelArray.c
	@echo Build $@
	@$(CC) -D$(PLATFORM) -c -I../include TestPixelArray.c $(CSTD)

TestInteractors: TestInteractors.o
	@echo Build $@
	@$(CC) -D$(PLATFORM) -o TestInteractors TestInteractors.o $(FLAGS)

TestInteractors.o: TestInteractors.c
	@echo Build $@
	@$(CC) -D$(PLATFORM) -c -I../include TestInteractors.c $(CSTD)

USFlag: USFlag.o
	@echo Build $@
	@$(CC) -D$(PLATFORM) -o USFlag USFlag.o $(FLAGS)

USFlag.o: USFlag.c
	@echo Build $@
	@$(CC) -D$(PLATFORM) -c -I../include USFlag.c $(CSTD)

FlipImage.o: FlipImage.c
	@echo Build $@
	@$(CC) -D$(PLATFORM) -c -I../include FlipImage.c $(CSTD)

FlipImage: FlipImage.o
	@echo Build $@
	@$(CC) -D$(PLATFORM) -o FlipImage FlipImage.o $(FLAGS)

CarSimulator.o: CarSimulator.c
	@echo Build $@
	@$(CC) -D$(PLATFORM) -c -I../include CarSimulator.c $(CSTD)

CarSimulator: CarSimulator.o
	@echo Build $@
	@$(CC) -o CarSimulator CarSimulator.o $(FLAGS)

BrickPyramid.o: BrickPyramid.c
	@echo Build $@
	@$(CC) -D$(PLATFORM) -c -I../include BrickPyramid.c $(CSTD)

BrickPyramid: BrickPyramid.o
	@echo Build $@
	@$(CC) -D$(PLATFORM) -o BrickPyramid BrickPyramid.o $(FLAGS)

DrawTarget.o: DrawTarget.c
	@echo Build $@
	@$(CC) -D$(PLATFORM) -c -I../include DrawTarget.c $(CSTD)

DrawTarget: DrawTarget.o
	@echo Build $@
	@$(CC) -D$(PLATFORM) -o DrawTarget DrawTarget.o $(FLAGS)

CarSimulatorStructs: CarSimulatorStructs.o
	@echo Build $@
	@$(CC) -D$(PLATFORM) -o CarSimulatorStructs CarSimulatorStructs.o $(FLAGS)

CarSimulatorStructs.o: CarSimulatorStructs.c
	@echo Build $@
	@$(CC) -D$(PLATFORM) -c -I../include CarSimulatorStructs.c $(CSTD)

# ***************************************************************
# Standard entries to remove files from the directories
#    tidy  -- eliminate unwanted files
#    clean -- delete derived files in preparation for rebuild

tidy:
	@rm -f `find . -name ',*' -o -name '.,*' -o -name '*~'`
	@rm -f `find . -name '*.tmp' -o -name '*.err'`
	@rm -f `find . -name core -o -name a.out`

clean scratch: tidy
	@rm -f *.o *.a $(PROGRAMS)
