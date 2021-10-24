#include <iostream>
#include <math.h>

using namespace std;
//////////

long long n, b;
int cou;
long long prime[100];
int dd[100];
long long res;
//////////

void enter()
{
    scanf("%lld%lld", &n, &b);
}
//////////

void init()
{
    cou=0;
    for (int i=2; i<=sqrt(b); i++)
    if (b%i==0)
    {
        cou++;
        prime[cou]=i;
        while (b%i==0)
        {
            dd[cou]++;
            b/=i;
        }
    }
    if (b>=2)
    {
        cou++;
        prime[cou]=b;
        dd[cou]=1;
    }
}
///////////

long long calc(long long x, long long y)
{
    long long ans=0, y2;
    y2=y;
    while (x/y>=1)
    {
        ans+=x/y;
        if (x/y2<y) break; else y*=y2;
    }
    return ans;
}
///////////

void process()
{
    res=trunc(1e18+100);
    for (int i=1; i<=cou; i++)
        res=min(res, calc(n, prime[i])/dd[i]);
    cout << res;
}
//////////

int main()
{
    enter();
    init();
    process();
}
