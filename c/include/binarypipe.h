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
 * File: binarypipe.h
 * Author: Hendrik Böck <uronaadp@163.com>
 * ---------------------------------------
 * This interface defines a binary Pipe, which can send big chunks of data
 * fast from C to Java.  The cost of the interface is, that the receiving
 * language must know, when to look for the send data.
 */

#ifndef _binarypipe_h
#define _binarypipe_h

#include <stdio.h>

#include "map.h"
#include "strlib.h"

#define BINPIPE_FILE "splc_jbe_binarypipe"

/**
 * Type: type
 * ----------
 * This type represents the variable-types, which can be pushed to the
 * <code>BinaryPipe</code> or read from it.  The types are the following:
 * <code>{ BYTE, CHAR, INT, LONG, LONG_LONG, FLOAT, DOUBLE, STRING_, BYTE_ARR,
 * CHAR_ARR, INT_ARR, LONG_ARR, LONG_LONG_ARR, FLOAT_ARR, DOUBLE_ARR }</code>
 */
typedef enum type {
   BYTE,
   CHAR,
   INT,
   LONG,
   LONG_LONG,
   FLOAT,
   DOUBLE,
   STRING_,
   BYTE_ARR,
   CHAR_ARR,
   INT_ARR,
   LONG_ARR,
   LONG_LONG_ARR,
   FLOAT_ARR,
   DOUBLE_ARR
} type;

/**
 * Type: byte
 * ----------
 * This type represents a binary <code>byte</code>.
 */
typedef char byte;

/**
 * Type: BinaryStream
 * ------------------
 * This type represents the file of the <code>BinaryPipe</code>, which is
 * located at <code>${SystemTemporaryDirectory}/splc_jbe_binarystream</code>.
 */
typedef FILE *BinaryStream;

/**
 * Type: BinaryPipeObject
 * ----------------------
 * The type <code>BinaryPipeObject</code> is a list item, which is used
 * to store the <code>contents</code>, which should be written to the
 * <code>BinaryPipe</code>.  To write the objects to the <code>BinaryPipe</code>
 * the function <code>flushBinaryPipe(BinaryPipe bp)</code> has to be
 * called.
 */
typedef struct BinaryPipeObjectCDT *BinaryPipeObject;

/**
 * Type: BinaryPipe
 * ----------------
 * The <code>BinaryPipe</code> is used to send binary-data between C and Java.
 * However the Pipe is faster, than the Standard-Pipe, the Standard-pipe
 * provides more security against dataloss and is having a dedicated clock for
 * command-scanning.  The <code>BinaryPipe</code> should be used carefully and
 * only to send big chunks of data between C and Java;
 */
typedef struct BinaryPipeCDT *BinaryPipe;

/**
 * Function: getSystemTemporaryDirectory
 * Usage: tempDir = getSystemTemporaryDirectory()
 * ----------------------------------------------
 * Returns the path to the systemwide Temporary-Directory as a
 * <code>const string</code>.
 */
const string getSystemTemporaryDirectory();

/**
 * Function: openBinaryStream
 * Usage: openBinaryStream(bp)
 * ---------------------------
 * Opens the <code>BinaryStream</code> on a <code>BinaryPipe bp</code>.
 */
void openBinaryStream(BinaryPipe bp);

/**
 * Function: closeBinaryStream
 * Usage: closeBinaryStream(bp)
 * ----------------------------
 * Closes the <code>BinaryStream</code> on a <code>BinaryPipe bp</code>.
 */
void closeBinaryStream(BinaryPipe bp);

/**
 * Function: writeBinaryStream
 * Usage: writeBinaryStream(bp, bytes, size)
 * -----------------------------------------
 * Writes the array <code>bytes</code> to the <code>BinaryStream</code>
 * of a <code>BinaryPipe</code> in the size of the paramter
 * <code>size</code>.
 */
void writeBinaryStream(BinaryPipe bp, byte *bytes, size_t size);

/**
 * Function: readBinaryStream
 * Usage: bin_data = readBinaryStream(bp, size)
 * --------------------------------------------
 * Reads the raw <code>BinaryStream</code> of a <code>BinaryPipe</code>
 * in a size determined by the parameter <code>size</code>.
 */
byte *readBinaryStream(BinaryPipe bp, size_t size);

/**
 * Function: getPathBinaryStream
 * Usage: path = getPathBinaryStream(bp)
 * -------------------------------------
 * Returns the path to the <code>BinaryStream</code>-file as a
 * <code>const string</code>.
 */
const string getPathBinaryStream(BinaryPipe bp);

/**
 * Function: newBinaryPipeObject
 * Usage: bp_obj = newBinaryPipeObject(contents, contents_size)
 * ------------------------------------------------------------
 * Allocates a new List-object for a binary pipe.
 */
BinaryPipeObject newBinaryPipeObject(byte *contents, int contents_size);

/**
 * Function: freeBinaryPipeObject
 * Usage: freeBinaryPipeObject(bp_obj)
 * -----------------------------------
 * Frees the specific List-object for a binary pipe.
 */
void freeBinaryPipeObject(BinaryPipeObject bp_obj);

/**
 * Function: newBinaryPipe
 * Usage: bp = newBinaryPipe()
 * ---------------------------
 * Allocates a new binary pipe.
 */
BinaryPipe newBinaryPipe();

/**
 * Function: freeBinaryPipe
 * Usage: freeBinaryPipe(bp)
 * -------------------------
 * Frees the specific binary pipe.
 */
void freeBinaryPipe(BinaryPipe bp);

/**
 * Function: putBinaryPipe
 * Usage: putBinaryPipe(bp, bp_obj)
 * --------------------------------
 * Inserts a <code>BinaryPipeObject</code> at the end of the internal
 * Caching-List of a <code>BinaryPipe</code>.  Returns a reference to
 * the <code>BinaryPipe bp</code>.
 */
BinaryPipe putBinaryPipe(BinaryPipe bp, BinaryPipeObject bp_obj);

/**
 * Function: clearCacheBinaryPipe
 * Usage: clearCacheBinaryPipe(bp)
 * -------------------------------
 * Clears out the Caching-List of a <code>BinaryPipe bp</code>.
 */
void clearCacheBinaryPipe(BinaryPipe bp);

/*
 * -----------   BEGIN FUNCTION 'writeBinaryPipe'   -----------
 */

void writeBinaryPipe_BASE(BinaryPipe bp, type t, void *contents, int arr_len);

typedef struct {
   BinaryPipe bp;
   type t;
   void *contents;
   int arr_len;
} writeBinaryPipe_ARGS;

void writeBinaryPipe_VAR(writeBinaryPipe_ARGS in);

/**
 * Function: writeBinaryPipe
 * Usage: writeBinaryPipe(bp, TYPE, contents, (optional)arr_len)
 * -------------------------------------------------------------
 * Writes a object to the internal Caching-List of a <code>BinaryPipe
 * bp</code>.  Parameter <code>arr_len</code> has just to be set, if
 * <code>TYPE</code> defines an array, otherwise will it be set to
 * <code>-1</code>.
 */
#define writeBinaryPipe(...) \
   writeBinaryPipe_VAR((writeBinaryPipe_ARGS){__VA_ARGS__});

/*
 * -----------   END FUNCTION 'writeBinaryPipe'   -----------
 */

/**
 * Function: readBinaryPipe
 * Usage: results = readBinaryPipe(bp, TYPE)
 * -----------------------------------------
 * Reads one object from the type <code>TYPE</code> from the
 * <code>BinaryPipe bp</code>.
 */
Map readBinaryPipe(BinaryPipe bp, type t);

/**
 * Function: flushBinaryPipe
 * Usage: flushBinaryPipe(bp)
 * --------------------------
 * Flushes the contents of the objects inside the binary-pipe's
 * Caching-List onto the file of the <code>BinaryStream</code>.
 */
void flushBinaryPipe(BinaryPipe bp);

#endif /* _binarypipe_h */