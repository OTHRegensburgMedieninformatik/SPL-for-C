#include <stdlib.h>
#include <string.h>

#include "cslib.h"
#include "strlib.h"

const string getSystemTemporaryDirectory() {
   string dir;

   dir = getenv("TEMP");
   if (dir == 0) dir = getenv("TMPDIR");
   if (dir == 0) dir = "/tmp/";
   return (const string)dir;
}

void writepixels(int **pixels, int width, int height) {
   remove(concat(getSystemTemporaryDirectory(), "splc_jbe_binarystream"));
   FILE *stream = fopen(
       concat(getSystemTemporaryDirectory(), "splc_jbe_binarystream"), "arw+");

   int *bytes = newArray(height * width, int);
   for (int i = 0; i < height; i++) {
      memcpy(&bytes[i * width], pixels[i], width * sizeof(int));
   }

   fwrite(bytes, sizeof(int), height * width, stream);
   fclose(stream);

   freeBlock(bytes);
}

int **getpixels(int width, int height) {
   FILE *stream = fopen(
       concat(getSystemTemporaryDirectory(), "splc_jbe_binarystream"), "rw+");

   int **pixels = newArray(height, int *);
   for (int i = 0; i < height; i++) pixels[i] = newArray(width, int);

   int *bytes = newArray(width * height, int);
   fread(bytes, sizeof(int), height * width, stream);
   fclose(stream);

   for (int i = 0; i < height; i++)
      memcpy(pixels[i], &bytes[i * width], width * sizeof(int));
   freeBlock(bytes);

   return pixels;
}