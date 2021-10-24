#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=12, maxm=1e4+100, oo=1e9;
int n, m;
int a[maxn];
int f[maxn][maxm];
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, n) scanf("%d\n", &a[i]);
}
//////

void process()
{
    f[0][0]=0;
    forn(j, 1, m) f[0][j]=oo;
    forn(i, 1, n)
        forn(j, 0, m)
        {
            f[i][j]=oo;
            forn(t, 1, 100)
                if (j-t*t<0) break; else
                f[i][j]=min(f[i][j], f[i-1][j-t*t]+(t-a[i])*(t-a[i]));
        }
    if (f[n][m]==oo) cout << -1; else cout << f[n][m];
}
//////

int main()
{
    freopen("tilechng.inp", "r", stdin);
    freopen("tilechng.out", "w", stdout);
    enter();
    process();
}
