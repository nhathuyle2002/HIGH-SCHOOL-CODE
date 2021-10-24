#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=21, maxbit=1<<20;
int n, maxb;
int d[maxn][maxn];
bool dd[maxbit];
int f[maxbit][maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 0, n)
        forn(j, 0, n) scanf("%d", &d[i][j]);
}
//////

inline void minimize(int &x, int y) {if (x>y) x=y;}

inline int getb(int &x, int i)
{
    return (x >> (i-1)) & 1;
}

inline int daob(int &x, int i)
{
    return x ^ (1 << (i-1));
}

void process()
{
    maxb=(1<<n)-1;
    forn(x, 0, maxb)
    {
        dd[x]=true;
        forn(i, 1, n/2)
            if (!getb(x, i) && getb(x, i+n/2))
            {
                dd[x]=false;
                break;
            }
    }

    forn(x, 1, maxb)
    if (dd[x])
    forn(i, 1, n)
    if (getb(x, i)==1)
    {
        f[x][i]=1e9+1;
        int y=daob(x, i);
        if (!dd[y]) continue;
        if (y==0) { f[x][i]=d[0][i]; continue; }
        forn(j, 1, n)
            if (getb(y, j)) minimize(f[x][i], f[y][j]+d[j][i]);
    }

    int res=1e9+1;
    forn(i, n/2+1, n)
        minimize(res, f[maxb][i]+d[i][0]);
    cout << res;
}
//////

int main()
{
    freopen("taxi.inp", "r", stdin);
    freopen("taxi.out", "w", stdout);
    enter();
    process();
}
