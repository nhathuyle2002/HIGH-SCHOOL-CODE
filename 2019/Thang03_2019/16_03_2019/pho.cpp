#include <iostream>
#include <stdio.h>
#include <vector>

using namespace std;
//////
const
    int maxn=1e5+100;
int n, m, root;
vector<int> e[maxn];
int high[maxn], f[maxn];
bool avail[maxn];
int res, cou;
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    for (int i=0; i<n; i++) avail[i]=false;
    for (int i=0; i<m; i++)
    {
        int x; scanf("%d", &x);
        avail[x]=true;
        root=x;
    }
    scanf("\n");
    for (int i=0; i<n-1; i++)
    {
        int u, v;
        scanf("%d%d\n", &u, &v);
        e[u].push_back(v);
        e[v].push_back(u);
    }
}
//////

void dfs(int u)
{
    if (avail[u]) f[u]=high[u]; else f[u]=0;
    int max1=f[u], max2=0;

    for (int i=0; i<e[u].size(); i++)
    {
        int v=e[u][i];
        if (high[v]==0)
        {
            high[v]=high[u]+1;
            dfs(v);
            f[u]=max(f[u], f[v]);
            if (f[v]>=max1)
            {
                max2=max1; max1=f[v];
            } else
            if (f[v]>max2) max2=f[v];
            avail[u]|=avail[v];
        }
    }
    if (max1!=0 && max2!=0) res=max(res, max1+max2-2*high[u]);
    if (avail[u]) cou++;
}

void process()
{
    for (int u=0; u<n; u++) high[u]=0;
    res=0; cou=0;
    high[root]=1; dfs(root);
    cout << (cou-1)*2-res;
}

int main()
{
    freopen("pho.inp", "r", stdin);
    freopen("pho.out", "w", stdout);
    enter();
    process();
}
