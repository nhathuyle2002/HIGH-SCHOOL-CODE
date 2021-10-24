#include <iostream>
#include <stdio.h>

using namespace std;

bool process()
{
    int x, y, z, a, b, c;
    scanf("%d%d%d%d%d%d", &x, &y, &z, &a, &b, &c);
    if (a<x) return 0; else a-=x;
    if (a+b<y) return 0; else c-=y;
    return a+b+c>=z;
}

int main()
{
    if (process()) cout << "YES"; else cout << "NO";
}
