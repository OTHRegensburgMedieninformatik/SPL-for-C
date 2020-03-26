/*
 * File: FilterImage.c
 * -------------------
 * Author: Hendrik Böck
 *
 */

#include "cslib.h"
#include "gobjects.h"
#include "gwindow.h"

/* Constants */

#define WINDOW_WIDTH 792
#define WINDOW_HEIGHT 249

/* Global Variables */

GWindow gw;

/* Prototypes */
GImage getRedChannel(GImage img);
GImage getGreenChannel(GImage img);
GImage getBlueChannel(GImage img);
GImage getFullAlpha(GImage img);

int main(int argc, char **argv) {
   gw = newGWindow(WINDOW_WIDTH, WINDOW_HEIGHT);

   GImage img = newGImage("images/Obama.png");
   GImage red = getRedChannel(img);
   GImage green = getGreenChannel(img);
   GImage blue = getBlueChannel(img);

   addAt(gw, img, 0, 0);
   addAt(gw, red, (int)getWidthGObject(img), 0);
   addAt(gw, green, 2 * (int)getWidthGObject(img), 0);
   addAt(gw, blue, 3 * (int)getWidthGObject(img), 0);

   return 0;
}

GImage getRedChannel(GImage img) {
   int **pixels = getPixelArray(img);
   int width = (int)getWidthGObject(img);
   int height = (int)getHeightGObject(img);

   for (int i = 0; i < height; i++) {
      for (int j = 0; j < width; j++) {
         pixels[i][j] = createRGBAPixel(getRed(pixels[i][j]), 0x0, 0x0,
                                        getAlpha(pixels[i][j]));
      }
   }

   GImage res = newGImageFromPixelArray(pixels, width, height);

   for (int i = 0; i < height; i++) freeBlock(pixels[i]);
   freeBlock(pixels);

   return res;
}

GImage getGreenChannel(GImage img) {
   int **pixels = getPixelArray(img);
   int width = (int)getWidthGObject(img);
   int height = (int)getHeightGObject(img);

   for (int i = 0; i < height; i++) {
      for (int j = 0; j < width; j++) {
         pixels[i][j] = createRGBAPixel(0x0, getGreen(pixels[i][j]), 0x0,
                                        getAlpha(pixels[i][j]));
      }
   }

   GImage res = newGImageFromPixelArray(pixels, width, height);

   for (int i = 0; i < height; i++) freeBlock(pixels[i]);
   freeBlock(pixels);

   return res;
}

GImage getBlueChannel(GImage img) {
   int **pixels = getPixelArray(img);
   int width = (int)getWidthGObject(img);
   int height = (int)getHeightGObject(img);

   for (int i = 0; i < height; i++) {
      for (int j = 0; j < width; j++) {
         pixels[i][j] = createRGBAPixel(0x0, 0x0, getBlue(pixels[i][j]),
                                        getAlpha(pixels[i][j]));
      }
   }

   GImage res = newGImageFromPixelArray(pixels, width, height);

   for (int i = 0; i < height; i++) freeBlock(pixels[i]);
   freeBlock(pixels);

   return res;
}
