#include <iostream>
#include <stdio.h>
#define For(i,a,b) for(int i=a; i<=b; i++)

using namespace std;
long long a, b, k;

long long mul(long long x, long long y)
{
    long long ans = 0;
    while (x)
    {
        if (x & 1) ans = (ans + y) % b;
        x >>= 1;
        y = (y+y) % b;
    }
    return ans;
}

long long pow(long long x, long long y)
{
    if (y == 0) return 1;
    long long t = pow(x, y/2);
    t = mul(t, t);
    if (y & 1 == 1) t = mul(t, x);
    return t;
}
int main()
{
    freopen("DIGIT.INP","r",stdin);
    freopen("DIGIT.OUT","w",stdout);
    scanf("%lld%lld%lld", &a, &b, &k);
    long long kq = mul(a, pow(10, k-1));
    kq = (unsigned long long)10*kq/b;
    printf("%lld", kq);
    return 0;
}
