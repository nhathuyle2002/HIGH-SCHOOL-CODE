#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=1e5+100;
int n;
int a[maxn], f[maxn][12];
//////

void fastscan(int &number)
{
    number=0;
    register char c=getchar();
    bool negative=false;
    if (c=='-') negative=true, c=getchar();
    for(; c>47 && c<58; c=getchar())
        number=number*10+c-48;
    if (negative) number=-number;
}

void enter()
{
    fastscan(n);
    forn(i, 1, n) fastscan(a[i]), a[i]%=12;
}
//////

int bdoi(int x, int y)
{
    return (y+12-x)%12;
}

void process()
{
    forn(j, 0, 11) f[1][j]=bdoi(j, a[1]);
    forn(i, 2, n)
        forn(j, 0, 11)
        {
            int d=bdoi(j, a[i]);
            f[i][j]=f[i-1][(12-d)%12]+d;
        }
    forn(j2, 0, 11)
        f[n][0]=min(f[n][0], f[n][j2]+bdoi(j2, 0));
    cout << f[n][0];
}
//////

int main()
{
    freopen("clock.inp", "r", stdin);
    freopen("clock.out", "w", stdout);
    enter();
    process();
}
