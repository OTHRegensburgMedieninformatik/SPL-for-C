# Makefile for spl
#****************************************************************

ifeq ($(OS),Windows_NT)
PLATFORM=windows
FLAGS = -L../../build/$(PLATFORM)/lib -lcs -lm 
FLAGS += -lshlwapi
CSTD =
else
PLATFORM=unixlike
FLAGS = -L../../build/$(PLATFORM)/lib -lcs -lm 
FLAGS += -lfreeimage
CSTD = -std=c99 -arch=x86_64 -stdlib=libstdc++
endif
CC = clang -v 
CPP = clang++


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
	$(CC) -D$(PLATFORM) -o Breakout Breakout.o $(FLAGS)

Breakout.o: Breakout.c
	$(CC) -D$(PLATFORM) -c -I../include Breakout.c $(CSTD)

DrawLines: DrawLines.o
	$(CC) -D$(PLATFORM) -o DrawLines DrawLines.o $(FLAGS)

DrawLines.o: DrawLines.c
	$(CC) -D$(PLATFORM) -c -I../include DrawLines.c $(CSTD)

DrawRectangles: DrawRectangles.o
	$(CC) -D$(PLATFORM) -o DrawRectangles DrawRectangles.o $(FLAGS)

DrawRectangles.o: DrawRectangles.c
	$(CC) -D$(PLATFORM) -c -I../include DrawRectangles.c $(CSTD)

GHelloWorld: GHelloWorld.o
	$(CC) -D$(PLATFORM) -o GHelloWorld GHelloWorld.o $(FLAGS)

GHelloWorld.o: GHelloWorld.c
	$(CC) -D$(PLATFORM) -c -I../include GHelloWorld.c $(CSTD)

PacMan: PacMan.o
	$(CC) -D$(PLATFORM) -o PacMan PacMan.o $(FLAGS)

PacMan.o: PacMan.c
	$(CC) -D$(PLATFORM) -c -I../include PacMan.c $(CSTD)

StopSign: StopSign.o
	$(CC) -D$(PLATFORM) -o StopSign StopSign.o $(FLAGS)

StopSign.o: StopSign.c
	$(CC) -D$(PLATFORM) -c -I../include StopSign.c $(CSTD)

TestGraphics: TestGraphics.o
	$(CC) -D$(PLATFORM) -o TestGraphics TestGraphics.o $(FLAGS)

TestGraphics.o: TestGraphics.c
	$(CC) -D$(PLATFORM) -c -I../include TestGraphics.c $(CSTD)
	
TestPixelArray: TestPixelArray.o
	$(CC) -D$(PLATFORM) -o TestPixelArray TestPixelArray.o $(FLAGS)
	
TestPixelArray.o: TestPixelArray.c
	$(CC) -D$(PLATFORM) -c -I../include TestPixelArray.c $(CSTD)

TestInteractors: TestInteractors.o
	$(CC) -D$(PLATFORM) -o TestInteractors TestInteractors.o $(FLAGS)

TestInteractors.o: TestInteractors.c
	$(CC) -D$(PLATFORM) -c -I../include TestInteractors.c $(CSTD)

USFlag: USFlag.o
	$(CC) -D$(PLATFORM) -o USFlag USFlag.o $(FLAGS)

USFlag.o: USFlag.c
	$(CC) -D$(PLATFORM) -c -I../include USFlag.c $(CSTD)

FlipImage.o: FlipImage.c
	$(CC) -D$(PLATFORM) -c -I../include FlipImage.c $(CSTD)

FlipImage: FlipImage.o
	$(CC) -D$(PLATFORM) -o FlipImage FlipImage.o $(FLAGS)

CarSimulator.o: CarSimulator.c
	$(CC) -D$(PLATFORM) -c -I../include CarSimulator.c $(CSTD)

CarSimulator: CarSimulator.o
	$(CC) -o CarSimulator CarSimulator.o $(FLAGS)

BrickPyramid.o: BrickPyramid.c
	$(CC) -D$(PLATFORM) -c -I../include BrickPyramid.c $(CSTD)

BrickPyramid: BrickPyramid.o
	$(CC) -D$(PLATFORM) -o BrickPyramid BrickPyramid.o $(FLAGS)

DrawTarget.o: DrawTarget.c
	$(CC) -D$(PLATFORM) -c -I../include DrawTarget.c $(CSTD)

DrawTarget: DrawTarget.o
	$(CC) -D$(PLATFORM) -o DrawTarget DrawTarget.o $(FLAGS)

CarSimulatorStructs: CarSimulatorStructs.o
	$(CC) -D$(PLATFORM) -o CarSimulatorStructs CarSimulatorStructs.o $(FLAGS)

CarSimulatorStructs.o: CarSimulatorStructs.c
	$(CC) -D$(PLATFORM) -c -I../include CarSimulatorStructs.c $(CSTD)

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
