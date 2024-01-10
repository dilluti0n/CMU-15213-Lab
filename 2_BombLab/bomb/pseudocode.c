#include <stdio.h>
#include <stdlib.h>

void explode_bomb()
{
    exit(1);
}

int read_six_numbers(char *input, int *a)
{
    int num = 0;
    num = sscanf(input, "%d %d %d %d %d %d", a, a + 1, a + 2, a + 3, a + 4, a + 5);
    if (num > 5)
        return num;
    else
        explode_bomb();
}

void phase_2(char *input)
{
    int a[6], ret;
    read_six_numbers(input, a);
    if (*a == 1) {
        int *i = a + 1;
        int *end = a + 6;
        do {
            ret = *(i-1);
            ret += ret;
            if (ret == *i)
                continue;
            explode_bomb();
        } while (i++ == end);
    } else {
        explode_bomb();
    }
}

main()
{
    char *input;
    phase_2(input);
}