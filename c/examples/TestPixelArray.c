/*
 * File: TestGraphics.c
 * --------------------
 * This file tests the JBE graphics package from C.
 */

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

#include <stdio.h>
#include "cslib.h"
#include "gobjects.h"
#include "gimage.h"
#include "gwindow.h"

int checkPixelArray(int width, int height, int *const *array);

int main() {
	   GWindow gw = newGWindow(640, 480);
	   GImage image = newGImage("images/Obama.png");
	   int width = (int) getWidth(image);
	   int height = (int) getHeight(image);

	   int **array = getGPixelArray(image);
	   if(checkPixelArray(width, height, array))
		   error("Image format\n");
	   
	   addAt(gw, image, 0, 0);
	   return 0;
}


int checkPixelArray(int width, int height, int *const *array) {//check if image is normalized gray
    for(int y=0;y<height;y++) {
        for (int x = 1; x < width; x++) {
            unsigned char red, green, blue,alpha;

            red = getRed(array[y][x]);
            green = getGreen(array[y][x]);
            blue = getBlue(array[y][x]);
            alpha = getAlpha(array[y][x]);

			error("ARGB(%d,%d,%d,%d)\n",alpha,red,green,blue);
        }
    }
    return 0;
}
