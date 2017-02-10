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
CSTD = -std=c99
endif

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
    USFlag\
	Run






# ***************************************************************
# Entry to bring the package up to date
#    The "make all" entry should be the first real entry

all: $(PROGRAMS)

Run: Run.o
	gcc -D$(PLATFORM) -o Run Run.o $(FLAGS)

Run.o: Run.c
	gcc -D$(PLATFORM) -c -I../include Run.c $(CSTD)

Breakout: Breakout.o
	gcc -D$(PLATFORM) -o Breakout Breakout.o $(FLAGS)

Breakout.o: Breakout.c
	gcc -D$(PLATFORM) -c -I../include Breakout.c $(CSTD)

DrawLines: DrawLines.o
	gcc -D$(PLATFORM) -o DrawLines DrawLines.o $(FLAGS)

DrawLines.o: DrawLines.c
	gcc -D$(PLATFORM) -c -I../include DrawLines.c $(CSTD)

DrawRectangles: DrawRectangles.o
	gcc -D$(PLATFORM) -o DrawRectangles DrawRectangles.o $(FLAGS)

DrawRectangles.o: DrawRectangles.c
	gcc -D$(PLATFORM) -c -I../include DrawRectangles.c $(CSTD)

GHelloWorld: GHelloWorld.o
	gcc -D$(PLATFORM) -o GHelloWorld GHelloWorld.o $(FLAGS)

GHelloWorld.o: GHelloWorld.c
	gcc -D$(PLATFORM) -c -I../include GHelloWorld.c $(CSTD)

PacMan: PacMan.o
	gcc -D$(PLATFORM) -o PacMan PacMan.o $(FLAGS)

PacMan.o: PacMan.c
	gcc -D$(PLATFORM) -c -I../include PacMan.c $(CSTD)

StopSign: StopSign.o
	gcc -D$(PLATFORM) -o StopSign StopSign.o $(FLAGS)

StopSign.o: StopSign.c
	gcc -D$(PLATFORM) -c -I../include StopSign.c $(CSTD)

TestGraphics: TestGraphics.o
	gcc -D$(PLATFORM) -o TestGraphics TestGraphics.o $(FLAGS)

TestGraphics.o: TestGraphics.c
	gcc -D$(PLATFORM) -c -I../include TestGraphics.c $(CSTD)

TestInteractors: TestInteractors.o
	gcc -D$(PLATFORM) -o TestInteractors TestInteractors.o $(FLAGS)

TestInteractors.o: TestInteractors.c
	gcc -D$(PLATFORM) -c -I../include TestInteractors.c $(CSTD)

USFlag: USFlag.o
	gcc -D$(PLATFORM) -o USFlag USFlag.o $(FLAGS)

USFlag.o: USFlag.c
	gcc -D$(PLATFORM) -c -I../include USFlag.c $(CSTD)

FlipImage.o: FlipImage.c
	gcc -D$(PLATFORM) -c -I../include FlipImage.c $(CSTD)

FlipImage: FlipImage.o
	gcc -D$(PLATFORM) -o FlipImage FlipImage.o $(FLAGS)

CarSimulator.o: CarSimulator.c
	gcc -D$(PLATFORM) -c -I../include CarSimulator.c $(CSTD)

CarSimulator: CarSimulator.o
	gcc -o CarSimulator CarSimulator.o $(FLAGS)

BrickPyramid.o: BrickPyramid.c
	gcc -D$(PLATFORM) -c -I../include BrickPyramid.c $(CSTD)

BrickPyramid: BrickPyramid.o
	gcc -D$(PLATFORM) -o BrickPyramid BrickPyramid.o $(FLAGS)

DrawTarget.o: DrawTarget.c
	gcc -D$(PLATFORM) -c -I../include DrawTarget.c $(CSTD)

DrawTarget: DrawTarget.o
	gcc -D$(PLATFORM) -o DrawTarget DrawTarget.o $(FLAGS)

CarSimulatorStructs: CarSimulatorStructs.o
	gcc -D$(PLATFORM) -o CarSimulatorStructs CarSimulatorStructs.o $(FLAGS)

CarSimulatorStructs.o: CarSimulatorStructs.c
	gcc -D$(PLATFORM) -c -I../include CarSimulatorStructs.c $(CSTD)

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
