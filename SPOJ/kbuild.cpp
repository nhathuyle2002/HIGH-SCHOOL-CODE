#include <iostream>
#include <stdio.h>
#include <vector>

#define FOR(i,a,b) for (int i=(a); i<=(b); i++)
#define FORD(i,a,b) for (int i=(a); i>=(b); i--)

using namespace std;

const
    int maxn=2e5+100,
    maxlg=18;

int n,m;
vector<int> e[maxn];
int pa[maxn][maxlg+1];
int high[maxn], d[maxn];
int res;

void dfs(int u)
{
    FOR (i, 0, int(e[u].size())-1)
    {
        int v=e[u][i];
        if (high[v]==0)
        {
            high[v]=high[u]+1;
            pa[v][0]=u;
            dfs(v);
        }
    }
}

void dfs2(int u)
{
    FOR (i, 0, int(e[u].size())-1)
    {
        int v=e[u][i];
        if (high[v]==high[u]+1)
        {
            dfs2(v);
            d[u]+=d[v];
        }
    }
    if (d[u]==0 && u!=1) res++;
}

int lca(int u, int v)
{
    if (high[u]<high[v]) swap(u, v);

    FORD (i, maxlg, 0)
        if (high[pa[u][i]]>=high[v]) u=pa[u][i];
    if (u==v) return u;

    FORD (i, maxlg, 0)
        if (pa[u][i]!=pa[v][i])
        {
            u=pa[u][i];
            v=pa[v][i];
        }
    return pa[u][0];
}

void enter()
{
    scanf("%d", &n);
    FOR (u, 1, n) e[u].clear();
    FOR (i, 1, n-1)
    {
        int u,v;
        scanf("%d%d", &u, &v);
        e[u].push_back(v);
        e[v].push_back(u);
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
            pa[u][k]=pa[pa[u][k-1]][k-1];
}

void process()
{
    scanf("%d", &m);
    FOR (i, 1, m)
    {
        int u, v;
        scanf("%d%d", &u, &v);
        int p=lca(u, v);
        d[p]-=2;
        d[u]++; d[v]++;
    }
    res=0;
    dfs2(1);
    printf("%d", res);
}

int main()
{
    freopen("kbuild.inp", "r", stdin);
    //freopen("kbuild.out", "w", stdout);
    enter();
    init();
    process();
    return 0;
}
