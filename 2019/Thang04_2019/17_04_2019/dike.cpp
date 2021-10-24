#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

typedef long long LL;
LL n;
//////

void enter()
{
    scanf("%lld", &n);
}
//////

void process()
{
    LL L=0, R=2e6;
    while (L<R)
    {
        LL mid=(L+R)/2;
        if (mid*(mid+1)*(mid+2)<=6*n) L=mid+1; else R=mid;
    }
    cout << L-1;
}
//////

int main()
{
    freopen("dike.inp", "r", stdin);
    freopen("dike.out", "w", stdout);
    enter();
    process();
}
