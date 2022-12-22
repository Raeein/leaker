#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {

    printf("Sample args: %s\n", argv[1]);

    int *num = malloc(sizeof(int));
    printf("Life is good. %p\n", num);
    
    return 0;
}