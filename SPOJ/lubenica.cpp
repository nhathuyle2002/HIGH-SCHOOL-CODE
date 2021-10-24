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
    int maxn=1e5+100,
    maxlg=18;

int n, m;
vector<pii> e[maxn];
int pa[maxn][maxlg+1], fmin[maxn][maxlg+1], fmax[maxn][maxlg+1];
int high[maxn];

void DFS(int u)
{
    FOR (i, 0, int(e[u].size())-1)
    {
        pii v=e[u][i];
        if (high[v.fi]==0)
        {
            high[v.fi]=high[u]+1;
            pa[v.fi][0]=u;
            fmin[v.fi][0]=v.se;
            fmax[v.fi][0]=v.se;
            DFS(v.fi);
        }
    }
}

pii LCA(int u, int v)
{
    pii res=pii(int(1e7), 0);
    if (high[u]<high[v]) swap(u, v);

    FORD (i, maxlg, 0)
        if (high[pa[u][i]]>=high[v])
        {
            res.fi=min(res.fi, fmin[u][i]);
            res.se=max(res.se, fmax[u][i]);
            u=pa[u][i];
        }
    if (u==v) return res;

    FORD (i, maxlg, 0)
        if (pa[u][i]!=pa[v][i])
        {
            res.fi=min(res.fi, min(fmin[u][i], fmin[v][i]));
            res.se=max(res.se, max(fmax[u][i], fmax[v][i]));
            u=pa[u][i];
            v=pa[v][i];
        }
    res.fi=min(res.fi, min(fmin[u][0], fmin[v][0]));
    res.se=max(res.se, max(fmax[u][0], fmax[v][0]));
    return res;
}

void Enter()
{
    scanf("%d", &n);
    FOR (u, 1, n) e[u].clear();
    FOR (i, 1, n-1)
    {
        int u, v, c;
        scanf("%d%d%d", &u, &v, &c);
        e[u].push_back(pii(v, c));
        e[v].push_back(pii(u, c));
    }
}

void Init()
{
    FOR (u, 1, n) high[u]=0;
    high[1]=1; DFS(1);
    FOR (k, 1, maxlg)
        FOR (u, 1, n)
        {
            pa[u][k]=pa[pa[u][k-1]][k-1];
            fmin[u][k]=min(fmin[u][k-1], fmin[pa[u][k-1]][k-1]);
            fmax[u][k]=max(fmax[u][k-1], fmax[pa[u][k-1]][k-1]);
        }
}

void Process()
{
    scanf("%d", &m);
    FOR (i, 1, m)
    {
        int u, v;
        scanf("%d%d", &u, &v);
        pii res=LCA(u, v);
        printf("%d %d\n", res.fi, res.se);
    }
}

int main()
{
    freopen("lubenica.inp", "r", stdin);
    //freopen("lubenica.out", "w", stdout);
    Enter();
    Init();
    Process();
    return 0;
}
