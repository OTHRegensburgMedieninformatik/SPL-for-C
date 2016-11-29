/*
 * File: DrawTarget.c
 * --------------
 * This program draws a dart target.
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

int main() {
	setupCanvas();
	/* TODO */
	return 0;
}

void setupCanvas() {
	gw = newGWindow(WIDTH, HEIGHT);
}
