#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=210;
int n;
int a[maxn][maxn];
int res, ans[maxn], x[maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n) a[i][i]=1;
    forn(i, 1, 2*n-3)
    {
        int u, v; scanf("%d%d\n", &u, &v);
        a[u][v]=1; a[v][u]=1;
    }
    forn(i, 1, n)
    {
        scanf("%d", &a[i][n+1]);
        a[i][n+1]=1-a[i][n+1];
    }
}
//////

void Gauss()
{
    forn(i, 1, n)
    {
        forn(j, i, n)
            if (a[j][i]==1)
            {
                forn(t, 1, n+1)
                    swap(a[i][t], a[j][t]);
                break;
            }
        if (a[i][i]==1)
        forn(j, i+1, n)
            if (a[j][i]==1)
                forn(t, i, n+1)
                    a[j][t]=(a[j][t]+a[i][t])&1;
    }
}
//////

void KhuGauss(int i, int rr)
{
    if (rr>=res) return;
    if (i==0)
    {
        res=rr;
        //forn(k, 1, n) ans[k]=x[k];
        return;
    }

    int r2=0;
    forn(j, i+1, n)
        if (a[i][j]) r2=(r2+x[j])&1;
    if (a[i][i]==1)
    {
        x[i]=(a[i][n+1]-r2+2)%2;
        KhuGauss(i-1, rr+x[i]);
    }
    else
    {
        if (r2!=a[i][n+1]) return;
        x[i]=0; KhuGauss(i-1, rr);
        x[i]=1; KhuGauss(i-1, rr+1);
    }
}

void process()
{
    res=n+1;
    KhuGauss(n, 0);

    if (res==n+1) cout << -1; else cout << res;
    //cout << '\n'; forn(i, 1, n) cout << ans[i] << ' ';
}
//////

int main()
{
    freopen("x.inp", "r", stdin);
    freopen("x.out", "w", stdout);
    enter();
    Gauss();
    process();
}
