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
const int HEIGHT = 800;

const int START_DIAMETER = 30;
const int NUM_TARGETS = 15;
const string EVEN_COLOR = "WHITE";
const string UNEVEN_COLOR = "RED";

GWindow gw;

/* Prototypes */

void setupCanvas();
void drawTarget();
void drawOneRing(int ringNum, string ringColor);

int main() {
	setupCanvas();
	drawTarget();
	return 0;
}

void drawTarget() {
	string ringColor;
	int ringNum;
	for (ringNum = NUM_TARGETS; ringNum >= 1; ringNum--) {
		if (ringNum % 2 == 0) {
			ringColor = EVEN_COLOR;
		} else {
			ringColor = UNEVEN_COLOR;
		}
		drawOneRing(ringNum, ringColor);
	}
}

void drawOneRing(int ringNum, string ringColor) {
	int diameter = ringNum * START_DIAMETER;
	int offset = diameter / 2;
	GOval ring = newGOval(WIDTH / 2 - offset, HEIGHT / 2 - offset, diameter, diameter);
	setFilled(ring, true);
	setFillColor(ring, ringColor);
	draw(gw, ring);
}

void setupCanvas() {
	gw = newGWindow(WIDTH, HEIGHT);
}
