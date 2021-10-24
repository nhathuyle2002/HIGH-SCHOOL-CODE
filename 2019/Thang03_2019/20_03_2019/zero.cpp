#include <bits/stdc++.h>
#define forn(i,a,b) for (int i=(a); i<=(b); i++)
#define repn(i,a,b) for (int i=(a); i<(b); i++)

using namespace std;
//////

const
    int maxn=1e3+10, maxg=1e6+100, oo=maxg*10;
int n;
int d2[maxg], d5[maxg];
int a[maxn][maxn], f[maxn][maxn];
int res;
//////

void init()
{
    d2[0]=oo; d5[0]=oo;
    forn(x, 1, maxg)
    {
        d2[x]=0;
        int y=x;
        while (y % 2==0)
        {
            ++d2[x];
            y/=2;
        }
        d5[x]=0;
        y=x;
        while (y % 5==0)
        {
            ++d5[x];
            y/=5;
        }
    }
}
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n)
    {
        forn(j ,1, n) scanf("%d", &a[i][j]);
        scanf("\n");
    }
}
//////

void process()
{
    forn(i, 0, n)
    {
        f[0][i]=oo;
        f[i][0]=oo;
    }
    f[0][1]=0;

    forn(i, 1, n) forn(j, 1, n)
    {
            f[i][j]=min(f[i-1][j], f[i][j-1])+d2[a[i][j]];
            if (f[i][j]>oo) f[i][j]=oo;
    }
    res=f[n][n];

    forn(i, 1, n) forn(j, 1, n)
    {
            f[i][j]=min(f[i-1][j], f[i][j-1])+d5[a[i][j]];
            if (f[i][j]>oo) f[i][j]=oo;
    }
    cout << min(res, f[n][n]);
}
//////

int main()
{
    freopen("zero.inp", "r", stdin);
    freopen("zero.out", "w", stdout);
    init();
    enter();
    process();
}
