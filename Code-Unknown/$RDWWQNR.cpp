#include <bits/stdc++.h>
#define forn(i, a, b) for (int i=(a); i<=(b); ++i)
#define ford(i, a, b) for (int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=501;
const
    long long oo=(1LL << 32);
int n, m, q;
long long a[maxn][maxn];
long long f[4*maxn][4*maxn];
int x1, y1, x2, y2, maxix, maxiy;
//////

void build(int ix, int lx, int rx, int iy, int ly, int ry)
{
    if (lx>rx || ly>ry)
    {
        f[ix][iy]=oo;
        return;
    }
    maxix=max(maxix, ix);
    maxiy=max(maxiy, iy);
    if (lx==rx && ly==ry)
    {
        f[ix][iy]=a[lx][ly];
        return;
    }

    int mx=(lx+rx)/2, my=(ly+ry)/2;
    build(ix*2, lx, mx, iy*2, ly, my);
    build(ix*2, lx, mx, iy*2+1, my+1, ry);
    build(ix*2+1, mx+1, rx, iy*2, ly, my);
    build(ix*2+1, mx+1, rx, iy*2+1, my+1, ry);

    f[ix][iy]=min(min(f[ix*2][iy*2], f[ix*2][iy*2+1]), min(f[ix*2+1][iy*2], f[ix*2+1][iy*2+1]));
}

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, n)
    {
        forn(j, 1, m) scanf("%lld", &a[i][j]);
        scanf("\n");
    }
    build(1, 1, n, 1, 1, m);
}
//////

long long query(int ix, int lx, int rx, int iy, int ly, int ry)
{
    //if (ix>maxix || iy>maxiy) return oo;
    if (lx>rx || ly>ry || x1>rx || lx>x2 || y1>ry || ly>y2) return oo;
    if (x1<=lx && rx<=x2 && y1<=ly && ry<=y2) return f[ix][iy];
    //if (lx==rx && ly==ry) return oo;

    int mx=(lx+rx)/2, my=(ly+ry)/2;
    return
    min(min(query(ix*2, lx, mx, iy*2, ly, my), query(ix*2, lx, mx, iy*2+1, my+1, ry)),
        min(query(ix*2+1, mx+1, rx, iy*2, ly, my), query(ix*2+1, mx+1, rx, iy*2+1, my+1, ry)));
}

void process()
{
    scanf("%d\n", &q);
    int dem=0;
    while (++dem<=q)
    {
        scanf("%d%d%d%d\n", &x1, &y1, &x2, &y2);
        cout << query(1, 1, n, 1, 1, m) << '\n';
    }
}
//////

int main()
{
    freopen("rmq2.inp", "r", stdin);
    freopen("rmq2.out", "w", stdout);
    enter();
    process();
}
