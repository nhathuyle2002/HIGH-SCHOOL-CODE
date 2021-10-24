#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)

using namespace std;
//////

const
    int maxn=1e3+100;

int n, m, T;
int a[maxn], b[maxn];
bool d[maxn][maxn];
int f[maxn][maxn], suma[maxn], sumb[maxn];
int res;
///////

void enter()
{
    scanf("%d\n", &T);
    scanf("%d\n", &n);
    forn(i, 1, n)
    {
        scanf("%d\n", &a[i]);
        suma[i]=suma[i-1]+a[i];
    }
    scanf("%d\n", &m);
    forn(i, 1, m)
    {
        scanf("%d\n", &b[i]);
        sumb[i]=sumb[i-1]+b[i];
    }
}
///////

void init()
{
    memset(d, sizeof(d), false);
    d[0][0]=true;
    forn(i, 1, n)
        forn(j, 0, T)
        {
            d[i][j]=d[i-1][j];
            if (j>=a[i]) d[i][j]=d[i][j] || d[i-1][j-a[i]];
            if (d[i][j]) f[i][j]=j; else f[i][j]=f[i][j-1];
        }
}
///////

int query(int x)
{
    int rr=0;
    forn(i, 1, n)
    {
        int y=f[i][x];
        if (suma[i]-y<=T) rr=i; else break;
    }
    return rr;
}

void process()
{
    res=0;
    forn(i, 1, m)
        if (sumb[i]>T) break; else
        res=max(res, i+query(T-sumb[i]));
    cout << res;
}
///////

int main()
{
    freopen("qua.inp", "r", stdin);
    freopen("qua.out", "w", stdout);
    enter();
    init();
    process();
}
