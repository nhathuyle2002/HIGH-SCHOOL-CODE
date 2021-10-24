#include <iostream>
#include <stdio.h>
#define For(i,a,b) for(int i=a; i<=b; i++)

using namespace std;

long long x, n, base, p;
int tests;
void open()
{
    freopen("REMAINDER.INP","r",stdin);
    freopen("REMAINDER.OUT","w",stdout);
    scanf("%d", &tests);
}

long long mul(long long a, long long b)
{
    long long p = (long double)a*b/base;
    return (a*b - base*p + base) % base;
}

long long tinh(long long x)
{
    long long ans = 1;
    while (x)
    {
        ans = mul(ans, 10);
        x/= 10;
    }
    return ans;
}

long long pow(long long n)
{
    if (n == 0) return 1;

    if ((n & 1) == 0) return (1 + mul(p, pow(n-1))) % base;
    long long t = pow(n/2), a = mul(t, p-1) + 1;
    return (mul(a, t) + t) % base;
}
void xuly()
{
    p = tinh(x);
    printf("%lld\n", mul(pow(n-1), x));
}

int main()
{
    open();
    while (tests--)
    {
        scanf("%lld%lld%lld\n", &x ,&n, &base);
        xuly();
    }
    return 0;
}
