#include "gwindow.h"
#include "gobjects.h"

GWindow gw;
GLabel label;

int main()
{

    gw = newGWindow(800, 600);
    setColorGWindow(gw, "BLACK");

    GRect gre = newGRect(0, 0, 100, 100);
    setFilled(gre, true);
    setColor(gre, "BLACK");
    add(gw, gre);

    label = newGLabel("Hallo");
    setFont(label, "SansSerif-32");
    setLocation(label, 200, 200);
    // setColor(label, "BLACK");
    add(gw, label);

    return 0;
}