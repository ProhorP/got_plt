#include <stdio.h>
#include "pong.h"

void ping(void) {
    printf("Ping\n");
    pong();  // вызов функции из библиотеки
    pong();  // вызов функции из библиотеки
}

int main() {
    ping();
    return 0;
}
