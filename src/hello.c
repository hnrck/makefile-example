#include "hello.h"

#include <stdio.h>

void hello(const char* message) {
    fprintf(stdout, "Hello, %s!\n", message);
}
