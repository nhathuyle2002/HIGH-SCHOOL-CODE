#include <iostream>
#include <stdio.h>

using namespace std;
//////

int a, b;
int res;

int gcd(int a, int b)
{
    if (b==0) return a;
    return gcd(b, a%b);
}

int main()
{
    freopen("socola.inp", "r", stdin);
    freopen("socola.out", "w", stdout);
    scanf("%d%d", &a, &b);
    int d=gcd(a, b);
    res=d*(a/d+b/d-1);
    cout << res;
}
