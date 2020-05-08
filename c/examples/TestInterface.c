#include "binarypipe.h"

int main(int argc, char const *argv[]) {
   BinaryPipe binp = newBinaryPipe();

   int arr[1000][1000];
   for (size_t i = 0; i < 1000; i++)
      for (size_t j = 0; j < 1000; j++) arr[i][j] = (i * 1000) + j;

   writeBinaryPipe(binp, INT_ARR, arr, 1000000) flushBinaryPipe(binp);

   return 0;
}
