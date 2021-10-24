#include <iostream>
#include <stdio.h>
#include <vector>
#include <string.h>
#include <deque>

using namespace std;
//////

const
    int maxn=1010;

int n, m;
char a[maxn][maxn];
vector<int> e[maxn*2];
int coutp;
int id[maxn*2];
bool okres;
int deg[maxn*2], res[maxn*2];
deque<int> q;
//////

void enter()
{
    scanf("%d%d", &n, &m);
    for (int i=1; i<=n; i++)
        scanf("%s\n", a[i]+1);
}
//////

void dfs(int u)
{
    id[u]=coutp;
    for (int i=0; i<e[u].size(); i++)
    {
        int v=e[u][i];
        if (id[v]==0) dfs(v);
    }
}

void init()
{
    for (int i=1; i<=n+m; i++) e[i].clear();
    for (int i=1; i<=n; i++)
        for (int j=1; j<=m; j++)
            if (a[i][j]=='=')
    {
        e[i].push_back(n+j);
        e[n+j].push_back(i);
    }
    coutp=0;
    for (int i=1; i<=n+m; i++)
        if (id[i]==0)
    {
        coutp++;
        dfs(i);
    }
}
//////

void buildgraph()
{
    okres=true;
    for (int i=1; i<=coutp; i++) e[i].clear();

    for (int i=1; i<=n; i++)
        for (int j=1; j<=m; j++)
    {
        int x=id[i], y=id[n+j];
        if (x==y)
        {
            if (a[i][j]=='=') continue;
            okres=false;
            return;
        } else
        {
            if (a[i][j]=='>')
            {
                e[y].push_back(x);
                deg[x]++;
            } else
            {
                e[x].push_back(y);
                deg[y]++;
            }
        }
    }
}
//////

void process()
{
    if (!okres) return;
    q.clear();
    for (int i=1; i<=coutp; i++)
        if (deg[i]==0)
    {
        res[i]=1;
        q.push_back(i);
    }

    while (!q.empty())
    {
        int u=q.front(); q.pop_front();
        for (int i=0; i<e[u].size(); i++)
        {
            int v=e[u][i];
            res[v]=max(res[v], res[u]+1);
            deg[v]--;
            if (deg[v]==0) q.push_back(v);
        }
    }
    for (int i=1; i<coutp; i++)
        if (deg[i]>0)
    {
        okres=false;
        return;
    }
}
//////

int main()
{
    freopen("o.inp", "r", stdin);
    freopen("o.out", "w", stdout);
    enter();
    init();
    buildgraph();
    process();
    if (!okres) cout << "No"; else
    {
        cout << "Yes" << '\n';
        for (int i=1; i<=n; i++) cout << res[id[i]] << ' ';
        cout << '\n';
        for (int j=1; j<=m; j++) cout << res[id[n+j]] << ' ';
    }
}
