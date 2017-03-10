#include "gwindow.h"

GWindow gw;

int main() {

    gw = newGWindow(800, 600);
    setColorGWindow(gw, "ORANGE");
    fillOval(gw, 100, 150, 200, 200);

    return 0;
}
