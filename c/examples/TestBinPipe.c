#include "binpipe.h"
#include "cslib.h"
#include "gwindow.h"
#include "platform.h"

#define ARR_SIZE_1 50

int main(int argc, char const *argv[]) {
   // initBinaryPipe();

   int **arr = (int **)malloc(ARR_SIZE_1 * sizeof(int *));
   for (int i = 0; i < ARR_SIZE_1; i++)
      arr[i] = (int *)malloc(ARR_SIZE_1 * sizeof(int));

   for (int i = 0; i < ARR_SIZE_1; i++)
      for (int j = 0; j < ARR_SIZE_1; j++) arr[i][j] = j;

   writepixels(arr, ARR_SIZE_1, ARR_SIZE_1);

   int **pxl = getpixels(ARR_SIZE_1, ARR_SIZE_1);
   for (int i = 0; i < ARR_SIZE_1; i++) {
      for (int j = 0; j < ARR_SIZE_1; j++) printf("%d, ", pxl[i][j]);
      printf("\n");
   }

   return 0;
}
