#include <iostream>
#include <stdio.h>
#include <vector>
#include <utility>

#define FOR(i,a,b) for (int i=(a); i<=(b); i++)
#define FORD(i,a,b) for (int i=(a); i>=(b); i--)

using namespace std;

const
    int maxn=7,//2e5+100,
    maxlg=4;//18;

int n, k, start;
vector<int> e[maxn], gr[maxn];
int pa[maxn][maxlg+1];
int high[maxn];

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

int lca(int u, int v)
{
    if (high[u]<high[v]) swap(u, v);

    FORD (i, maxlg, 0)
        if (high[pa[u][i]]>=high[v])
            u=pa[u][i];
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
    scanf("%d%d", &n, &k);
    FOR (u, 1, n) e[u].clear();
    FOR (u, 1, n)
    {
        int id, y;
        scanf("%d%d", &id, &y);
        gr[id].push_back(u);
        if (y==0) start=u; else
        {
            e[u].push_back(y);
            e[y].push_back(u);
        }
    }
}

void init()
{
    FOR (u, 1, n)
    {
        high[u]=0;
        pa[u][0]=0;
    }
    high[start]=1; dfs(start);
    FOR (i, 1, maxlg)
        FOR (u, 1, n)
            pa[u][i]=pa[pa[u][i-1]][i-1];
}

void process()
{
    FOR (i, 1, k)
    {
        int u=0;
        FOR (j, 0, int(gr[i].size())-1)
            if (high[gr[i][j]]>high[u]) u=gr[i][j];
        int res=0;
        FOR (j, 0, int(gr[i].size())-1)
        {
            int v=gr[i][j];
            int p=lca(u, v);
            res=max(res, high[u]-high[p]+high[v]-high[p]);
        }
        printf("%d\n", res);
    }
}

int main()
{
    //freopen("fselect.inp", "r", stdin);
    //freopen("fselect.out", "w", stdout);
    enter();
    init();
    process();
    return 0;
}
