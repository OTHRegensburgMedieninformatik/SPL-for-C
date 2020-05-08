/* --------------------   OWN HEADER   --------------------- */
#include "binarypipe.h"

/* -------------------   GLOBAL HEADER   ------------------- */
#include <stdlib.h>
#include <string.h>

/* --------------------   LOCAL HEADER   ------------------- */
#include "cslib.h"
#include "vector.h"

/* ----------------------   STRUCTS   ---------------------- */

struct BinaryPipeObjectCDT {
   byte *contents;
   int size;
};

struct BinaryPipeCDT {
   BinaryStream stream;
   string stream_path;
   Vector cache;
   int size;
};

/* -------------------   BINARY_STREAM   ------------------- */

const string getSystemTemporaryDirectory() {
   string dir;

   dir = getenv("TEMP");
   if (dir == 0) dir = getenv("TMPDIR");
   if (dir == 0) dir = "/tmp/";
   return (const string)dir;
}

void openBinaryStream(BinaryPipe bp) {
   bp->stream = (BinaryStream)fopen(bp->stream_path, "rw+");
}

void closeBinaryStream(BinaryPipe bp) {
   fclose((FILE *)bp->stream);
   bp->stream = NULL;
}

void writeBinaryStream(BinaryPipe bp, byte *bytes, size_t size) {
   if (bp->stream == NULL) openBinaryStream(bp);
   // fwrite(bytes, sizeof(byte), size, (FILE *)bp->stream);
   for (size_t i = 0; i < size; i++) fputc(bytes[i], bp->stream);
}

byte *readBinaryStream(BinaryPipe bp, size_t size) {
   byte *buffer = newArray(size, byte);

   if (bp->stream == NULL) openBinaryStream(bp);
   fread(buffer, sizeof(byte), size, (FILE *)bp->stream);
   return buffer;
}

const string getPathBinaryStream(BinaryPipe bp) {
   return (const string)bp->stream_path;
}

/* -----------------   BINARY_PIPE_OBJECT   ---------------- */

BinaryPipeObject newBinaryPipeObject(byte *contents, int contents_size) {
   BinaryPipeObject bp_obj = newBlock(BinaryPipeObject);

   bp_obj->contents = contents;
   bp_obj->size = contents_size;
   return bp_obj;
}

void freeBinaryPipeObject(BinaryPipeObject bp_obj) {
   freeBlock(bp_obj->contents);
   freeBlock(bp_obj);
}

/* --------------------   BINARY_PIPE   -------------------- */

BinaryPipe newBinaryPipe() {
   BinaryPipe bp = newBlock(BinaryPipe);

   bp->stream = NULL;
   bp->stream_path =
       concat(getSystemTemporaryDirectory(), "splc_jbe_binarystream");
   bp->cache = newVector();
   bp->size = 0;
   return bp;
}

void freeBinaryPipe(BinaryPipe bp) {
   for (size_t i = 0; i < sizeVector(bp->cache); i++)
      freeBlock(getVector(bp->cache, i));
   freeVector(bp->cache);
   closeBinaryStream(bp->stream);
   // freeBlock(bp->stream_path);  // TODO: may cause issue
   freeBlock(bp);
}

BinaryPipe putBinaryPipe(BinaryPipe bp, BinaryPipeObject bp_obj) {
   bp->size += bp_obj->size;
   addVector(bp->cache, bp_obj);
}

void clearCacheBinaryPipe(BinaryPipe bp) {
   for (size_t i = 0; i < sizeVector(bp->cache); i++)
      freeBlock(getVector(bp->cache, i));
   clearVector(bp->cache);
   bp->size = 0;
}

void writeBinaryPipe_VAR(writeBinaryPipe_ARGS in) {
   BinaryPipe bp_out = in.bp;
   type t_out = in.t;
   void *contents_out = in.contents;
   int arr_len_out = in.arr_len ? in.arr_len : -1;

   return writeBinaryPipe_BASE(bp_out, t_out, contents_out, arr_len_out);
}

void writeBinaryPipe_BASE(BinaryPipe bp, type t, void *contents, int arr_len) {
   BinaryPipeObject bp_obj;
   int pkg_size = 0;

   if (arr_len >= 0) writeBinaryPipe(bp, INT, &arr_len);
   switch (t) {
      case BYTE:
         pkg_size = sizeof(byte);
         break;
      case CHAR:
         pkg_size = sizeof(char);
         break;
      case INT:
         pkg_size = sizeof(int);
         break;
      case LONG:
         pkg_size = sizeof(long);
         break;
      case LONG_LONG:
         pkg_size = sizeof(long long);
         break;
      case FLOAT:
         pkg_size = sizeof(float);
         break;
      case DOUBLE:
         pkg_size = sizeof(double);
         break;
      case STRING_:
         pkg_size = stringLength((string)contents) * sizeof(char);
         break;
      case BYTE_ARR:
         pkg_size = arr_len * sizeof(byte);
         break;
      case CHAR_ARR:
         pkg_size = arr_len * sizeof(char);
         break;
      case INT_ARR:
         pkg_size = arr_len * sizeof(int);
         break;
      case LONG_ARR:
         pkg_size = arr_len * sizeof(long);
         break;
      case LONG_LONG_ARR:
         pkg_size = arr_len * sizeof(long long);
         break;
      case FLOAT_ARR:
         pkg_size = arr_len * sizeof(float);
         break;
      case DOUBLE_ARR:
         pkg_size = arr_len * sizeof(double);
         break;
      default:
         pkg_size = 0;
         break;
   }
   /*
   byte *_contents = newArray(pkg_size, byte);
   memcpy(_contents, contents, pkg_size);
   bp_obj = newBinaryPipeObject(_contents, pkg_size);
   putBinaryPipe(bp, bp_obj);
   */
   writeBinaryStream(bp, contents, pkg_size);
}

Map readBinaryPipe(BinaryPipe bp, type t) {
   int *count;
   void *data;
   int type_size;
   Map result = newMap();

   switch (t) {
      case BYTE:
         *count = 1;
         type_size = sizeof(byte);
         break;
      case CHAR:
         *count = 1;
         type_size = sizeof(char);
         break;
      case INT:
         *count = 1;
         type_size = sizeof(int);
         break;
      case LONG:
         *count = 1;
         type_size = sizeof(long);
         break;
      case LONG_LONG:
         *count = 1;
         type_size = sizeof(long);
         break;
      case FLOAT:
         *count = 1;
         type_size = sizeof(float);
         break;
      case DOUBLE:
         *count = 1;
         type_size = sizeof(double);
         break;
      case STRING_:
         count = (int *)readBinaryStream(bp, sizeof(int));
         type_size = sizeof(char);
         break;
      case BYTE_ARR:
         count = (int *)readBinaryStream(bp, sizeof(int));
         type_size = sizeof(byte);
         break;
      case CHAR_ARR:
         count = (int *)readBinaryStream(bp, sizeof(int));
         type_size = sizeof(char);
         break;
      case INT_ARR:
         count = (int *)readBinaryStream(bp, sizeof(int));
         type_size = sizeof(int);
         break;
      case LONG_ARR:
         count = (int *)readBinaryStream(bp, sizeof(int));
         type_size = sizeof(long);
         break;
      case LONG_LONG_ARR:
         count = (int *)readBinaryStream(bp, sizeof(int));
         type_size = sizeof(long long);
         break;
      case FLOAT_ARR:
         count = (int *)readBinaryStream(bp, sizeof(int));
         type_size = sizeof(float);
         break;
      case DOUBLE_ARR:
         count = (int *)readBinaryStream(bp, sizeof(int));
         type_size = sizeof(double);
         break;
      default:
         *count = 0;
         type_size = 0;
         break;
   }
   putMap(result, "count", count);
   putMap(result, "data", readBinaryStream(bp, (*count) * type_size));

   return result;
}

void flushBinaryPipe(BinaryPipe bp) {
   /*
   BinaryPipeObject tmp;

   for (size_t i = 0; i < sizeVector(bp->cache); i++) {
      tmp = getVector(bp->cache, i);
      writeBinaryStream(bp, tmp->contents, tmp->size);
   }
   */
   closeBinaryStream(bp);

   clearCacheBinaryPipe(bp);
}