#ifndef binpipe_h_
#define binpipe_h_

#include <stdlib.h>
#include <string.h>

#include "cslib.h"
#include "strlib.h"

const string getSystemTemporaryDirectory();

void writepixels(int **pixels, int width, int height);

int **getpixels(int width, int height);

#endif