#include <stdio.h>
#include <math.h>
#include "cslib.h"
#include "gobjects.h"
#include "gwindow.h"
#include "run.h"

int run(){
   GWindow gw;
   GPolygon stopSign;
   double edge;
   int i;

   printf("This program draws a red octagon.\n");
   gw = newGWindow(600, 400);
   edge = 75;
   stopSign = newGPolygon();
   addVertex(stopSign, -edge / 2, edge / 2 + edge / sqrt(2.0));
   for (i = 0; i < 8; i++) {
      addPolarEdge(stopSign, edge, 45 * i);
   }
   setFilled(stopSign, true);
   setColor(stopSign, "RED");
   addAt(gw, stopSign, getWidth(gw) / 2, getHeight(gw) / 2);

   return 0;
}
