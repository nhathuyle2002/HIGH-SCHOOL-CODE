#include <iostream>
#include <stdio.h>
#include <vector>
#include <utility>

#define FOR(i,a,b) for (int i=(a); i<=(b); i++)
#define FORD(i,a,b) for (int i=(a); i>=(b); i--)
#define fi first
#define se second

using namespace std;

typedef pair<int, int> pii;

const
    int maxn=1010,
    maxlg=10;

int n,m;
vector<pii> e[maxn];
int pa[maxn][maxlg+1], f[maxn][maxlg+1];
int high[maxn];

void dfs(int u)
{
    FOR (i, 0, int(e[u].size())-1)
    {
        pii v=e[u][i];
        if (high[v.fi]==0)
        {
            high[v.fi]=high[u]+1;
            pa[v.fi][0]=u;
            f[v.fi][0]=v.se;
            dfs(v.fi);
        }
    }
}

int lca(int u, int v)
{
    int res=0;
    if (high[u]<high[v]) swap(u, v);

    FORD (i, maxlg, 0)
        if (high[pa[u][i]]>=high[v])
        {
            res+=f[u][i];
            u=pa[u][i];
        }
    if (u==v) return res;

    FORD (i, maxlg, 0)
        if (pa[u][i]!=pa[v][i])
        {
            res+=f[u][i]+f[v][i];
            u=pa[u][i];
            v=pa[v][i];
        }
    res+=f[u][0]+f[v][0];
    return res;
}

void enter()
{
    scanf("%d%d", &n, &m);
    FOR (u, 1, n) e[u].clear();
    FOR (i, 1, n-1)
    {
        int u, v, c;
        scanf("%d%d%d", &u, &v, &c);
        e[u].push_back(pii(v, c));
        e[v].push_back(pii(u, c));
    }
}

void init()
{
    FOR (u, 1, n)
    {
        high[u]=0;
        pa[u][0]=0;
    }
    high[1]=1; dfs(1);
    FOR (k, 1, maxlg)
        FOR (u, 1, n)
        {
            pa[u][k]=pa[pa[u][k-1]][k-1];
            f[u][k]=f[u][k-1]+f[pa[u][k-1]][k-1];
        }
}

void process()
{
    FOR (i, 1, m)
    {
        int u, v;
        scanf("%d%d", &u, &v);
        printf("%d\n", lca(u,v));
    }
}

int main()
{
    freopen("pwalk.inp", "r", stdin);
    //freopen("pwalk.out", "w", stdout);
    enter();
    init();
    process();
    return 0;
}
