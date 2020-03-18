/*
 * File: FlipImage.c
 * --------------
 * This program attempts to flip an image.
 *
 * Author: Hendrik Böck
 * 
 */

#include "cslib.h"
#include "gobjects.h"
#include "gwindow.h"

/* Constants */

#define WINDOW_WIDTH 740
#define WINDOW_HEIGHT 400

/* Global Variables */

GWindow gw;

/* Prototypes */
GImage flipImageHorizontally(GImage original);

int main(int argc, char **argv) {
   gw = newGWindow(WINDOW_WIDTH, WINDOW_HEIGHT);

   GImage image = newGImage("images/Obama.png");
   addAt(gw, image, 0, 0);

   GImage image_reverse = flipImageHorizontally(image);
   addAt(gw, image_reverse, (int)getWidthGObject(image), 0);

   return 0;
}

GImage flipImageHorizontally(GImage original) {
   int height = (int)getHeightGObject(original);
   int width = (int)getWidthGObject(original);
   int **pixels = getPixelArray(original);

   for (int i = 0; i < height; i++) {
      for (int j = 0; j < width / 2; j++) {
         int tmp = pixels[i][j];
         pixels[i][j] = pixels[i][width - 1 - j];
         pixels[i][width - 1 - j] = tmp;
      }
   }

   return newGImageFromPixelArray(pixels, width, height);
}
