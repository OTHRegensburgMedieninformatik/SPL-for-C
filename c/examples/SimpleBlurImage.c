/*************************************************************************/
/* Stanford Portable Library                                             */
/* Copyright (C) 2013 by Eric Roberts <eroberts@cs.stanford.edu>         */
/*                                                                       */
/* This program is free software: you can redistribute it and/or modify  */
/* it under the terms of the GNU General Public License as published by  */
/* the Free Software Foundation, either version 3 of the License, or     */
/* (at your option) any later version.                                   */
/*                                                                       */
/* This program is distributed in the hope that it will be useful,       */
/* but WITHOUT ANY WARRANTY; without even the implied warranty of        */
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         */
/* GNU General Public License for more details.                          */
/*                                                                       */
/* You should have received a copy of the GNU General Public License     */
/* along with this program.  If not, see <http://www.gnu.org/licenses/>. */
/*************************************************************************/

/*
 * File: SimpleBlurImage.c
 * -----------------------
 * This file is a simple implementation of a blur-function for a GImage.
 */

#include "cslib.h"
#include "gobjects.h"
#include "gwindow.h"

/*
 * CONSTANTS
 */
#define WINDOW_WIDTH 396
#define WINDOW_HEIGHT 249

/*
 * GLOBAL VARIABLES
 */
GWindow view;

/*
 * FUNCTION-PROTOTYPES
 */
void blurImage(GImage img);
int blurPixel(int x, int y, int **pixels, int widthImg, int heightImg);

/*
 * MAIN-FUNCTION (call of program)
 */
int main(int argc, char **argv) {
   view = newGWindow(WINDOW_WIDTH, WINDOW_HEIGHT);

   GImage original = newGImage("images/Obama.png");
   addAt(view, original, 0, 0);

   GImage blur = newGImage("images/Obama.png");
   blurImage(blur);
   addAt(view, blur, getWidthGObject(original), 0);

   return 0;
}

/*
 * IMPLEMENTATION OF PRE-DECLARED FUNCTIONS
 */

void blurImage(GImage img) {
   int widthImg = getWidthGObject(img);
   int heightImg = getHeightGObject(img);
   int **pixelsSrc = getPixelArray(img);
   int **pixelsTgt = newArray(heightImg, int *);
   for (int i = 0; i < heightImg; i++) pixelsTgt[i] = newArray(widthImg, int);

   for (int i = 0; i < heightImg; i++) {
      for (int j = 0; j < widthImg; j++) {
         pixelsTgt[i][j] = blurPixel(j, i, pixelsSrc, widthImg, heightImg);
      }
   }

   setPixelArray(img, pixelsTgt);

   for (int i = 0; i < heightImg; i++) {
      freeBlock(pixelsSrc[i]);
      freeBlock(pixelsTgt[i]);
   }
   freeBlock(pixelsSrc);
   freeBlock(pixelsTgt);
}

int blurPixel(int x, int y, int **pixels, int widthImg, int heightImg) {
   int red = 0, green = 0, blue = 0, alpha = 0;
   int pixelCount = 0;
   int shiftX[5] = {0, 1, 0, -1, 0};
   int shiftY[5] = {0, 0, 1, 0, -1};

   for (int i = 0; i < 5; i++) {
      int _x = x + shiftX[i];
      int _y = y + shiftY[i];
      if (_x >= 0 && _x < widthImg && _y >= 0 && _y < heightImg) {
         red += getRed(pixels[_y][_x]);
         green += getGreen(pixels[_y][_x]);
         blue += getBlue(pixels[_y][_x]);
         alpha += getAlpha(pixels[_y][_x]);
         pixelCount++;
      }
   }

   red /= pixelCount;
   green /= pixelCount;
   blue /= pixelCount;
   alpha /= pixelCount;

   return createRGBAPixel(red, green, blue, alpha);
}
