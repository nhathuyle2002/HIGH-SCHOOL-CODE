#include <iostream>
#include <stdio.h>
#include <vector>

using namespace std;
////////

const
    int maxn=20010;

int n, m;
int x[maxn], y[maxn], d[maxn];
int pa[maxn], root[maxn];
int deep[maxn];
vector<int> e[maxn];
vector<int> ot1, ot2;
////////

void enter()
{
    scanf("%d%d", &n, &m);
    for (int i=1; i<=m; i++)
    {
        scanf("%d%d", &x[i], &y[i]);
        e[x[i]].push_back(y[i]);
        e[y[i]].push_back(x[i]);
    }
}
////////

/*int findroot(int u)
{
    while (root[u]!=u) u=root[u];
    return u;
}

void kruscal()
{
    for (int i=1; i<=n; i++) root[i]=i;
    for (int i=1; i<=m; i++)
    {
        int x0=findroot(x[i]), y0=findroot(y[i]);
        if (x0!=y0)
        {
            e[x[i]].push_back(y[i]);
            e[y[i]].push_back(x[i]);
            d[i]=1;
        }
        root[x[i]]=x0; root[y[i]]=x0; root[y0]=x0;
    }
}
////////

void dfs(int u)
{
    for (int i=0; i<e[u].size(); i++)
    {
        int v=e[u][i];
        if (pa[v]==0)
        {
            pa[v]=u;
            deep[v]=deep[u]+1;
            dfs(v);
        }
    }
}

void process()
{
    for (int i=1; i<=n; i++) pa[i]=0;
    pa[1]=-1; deep[1]=0;
    dfs(1);
    cout << m-n+1 << '\n';
    for (int i=1; i<=m; i++)
    if (d[i]==0)
    {
        int u=x[i], v=y[i];
        if (deep[u]>deep[v]) swap(u, v);

        ot1.clear(); ot2.clear();
        while (deep[v]>deep[u])
        {
            ot2.push_back(v);
            v=pa[v];
        }
        while (u!=v)
        {
            ot1.push_back(u); u=pa[u];
            ot2.push_back(v); v=pa[v];
        }
        ot1.push_back(u);
        for (int i=0; i<ot1.size(); i++) cout << ot1[i] << ' ';
        for (int i=(int)(ot2.size())-1; i>=0; i--) cout << ot2[i] << ' ';
        cout << ot1[0] << '\n';
    }
}
////////
*/

void dfs(int u)
{
    d[u]=1;
    for (int i=0; i<e[u].size(); i++)
    {
        int v=e[u][i];
        if (d[v]==0) dfs(v);
    }
}

void process2()
{
    for (int u=1; u<=n; u++) d[u]=0;
    int res=m-n;
    for (int u=1; u<=n; u++)
    if (d[u]==0)
    {
        res++;
        dfs(u);
    }
    cout << res;
}

int main()
{
    freopen("tours.inp", "r", stdin);
    freopen("tours.out", "w", stdout);
    enter();
    //kruscal();
    //process();
    process2();
}
