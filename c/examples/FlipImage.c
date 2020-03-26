/*
 * File: FlipImage.c
 * -----------------
 * This program attempts to flip an image.
 *
 * Author: Hendrik Böck
 *
 */

#include "cslib.h"
#include "gobjects.h"
#include "gwindow.h"

/* Constants */

#define WINDOW_WIDTH 594
#define WINDOW_HEIGHT 447

/* Global Variables */

GWindow gw;

/* Prototypes */

GImage flipImageHorizontally(GImage original);
GImage flipImageVertically(GImage original);
GImage rotateImage90(GImage original);
GImage rotateImage270(GImage original);
void paintTitleForGImage(GImage image, string title);

int main(int argc, char **argv) {
   gw = newGWindow(WINDOW_WIDTH, WINDOW_HEIGHT);

   GImage original = newGImage("images/Obama.png");
   addAt(gw, original, 0, 0);
   paintTitleForGImage(original, "original");

   GImage flip_horizontally = flipImageHorizontally(original);
   addAt(gw, flip_horizontally, getWidthGObject(original), 0);
   paintTitleForGImage(flip_horizontally, "flip_horizontally");

   GImage flip_vertically = flipImageVertically(original);
   addAt(gw, flip_vertically,
         getWidthGObject(original) + getWidthGObject(flip_horizontally), 0);
   paintTitleForGImage(flip_vertically, "flip_vertically");

   GImage rotate_90 = rotateImage90(original);
   addAt(gw, rotate_90, 0, getHeightGObject(original));
   paintTitleForGImage(rotate_90, "rotate_90");

   GImage rotate_270 = rotateImage270(original);
   addAt(gw, rotate_270, getWidthGObject(rotate_90), getHeightGObject(original));
   paintTitleForGImage(rotate_270, "rotate_270");

   return 0;
}

/*
 * Implementation of Prototypes
 */

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

   GImage res = newGImageFromPixelArray(pixels, width, height);

   for (int i = 0; i < height; i++) freeBlock(pixels[i]);
   freeBlock(pixels);

   return res;
}

GImage flipImageVertically(GImage original) {
   int height = (int)getHeightGObject(original);
   int width = (int)getWidthGObject(original);
   int **pixels = getPixelArray(original);

   for (int j = 0; j < width; j++) {
      for (int i = 0; i < height / 2; i++) {
         int tmp = pixels[i][j];
         pixels[i][j] = pixels[height - 1 - i][j];
         pixels[height - 1 - i][j] = tmp;
      }
   }

   GImage res = newGImageFromPixelArray(pixels, width, height);

   for (int i = 0; i < height; i++) freeBlock(pixels[i]);
   freeBlock(pixels);

   return res;
}

GImage rotateImage90(GImage original) {
   int height = (int)getHeightGObject(original);
   int width = (int)getWidthGObject(original);
   int **pixels = getPixelArray(original);

   int **new_pixels = newArray(width, int *);
   for (int i = 0; i < width; i++) new_pixels[i] = newArray(height, int);

   for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) new_pixels[i][j] = pixels[j][i];
   }

   GImage res = newGImageFromPixelArray(new_pixels, height, width);

   for (int i = 0; i < height; i++) freeBlock(pixels[i]);
   freeBlock(pixels);
   for (int i = 0; i < width; i++) freeBlock(new_pixels[i]);
   freeBlock(new_pixels);

   return res;
}

GImage rotateImage270(GImage original) {
   return flipImageHorizontally(rotateImage90(original));
}

void paintTitleForGImage(GImage image, string title) {
   GLabel res = newGLabel(title);
   setFont(res, "SansSerif-16");
   setColorGObject(res, "RED");
   addAt(gw, res, getXGObject(image) + 10,
         getYGObject(image) + getFontAscent(res) + 10);
}