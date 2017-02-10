#include "run.h"

int main() {

    int result = run();

#ifdef windows
    printf("only on windows\n");
    system("PAUSE");
#endif

    return result;
}
