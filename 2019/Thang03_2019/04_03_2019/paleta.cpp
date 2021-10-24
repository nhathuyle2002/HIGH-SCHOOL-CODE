#include <iostream>
#include <stdio.h>
#include <vector>

using namespace std;
////////

const   int maxn=1e6+100;
const   int base=1e9+7;

int n, k;
vector<int> e[maxn];
int cou, coutp;
vector<int> q;
int num[maxn], low[maxn], id[maxn];

long long f[maxn][2];
int d[maxn], deg[maxn];
long long res;
////////

void dfs(int u)
{
    cou++; num[u]=cou; low[u]=cou;
    q.push_back(u);
    for (int i=0; i<e[u].size(); i++)
    {
        int v=e[u][i];
        if (num[v]==0)
        {
            dfs(v);
            low[u]=min(low[u], low[v]);
        } else
        if (id[v]==0)
            low[u]=min(low[u], num[v]);
    }
    if (low[u]==num[u])
    {
        coutp++; d[coutp]=0;
        int v;
        do
        {
            v=q.back(); q.pop_back();
            id[v]=coutp;
            d[coutp]++;
        }
        while (v!=u);
    }
}

void enter()
{
    scanf("%d%d\n", &n, &k);
    for (int i=1; i<=n; i++)
    {
        int x;
        scanf("%d", &x);
        if (x!=i) e[x].push_back(i);
    }
}
////////

void init()
{
    cou=0; coutp=0;
    q.clear();
    for (int i=1; i<=n; i++)
        if (num[i]==0) dfs(i);

    f[1][1]=k; f[1][0]=0;
    for (int i=2; i<=n; i++)
    {
        f[i][1]=f[i-1][0];
        f[i][0]=(f[i-1][1]*(k-1)+f[i-1][0]*(k-2)) % base;
    }
    f[1][0]=k;
}
////////

void process()
{
    for (int u=1; u<=n; u++)
        for (int i=0; i<e[u].size(); i++)
    {
        int v=e[u][i];
        if (id[v]!=id[u]) deg[id[v]]++;
    }

    res=1;
    for (int u=1; u<=coutp; u++)
        if (deg[u]==0) res=res*f[d[u]][0] % base; else res=res*(k-1) % base;
    cout << res;
}
////////

int main()
{
    freopen("paleta.inp", "r", stdin);
    freopen("paleta.out", "w", stdout);
    enter();
    init();
    process();
}
