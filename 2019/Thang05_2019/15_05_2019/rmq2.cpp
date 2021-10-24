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
int x1, y1, x2, y2;
//////

void buildy(int ix, int row, int i, int l, int r)
{
    if (l==r)
    {
        if (row==0) f[ix][i]=min(f[ix*2][i], f[ix*2+1][i]); else
        f[ix][i]=a[row][l];
    } else
    {
        int mid=(l+r)/2;
        buildy(ix, row, i*2, l, mid);
        buildy(ix, row, i*2+1, mid+1, r);
        f[ix][i]=min(f[ix][i*2], f[ix][i*2+1]);
    }
}

void buildx(int i, int l, int r)
{
    if (l==r) buildy(i, l, 1, 1, m); else
    {
        int mid=(l+r)/2;
        buildx(i*2, l, mid);
        buildx(i*2+1, mid+1, r);
        buildy(i, 0, 1, 1, m);
    }
}
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, n)
    {
        forn(j, 1, m) scanf("%lld", &a[i][j]);
        scanf("\n");
    }
    buildx(1, 1, n);
}
//////

long long queryy(int ix, int i, int l, int r)
{
    if (y1>r || y2<l) return oo;
    if (y1<=l && r<=y2) return f[ix][i];
    int mid=(l+r)/2;
    return
    min(queryy(ix, i*2, l, mid), queryy(ix, i*2+1, mid+1, r));
}

long long queryx(int i, int l, int r)
{
    if (x1>r || x2<l) return oo;
    if (x1<=l && r<=x2) return queryy(i, 1, 1, m);
    int mid=(l+r)/2;
    return
    min(queryx(i*2, l, mid), queryx(i*2+1, mid+1, r));
}

void process()
{
    scanf("%d\n", &q);
    int dem=0;
    while (++dem<=q)
    {
        scanf("%d%d%d%d\n", &x1, &y1, &x2, &y2);
        cout << queryx(1, 1, n) << '\n';
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
