#include <iostream>
#include <stdio.h>
#include <vector>
#include <utility>

using namespace std;
///////

const
    int maxn=2e5+100;

int n, cou;
int a[maxn];
int d[maxn][2];
bool dcc[maxn][2];
long long f[maxn][2];
///////

void enter()
{
    scanf("%d\n", &n);
    for (int i=2; i<=n; i++) scanf("%d", &a[i]);
}
///////

void dfs(int u, int k)
{
    d[u][k]=cou; f[u][k]=a[u];
    int v;
    if (k==0) v=u-a[u]; else v=u+a[u];
    if (v<=0 || v>n) dcc[u][k]=true; else
    if (d[v][1-k]==cou) dcc[u][k]=false; else
    {
        if (d[v][1-k]==0) dfs(v, 1-k);
        dcc[u][k]=dcc[v][1-k];
        f[u][k]+=f[v][1-k];
    }
    if (!dcc[u][k]) f[u][k]=0;
}

void process()
{
    for (int u=1; u<=n; u++)
    {
        d[u][1]=0;
        d[u][0]=0;
        dcc[u][1]=true;
        dcc[u][0]=true;
    }
    d[1][1]=-1; dcc[1][1]=false;
    cou=0;
    for (int u=2; u<=n; u++)
    {
        if (d[u][0]==0)
        {
            cou++;
            dfs(u, 0);
        }
        if (!dcc[u][0]) cout << -1; else cout << f[u][0]+u-1;
        cout << '\n';
    }
}
///////

int main()
{
    freopen("gamec.inp", "r", stdin);
    freopen("gamec.out", "w", stdout);
    enter();
    process();
}
