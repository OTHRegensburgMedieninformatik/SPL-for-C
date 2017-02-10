#include "cslib.h"
#include "gobjects.h"
#include "gwindow.h"
#include "run.h"

int run() {
    double width, height;
    GWindow gw;

    gw = newGWindow(480,320);
    width = getWidth(gw);
    height = getHeight(gw);

    setColor(gw, "GREEN");
    fillRect(gw, width / 8, height / 8, (width / 8)*6, (height / 8)*6);
    setColor(gw, "RED");
    fillOval(gw, width / 4, height / 4, width / 3, height / 3);

    return 0;
}
