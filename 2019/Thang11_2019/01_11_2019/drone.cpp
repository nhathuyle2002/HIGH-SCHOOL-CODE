#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=3e3+100, oo=1e9, maxh=50;
int n, K;
int c[maxn], a[maxn];
int f[maxn][101][maxh+2];
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
    fastscan(n); fastscan(K);
    forn(i, 1, n) fastscan(c[i]);
    forn(i, 1, n) fastscan(a[i]);
}
//////

void maximize(int &x, int y) {if (x<y) x=y;}

void process()
{
    if (n==1) {cout << c[1]; return;}

    forn(i, 1, n)
        forn(k, 0, K)
            forn(p, 0, maxh+1) f[i][k][p]=-oo;

    f[1][0][a[1]]=c[1];
    forn(i, 2, n-1)
        forn(k, 0, K-1)
        {
            forn(p, 0, maxh)
                f[i][k][p]=f[i-1][k][p+1];
            if (k==0) continue;
            forn(p, 1, maxh)
                maximize(f[i][k][a[i]], f[i-1][k-1][p]+c[i]);
        }
    int res=-oo;
    forn(k, 0, K-1)
        forn(p, 1, maxh)
            maximize(res, f[n-1][k][p]+c[n]);
    if (res<0) cout << -1; else cout << res;
}
//////

int main()
{
    freopen("drone.inp", "r", stdin);
    freopen("drone.out", "w", stdout);
    enter();
    process();
}
