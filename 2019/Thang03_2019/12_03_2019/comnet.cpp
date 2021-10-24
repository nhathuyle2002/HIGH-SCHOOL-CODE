#include <iostream>
#include <stdio.h>
#include <vector>

using namespace std;
//////

const
    int maxn=5e3+100;
int n, m;
vector<int> e[maxn];
bool d[maxn];
int res;
int q[maxn];

void dfs(int u)
{
    d[u]=false;
    for (int i=0; i<e[u].size(); i++)
        if (d[e[u][i]]) dfs(e[u][i]);
}

int main()
{
    freopen("comnet.inp", "r", stdin);
    freopen("comnet.out", "w", stdout);
    scanf("%d%d\n", &n, &m);
    for (int i=1; i<=m; i++)
    {
        int u, v;
        scanf("%d%d\n", &u, &v);
        e[u].push_back(v);
        e[v].push_back(u);
    }
    for (int u=1; u<=n; u++) d[u]=true;
    res=0;
    for (int u=1; u<=n; u++)
        if (d[u])
        {
            res++; q[res]=u;
            dfs(u);
        }
    cout << res-1 << '\n';
    for (int i=1; i<res; i++) cout << q[i] << ' ' << q[i+1] << '\n';
}
