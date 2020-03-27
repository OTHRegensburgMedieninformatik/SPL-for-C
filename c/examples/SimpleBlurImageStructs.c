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
 * File: SimpleBlurImageStructs.c
 * ------------------------------
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
 * STRUCTS
 */
struct _PixelRGBA {
   int red;
   int green;
   int blue;
   int alpha;
};
typedef struct _PixelRGBA *PixelRGBA;

/*
 * FUNCTION-PROTOTYPES
 */
void blurImage(GImage img);
int blurPixel(int x, int y, int **pixels, int widthImg, int heightImg);
PixelRGBA mergePixelRGBA(PixelRGBA *arr, int len);
PixelRGBA getPixelRGBA(int x, int y, int **pixels, int widthImg, int heightImg);

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
   PixelRGBA arr[5];

   arr[0] = getPixelRGBA(x, y, pixels, widthImg, heightImg);
   arr[1] = getPixelRGBA(x + 1, y, pixels, widthImg, heightImg);
   arr[2] = getPixelRGBA(x, y + 1, pixels, widthImg, heightImg);
   arr[3] = getPixelRGBA(x - 1, y, pixels, widthImg, heightImg);
   arr[4] = getPixelRGBA(x, y - 1, pixels, widthImg, heightImg);

   PixelRGBA merge = mergePixelRGBA(arr, 5);
   int res =
       createRGBAPixel(merge->red, merge->green, merge->blue, merge->alpha);

   for (int i = 0; i < 5; i++) {
      if (arr[i] != NULL) freeBlock(arr[i]);
   }
   freeBlock(merge);

   return res;
}

PixelRGBA mergePixelRGBA(PixelRGBA *arr, int len) {
   long red = 0, green = 0, blue = 0, alpha = 0;
   int pixelCount = 0;

   for (int i = 0; i < len; i++) {
      if (arr[i] != NULL) {
         red += arr[i]->red;
         green += arr[i]->green;
         blue += arr[i]->blue;
         alpha += arr[i]->alpha;
         pixelCount++;
      }
   }

   PixelRGBA pxl = newBlock(PixelRGBA);
   pxl->red = red / pixelCount;
   pxl->green = green / pixelCount;
   pxl->blue = blue / pixelCount;
   pxl->alpha = alpha / pixelCount;

   return pxl;
}

PixelRGBA getPixelRGBA(int x, int y, int **pixels, int widthImg,
                       int heightImg) {
   if (y >= 0 && y < heightImg) {
      if (x >= 0 && x < widthImg) {
         PixelRGBA pxl = newBlock(PixelRGBA);
         pxl->red = getRed(pixels[y][x]);
         pxl->green = getGreen(pixels[y][x]);
         pxl->blue = getBlue(pixels[y][x]);
         pxl->alpha = getAlpha(pixels[y][x]);
         return pxl;
      }
   }
   return NULL;
}
