/*
 * File: gobjects.h
 * ----------------
 * This interface exports a hierarchy of graphical shapes based on
 * the model developed for the ACM Java Graphics.
 * <include src="pictures/TypeHierarchies/GObjectHierarchy.html">
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

#ifndef _gimage_h
#define _gimage_h

#ifndef _gobjects_h

typedef void *GObject;

#endif


/**
 * Type: GImage
 * ------------
 * This subtype represents an image from a file.  For example, the
 * following code adds a <code>GImage</code> containing the Stanford
 * tree at the center of the window, assuming that the image file
 * <code>StanfordTree.png</code> exists, either in the current
 * directory or an <code>images</code> subdirectory:
 *
 *<pre>
 *    main() {
 *       printf("This program draws the Stanford tree.\n");
 *       GWindow gw = newGWindow(600, 400);
 *       GImage tree = newGImage("StanfordTree.png");
 *       double x = (getWidth(gw) - getWidth(tree)) / 2;
 *       double y = (getHeight(gw) - getHeight(tree)) / 2;
 *       add(gw, tree, x, y);
 *    }
 *</pre>
 */

 typedef GObject GImage;
 
 /**
  * Function: newGImage
  * Usage: GImage image = newGImage(filename);
  * ------------------------------------------
  * Constructs a new image by loading the image from the specified
  * file, which is either in the current directory or a subdirectory named
  * <code>images</code>.  The upper left corner of the image is positioned
  * at the origin.
  */
 
 GImage newGImage(string filename);
 
 
 /**
  * Function: getGImagePath
  */
 string getGImagePath(GImage image);
 
 //Start
 
 /**
  * Function getGPixelArray
  * Usage: GPixelArray pix = getGPixelArray(image);
  * -----------------------------------------------
  */
 int ** getGPixelArray(GImage iamge);
 
 
 GImage updateGImage(GWindow gw, GImage image, int ** array);
 unsigned int setRed(int rgba_value, unsigned char value);
 unsigned int setGreen(int rgba_value, unsigned char value);
 unsigned int setBlue(int rgba_value, unsigned char value);
 unsigned int setAlpha(int rgba_value, unsigned char value);
 unsigned char getRed(unsigned int rgba_value);
 unsigned char getGreen(unsigned int rgba_value);
 unsigned char getBlue(unsigned int rgba_value);
 unsigned char getAlpha(unsigned int rgba_value);
 unsigned int getRGBValue(unsigned int rgba_value);

 #endif