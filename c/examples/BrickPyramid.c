/*
 * File: BrickPyramid.c
 * --------------
 * This program draws a pyramid of bricks.
 *
 * Author: Markus Heckner
 *
 */

#include <stdio.h>
#include "cslib.h"
#include "gobjects.h"
#include "gwindow.h"

/* Constants */

const int WIDTH = 800;
const int HEIGHT = 300;

const int BRICK_WIDTH = 30;
const int BRICK_HEIGHT = 12;
const int BRICKS_IN_BASE = 14;
const string BRICK_COLOR = "ORANGE";

GWindow gw;

/* Prototypes */

void setupCanvas();
void drawBricks();
void drawLineOfBricks(int brickLine, int startYPos);

int main() {
	setupCanvas();
	drawBricks();
	return 0;
}

void setupCanvas() {
	gw = newGWindow(WIDTH, HEIGHT);
	pause(1000);
}

void drawBricks() {
	int startYPos = HEIGHT - BRICK_HEIGHT;
	int numBrickLine;
	for(numBrickLine = 0; numBrickLine < BRICKS_IN_BASE; numBrickLine++) {
		drawLineOfBricks(numBrickLine, startYPos);
		startYPos -= BRICK_HEIGHT;
	}
}

void drawLineOfBricks(int brickLine, int startYPos) {
	int numBricks = BRICKS_IN_BASE - brickLine;
	int lineWidth = numBricks * BRICK_WIDTH;
	int startXPos = WIDTH / 2 - (lineWidth / 2);

	int i;
	for (i = 0; i < numBricks; i++) {
		GRect brick = newGRect(startXPos, startYPos, BRICK_WIDTH, BRICK_HEIGHT);
		setFilled(brick, true);
		setFillColor(brick, BRICK_COLOR);
		draw(gw, brick);
		startXPos += BRICK_WIDTH;
	}
}
