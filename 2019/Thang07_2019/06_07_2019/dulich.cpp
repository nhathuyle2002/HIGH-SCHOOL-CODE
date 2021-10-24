#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

const
    int maxn=300;
int n, m;
int c[maxn];
int f[maxn][maxn];
vector<int> e[maxn];
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, n) scanf("%d", &c[i]);
    forn(i, 1, n-1)
    {
        int u, v; scanf("%d%d\n", &u, &v);
        e[u].push_back(v);
        e[v].push_back(u);
    }
}
//////

void dfs(int u)
{
    f[u][1]=c[u];
    c[u]=-1;
    for(int v : e[u])
    {
        if (c[v]==-1) continue;
        dfs(v);
        ford(j, m, 2)
            forn(j2, 1, j-1)
                f[u][j]=max(f[u][j], f[v][j2]+f[u][j-j2]);
    }
}

void process()
{
    dfs(1);
    int res=0;
    forn(u, 1, n) res=max(res, f[u][m]);
    cout << res;
}
//////

int main()
{
    freopen("dulich.inp", "r", stdin);
    freopen("dulich.out", "w", stdout);
    enter();
    process();
}
