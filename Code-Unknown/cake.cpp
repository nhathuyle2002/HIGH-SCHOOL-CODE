#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)

#define F first
#define S second
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=110;
const
    int dx[4]={0, 1, 0, -1}, dy[4]={1, 0, -1, 0};

int m, n, K, res;
pii a[maxn], b[maxn];
bool dd[maxn][maxn][4];
bool d[maxn][maxn];
//////

void enter()
{
    scanf("%d%d\n", &m, &n);
    if (m==0 && n==0) return;
    scanf("%d\n", &K);
    forn(i, 1, K)
    {
        scanf("%d%d%d%d\n", &a[i].F, &a[i].S, &b[i].F, &b[i].S);
        if (a[i].F>b[i].F) swap(a[i].F, b[i].F);
        if (a[i].S>b[i].S) swap(a[i].S, b[i].S);
    }
    a[++K]={0, 0}; b[K]={n, m};

    pii d[2*maxn];
    forn(i, 1, K)
    {
        d[i]={a[i].F, i};
        d[i+K]={b[i].F, i+K};
    }
    sort(d+1, d+2*K+1);
    n=-1; d[0].F=-1;
    forn(i, 1, 2*K)
    {
        if (d[i].F>d[i-1].F) ++n;
        int p=d[i].S;
        if (p<=K) a[p].F=n; else
        b[p-K].F=n;
    }

    forn(i, 1, K)
    {
        d[i]={a[i].S, i};
        d[i+K]={b[i].S, i+K};
    }
    sort(d+1, d+2*K+1);
    m=-1; d[0].F=-1;
    forn(i, 1, 2*K)
    {
        if (d[i].F>d[i-1].F) ++m;
        int p=d[i].S;
        if (p<=K) a[p].S=m; else
        b[p-K].S=m;
    }
}
//////

void dfs(int x, int y)
{
    d[x][y]=false;
    forn(dir, 0, 3)
    if (dd[x][y][dir])
    {
        int i=x+dx[dir], j=y+dy[dir];
        if (d[i][j]) dfs(i, j);
    }
}

void process()
{
    forn(x, 1, n)
        forn(y, 1, m)
        {
            d[x][y]=true;
            forn(dir, 0, 3)
                dd[x][y][dir]=true;
        }

    forn(i, 1, K)
    {
        forn(y, a[i].S+1, b[i].S)
        {
            dd[a[i].F][y][1]=false;
            dd[a[i].F+1][y][3]=false;
            dd[b[i].F][y][1]=false;
            dd[b[i].F+1][y][3]=false;
        }
        forn(x, a[i].F+1, b[i].F)
        {
            dd[x][a[i].S][0]=false;
            dd[x][a[i].S+1][2]=false;
            dd[x][b[i].S][0]=false;
            dd[x][b[i].S+1][2]=false;
        }
    }

    res=0;
    forn(x, 1, n)
        forn(y, 1, m)
            if (d[x][y])
            {
                ++res;
                dfs(x, y);
            }
    cout << res << '\n';
}
//////

int main()
{
    freopen("cake.inp", "r", stdin);
    freopen("cake.out", "w", stdout);
    while (true)
    {
        enter();
        if (m==0 && n==0) break;
        process();
    }
}
