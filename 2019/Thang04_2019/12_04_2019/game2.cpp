#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=110, oo=1e8;
int n, la, lb, lc, res;
int a[maxn], b[maxn], c[maxn];
int f[2][maxn][maxn][maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    la=0; lb=0; lc=0;
    int x;
    forn(i, 1, n)
    {
        scanf("%d", &x);
        if (x!=0) a[++la]=x;
    }
    forn(i, 1, n)
    {
        scanf("%d", &x);
        if (x!=0) b[++lb]=x;
    }
    forn(i, 1, n)
    {
        scanf("%d", &x);
        if (x!=0) c[++lc]=x;
    }
}
//////

void process()
{
    res=-oo;
    forn(t, 0, n-la)
    forn(x, 0, la)
    forn(y, 0, lb)
    forn(z, 0, lc)
    {
        int t2=t % 2;
        f[t2][x][y][z]=-oo;
        if (x+t<max(y, z) || x+t>y+n-lb || x+t>z+n-lc) continue;
        if (x==0 && y==0 && z==0 && t<=n-lb && t<=n-lc) f[t2][x][y][z]=0;
        int s=-oo;
        if (x>0 && y>0 && z>0) s=f[t2][x-1][y-1][z-1]+a[x]*b[y]*c[z];
        if (x>0 && x-1+t>=max(y, z)) s=max(s, f[t2][x-1][y][z]);
        if (x>0 && y>0 && x-1+t>=z) s=max(s, f[t2][x-1][y-1][z]);
        if (x>0 && z>0 && x-1+t>=y) s=max(s, f[t2][x-1][y][z-1]);
        if (t>0)
        {
            if (y>0 && x+t-1>=z) s=max(s, f[1-t2][x][y-1][z]);
            if (z>0 && x+t-1>=y) s=max(s, f[1-t2][x][y][z-1]);
            if (y>0 && z>0) s=max(s, f[1-t2][x][y-1][z-1]);
        }
        f[t2][x][y][z]=max(f[t2][x][y][z], s);
        if (x==la && y==lb && z==lc) res=max(res, s);
    }
    cout << res;
}
//////

int main()
{
    freopen("game2.inp", "r", stdin);
    freopen("game2.out", "w", stdout);
    enter();
    process();
}
