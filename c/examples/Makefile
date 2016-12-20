# Makefile for spl
#****************************************************************

PROGRAMS = \
    Breakout \
    DrawLines \
    DrawRectangles \
    GHelloWorld \
    PacMan \
    StopSign \
    TestGraphics \
    TestInteractors \
    FlipImage \
    CarSimulator \
    BrickPyramid \
    DrawTarget \
    CarSimulatorStructs \
    USFlag

FLAGS = -L../../build/lib -lcs -lm

ifeq ($(OS),Windows_NT)
FLAGS += -lshlwapi
endif

# ***************************************************************
# Entry to bring the package up to date
#    The "make all" entry should be the first real entry

all: $(PROGRAMS)

Breakout: Breakout.o
	gcc -o Breakout Breakout.o $(FLAGS)

Breakout.o: Breakout.c
	gcc -c -I../include Breakout.c

DrawLines: DrawLines.o
	gcc -o DrawLines DrawLines.o $(FLAGS)

DrawLines.o: DrawLines.c
	gcc -c -I../include DrawLines.c

DrawRectangles: DrawRectangles.o
	gcc -o DrawRectangles DrawRectangles.o $(FLAGS)

DrawRectangles.o: DrawRectangles.c
	gcc -c -I../include DrawRectangles.c

GHelloWorld: GHelloWorld.o
	gcc -o GHelloWorld GHelloWorld.o $(FLAGS)

GHelloWorld.o: GHelloWorld.c
	gcc -c -I../include GHelloWorld.c

PacMan: PacMan.o
	gcc -o PacMan PacMan.o $(FLAGS)

PacMan.o: PacMan.c
	gcc -c -I../include PacMan.c

StopSign: StopSign.o
	gcc -o StopSign StopSign.o $(FLAGS)

StopSign.o: StopSign.c
	gcc -c -I../include StopSign.c

TestGraphics: TestGraphics.o
	gcc -o TestGraphics TestGraphics.o $(FLAGS)

TestGraphics.o: TestGraphics.c
	gcc -c -I../include TestGraphics.c

TestInteractors: TestInteractors.o
	gcc -o TestInteractors TestInteractors.o $(FLAGS)

TestInteractors.o: TestInteractors.c
	gcc -c -I../include TestInteractors.c

USFlag: USFlag.o
	gcc -o USFlag USFlag.o $(FLAGS)

USFlag.o: USFlag.c
	gcc -c -I../include USFlag.c

FlipImage.o: FlipImage.c
	gcc -c -I../include FlipImage.c

FlipImage: FlipImage.o
	gcc -o FlipImage FlipImage.o $(FLAGS)

CarSimulator.o: CarSimulator.c
	gcc -c -I../include CarSimulator.c

CarSimulator: CarSimulator.o
	gcc -o CarSimulator CarSimulator.o $(FLAGS)

BrickPyramid.o: BrickPyramid.c
	gcc -c -I../include BrickPyramid.c

BrickPyramid: BrickPyramid.o
	gcc -o BrickPyramid BrickPyramid.o $(FLAGS)

DrawTarget.o: DrawTarget.c
	gcc -c -I../include DrawTarget.c

DrawTarget: DrawTarget.o
	gcc -o DrawTarget DrawTarget.o $(FLAGS)

CarSimulatorStructs: CarSimulatorStructs.o
	gcc -o CarSimulatorStructs CarSimulatorStructs.o $(FLAGS)

CarSimulatorStructs.o: CarSimulatorStructs.c
	gcc -c -I../include CarSimulatorStructs.c

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
