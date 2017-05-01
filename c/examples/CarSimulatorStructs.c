/*
 * File: CarSimulator.c
 * --------------
 * This program simulates cars on a busy street with multiple lanes.
 * This version uses structs, but is still buggy (blinking cars in animation)
 *
 * Author: Markus Heckner
 *
 */

#include <math.h>
#include <stdio.h>
#include "cslib.h"
#include "gmath.h"
#include "gobjects.h"
#include "gevents.h"
#include "gwindow.h"

/* Constants */

#define CAR_NUM 100
const int CAR_WIDTH = 15;
const int CAR_HEIGHT = 5;
const string BG_COLOR = "BLACK";
const string CAR_COLOR = "CYAN";
const int WIDTH = 600;
const int HEIGHT = 300;
const int PAUSE_TIME = 20;

const int MAX_SPEED = 10;

typedef struct {
	int xPos;
	int yPos;
	int width;
	int height;
	int speed;
	char *color;
} *car;

car cars[CAR_NUM];

GWindow gw;

/* Prototypes */

void setupCanvas();
void setupCars();
void drive();
void drawBackground();
void drawCars();
int createRandomLanePosition();
void moveCars();
int getRandomSpeed();

int main() {
	setupCanvas();
	setupCars();
	drive();
	return 0;
}

void setupCanvas() {
	gw = newGWindow(WIDTH, HEIGHT);
}

void setupCars() {
	for (int i = 0; i < CAR_NUM; i++) {
		int carSpeed = getRandomSpeed();
		int lanePosition = createRandomLanePosition();

		car newCar = malloc(sizeof(*newCar));
		newCar->xPos = 0 - CAR_WIDTH;
		newCar->yPos = lanePosition;
		newCar->width = CAR_WIDTH;
		newCar->height = CAR_HEIGHT;
		newCar->color = CAR_COLOR;
		newCar->speed = carSpeed;

		cars[i] = newCar;
	}
}

void drive() {
	while(1) {
		for (int i = 0; i < CAR_NUM; i++) {
			car currentCar = cars[i];
			if (currentCar->xPos > WIDTH) {
				currentCar->xPos = 0 - currentCar->width;
				int carSpeed = getRandomSpeed();
				currentCar->speed = carSpeed;
			}
			currentCar->xPos += currentCar->speed;
		}
		drawBackground();
		drawCars();
		pause(PAUSE_TIME);
	}
}

void drawCars() {
	for (int i = 0; i < CAR_NUM; i++) {
		car currentCar = cars[i];
		setColor(gw, currentCar->color);
		fillRect(gw, currentCar->xPos, currentCar->yPos, currentCar->width, currentCar->height);
	}
}

void drawBackground() {
	GRect background = newGRect(0, 0, WIDTH, HEIGHT);
	setFilled(background, true);
	setFillColor(background, BG_COLOR);
	draw(gw, background);
}

int createRandomLanePosition() {
	int numLanes = HEIGHT / CAR_HEIGHT;
	int laneNum = rand() % numLanes;
	return laneNum * CAR_HEIGHT;
}

int getRandomSpeed() {
	return (rand() % MAX_SPEED) + 1;
} 
