#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxs=135, maxn=4e6;
int nTest;
int prime[maxs+1];
int choose[maxn+1];
long long PA, PB;
//////

void fastscan(long long &number)
{
    number=0;
    register char c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
}
//////

bool uoc_chan(int x)
{
    int y=sqrt(x);
    if (y*y==x) return false; else return true;
}

bool sum_prime(int x)
{
    int ans=0;
    while (x>0) ans+=x%10, x/=10;
    if (prime[ans]==ans) return true; else return false;
}

void init()
{
    forn(x, 2, maxs) prime[x]=x;
    forn(x, 2, maxs)
        if (prime[x]==x)
            forn(j, x, maxs/x) prime[x*j]=x;

    forn(x, 1, maxn)
    {
        choose[x]=choose[x-1];
        if (uoc_chan(x) && sum_prime(x)) ++choose[x];
    }
}
//////

int main()
{
    freopen("spnum.inp", "r", stdin);
    freopen("spnum_try.out", "w", stdout);

    init();

    scanf("%d\n", &nTest);
    while (nTest--)
    {
        fastscan(PA); fastscan(PB);
        cout << choose[PB]-choose[PA-1] << '\n';
    }
}
