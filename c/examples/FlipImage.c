/*
 * File: FlipImage.c
 * --------------
 * This program attempts to flip an image.
 *
 * Todo:
 * However this is currently not possible, since there is no back channel from the Java
 * backend that gives access to the underlying pixel array. Also, a channel to the backend
 * would need to be implemented to store the array back in the image in the backend.
 */

#include <math.h>
#include <stdio.h>
#include "cslib.h"
#include "gmath.h"
#include "gobjects.h"
#include "gimage.h"
#include "gevents.h"
#include "gwindow.h"

/* Constants */

#define FLAG_WIDTH 740
#define FLAG_HEIGHT 400
#define FIELD_FRACTION 0.40
#define STAR_FRACTION 0.40

/* Prototypes */

void drawImage(GWindow gw);

int main() {
   GWindow gw = newGWindow(FLAG_WIDTH, FLAG_HEIGHT);
   drawImage(gw);
   return 0;
}


void drawImage(GWindow gw) {
   GImage obama = newGImage("images/Obama.png");
   addAt(gw, obama, 0, 0);
}
