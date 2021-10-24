#include <iostream>
#include <stdio.h>
#include <vector>
#include <algorithm>

using namespace std;
///////

const
    int maxn=1e5+100;
int n, root;
int w[maxn];
vector<int> e[maxn];
long long f[maxn][2];
long long res;
vector<int> ot;
///////

void enter()
{
    scanf("%d", &n);
    for (int i=1; i<=n; i++)
    {
        int x;
        scanf("%d%d", &x, &w[i]);
        if (x==0) root=i; else e[x].push_back(i);
    }
}
///////

void dfs1(int u)
{
    f[u][0]=0; f[u][1]=w[u];
    for (int i=0; i<e[u].size(); i++)
    {
        int v=e[u][i];
        dfs1(v);
        f[u][1]+=f[v][0];
        f[u][0]+=max(f[v][0], f[v][1]);
    }
}
///////

void dfs2(int u, int k)
{
    if (k==1)
    {
        ot.push_back(u);
        for (int i=0; i<e[u].size(); i++)
        {
            int v=e[u][i];
            dfs2(v, 0);
        }
    } else
    {
        for (int i=0; i<e[u].size(); i++)
        {
            int v=e[u][i];
            if (f[v][1]>f[v][0]) dfs2(v, 1); else dfs2(v, 0);
        }
    }
}

void process()
{
    dfs1(root);
    ot.clear();
    if (f[root][1]>f[root][0])
    {
        res=f[root][1];
        dfs2(root, 1);
    } else
    {
        res=f[root][0];
        dfs2(root, 0);
    }
    cout << ot.size() << ' ' << res << '\n';
    sort(ot.begin(), ot.end());
    for (int i=0; i<ot.size(); i++) cout << ot[i] << '\n';
}
///////

int main()
{
    freopen("guest.inp", "r", stdin);
    freopen("guest.out", "w", stdout);
    enter();
    process();
}
