#include <iostream>
#include <stdio.h>

using namespace std;

int main()
{
    int n, v;
    scanf("%d%d", &n, &v);
    int res;
    if (n-v<=1) res=n-1; else res=v+(n-v+2)*(n-v-1)/2;
    cout << res;
}
