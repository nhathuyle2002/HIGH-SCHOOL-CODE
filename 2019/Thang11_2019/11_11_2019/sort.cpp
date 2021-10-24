#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=2e5+100;
int n, res;
int a[maxn], maxa[maxn], mina[maxn];
//////

void fastscan(int &number)
{
    number=0;
    register char c=getchar();
    while (c!='-' && (c<48 || c>57)) c=getchar();
    bool negative=false;
    if (c=='-') negative=true, c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
    if (negative) number=-number;
}

void enter()
{
    fastscan(n);
    forn(i, 1, n) fastscan(a[i]);
    maxa[0]=-1e9-1;
    forn(i, 1, n) maxa[i]=max(maxa[i-1], a[i]);
    mina[n+1]=1e9+1;
    ford(i, n, 1) mina[i]=min(mina[i+1], a[i]);
}
//////

void process()
{
    res=1;
    ford(i, n, 2)
        if (mina[i]>=maxa[i-1]) ++res;
    cout << res;
}
//////

int main()
{
    freopen("sort.inp", "r", stdin);
    freopen("sort.out", "w", stdout);
    enter();
    process();
}
