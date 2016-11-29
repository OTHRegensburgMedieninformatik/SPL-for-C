/*
 * File: CarSimulator.c
 * --------------
 * This program simulates cars on a busy street with multiple lanes.
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
const int WIDTH = 600;
const int HEIGHT = 300;
const int PAUSE_TIME = 20;

const int MAX_SPEED = 10;

GRect cars[CAR_NUM];
int carSpeeds[CAR_NUM];

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
		carSpeeds[i] = carSpeed;

		int lanePosition = createRandomLanePosition();
		GRect car = newGRect(0 - CAR_WIDTH, lanePosition, CAR_WIDTH, CAR_HEIGHT);
		setFilled(car, true);
		setFillColor(car, "CYAN");
		add(gw, car);
		cars[i] = car;
	}
}

void moveCars() {
	while(1) {
		for (int i = 0; i < CAR_NUM; i++) {
			GRect currentCar = cars[i];
			if (getX(currentCar) > WIDTH) {
				setLocation(currentCar, 0 - CAR_WIDTH, getY(currentCar));
				int carSpeed = getRandomSpeed();
				carSpeeds[i] = carSpeed;
			}
			move(currentCar, carSpeeds[i], 0);
		}
		pause(PAUSE_TIME);
	}
}

void drive() {
	drawBackground();
	moveCars();
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
