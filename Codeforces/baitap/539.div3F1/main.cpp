#include <iostream>
#include <stdio.h>
#include <vector>

using namespace std;
//////

const
    int maxn=3e5+100;
int n;
int id[maxn];
vector<int> e[maxn];
int f[maxn][3];
int res;
//////

void enter()
{
    scanf("%d", &n);
    for (int i=1; i<=n; i++) scanf("%d", &id[i]);
    for (int i=1; i<=n-1; i++)
    {
        int u, v;
        scanf("%d%d", &u, &v);
        e[u].push_back(v);
        e[v].push_back(u);
    }
}
//////

void dfs(int u)
{
    f[u][id[u]]++;
    id[u]=-1;
    for (int i=0; i<e[u].size(); i++)
    {
        int v=e[u][i];
        if (id[v]==-1) continue;
        dfs(v);
        for (int j=0; j<=2; j++)
            f[u][j]+=f[v][j];
    }
}

void process()
{
    dfs(1);
    res=0;
    for (int u=2; u<=n; u++)
    {
        bool ok=true;
        if (f[u][1]>0 && f[u][2]>0) ok=false;
        if (f[1][1]-f[u][1]>0 && f[1][2]-f[u][2]>0) ok=false;
        if (ok) res++;
    }
    cout << res;
}

int main()
{
    enter();
    process();
}
