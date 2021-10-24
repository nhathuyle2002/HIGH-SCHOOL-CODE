#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

const
    int maxn=1100;
int n, m, B;
int a[maxn][maxn], f[maxn][maxn];
int res;
//////

void enter()
{
    scanf("%d%d\n%d\n", &n, &m, &B);
    forn(i, 1, n)
    {
        forn(j, 1, m) scanf("%d", &a[i][j]);
        scanf("\n");
    }
}
//////

void process()
{
    forn(j, 0, m) f[0][j]=B;
    forn(i, 1, n)
    {
        f[i-1][0]=maxn*1e5; f[i-1][m+1]=maxn*1e5;
        forn(j, 1, m)
        {
            f[i][j]=min(f[i-1][j], min(f[i-1][j-1], f[i-1][j+1]))+a[i][j];
            if (a[i][j]==0) f[i][j]-=f[i][j]/2;
        }
    }
    res=maxn*1e5;
    forn(j, 1, m) res=min(res, f[n][j]);
    cout << res<< '\n';

    forn(j, 0, m) f[0][j]=B;
    forn(i, 1, n)
    {
        f[i-1][0]=0; f[i-1][m+1]=0;
        forn(j, 1, m)
        {
            f[i][j]=max(f[i-1][j], max(f[i-1][j-1], f[i-1][j+1]))+a[i][j];
            if (a[i][j]==0) f[i][j]-=f[i][j]/2;
        }
    }
    res=0;
    forn(j, 1, m) res=max(res, f[n][j]);
    cout << res;
}

int main()
{
    freopen("game.inp", "r", stdin);
    freopen("game.out", "w", stdout);
    enter();
    process();
}
