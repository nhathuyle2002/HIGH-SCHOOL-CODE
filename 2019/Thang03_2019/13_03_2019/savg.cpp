#include <iostream>
#include <stdio.h>
#include <vector>
#include <iomanip>

using namespace std;
//////

struct edge
{
    int x, y, z;
};
edge make_edge(int x, int y, int z)
{
    edge p;
    p.x=x; p.y=y; p.z=z;
    return p;
}
const
    int maxN=510;

int T, n, m, A, B;
bool vis[maxN][maxN];
double d[maxN];
vector<int> e[maxN];
vector<edge> E;
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    E.clear();
    for (int u=1; u<=n; u++) e[u].clear();

    for (int i=1; i<=m; i++)
    {
        int x, y, z;
        scanf("%d%d%d\n", &x, &y, &z);
        E.push_back(make_edge(x, y, z));
        e[x].push_back(y);
    }
    scanf("%d%d\n", &A, &B);
}
//////

void dfs(int R, int u)
{
    vis[R][u]=1;
    for (int i=0; i<e[u].size(); i++)
    {
        int v=e[u][i];
        if (vis[R][v]==0) dfs(R, v);
    }
}

bool check(double val)
{
    for (int u=1; u<=n; u++)
        d[u]=1e12;
    d[A]=0;

    int x, y; double z;
    for (int t=1; t<n; t++)
    for (int i=0; i<E.size(); i++)
    {
        x=E[i].x; y=E[i].y; z=-val+E[i].z;
        d[y]=min(d[y], d[x]+z);
    }

    if (d[B]<=0) return 1;

    for (int i=0; i<E.size(); i++)
    {
        x=E[i].x; y=E[i].y; z=-val+E[i].z;
        if (d[x]+z<d[y] && vis[A][x] && vis[B][y]) return 1;
    }
    return 0;
}

void process()
{
    for (int u=1; u<=n; u++)
    {
        vis[A][u]=0;
        vis[B][u]=0;
    }
    dfs(A, A);
    if (!vis[A][B])
    {
        cout << -1 << '\n';
        return;
    }
    dfs(B, B);
    double left=0, right=100, mid;
    for (int i=1; i<=100; i++)
    {
        mid=(left+right)/2;
        if (check(mid)) right=mid; else left=mid;
    }
    cout << setprecision(10) << fixed << right << '\n';
}
//////

int main()
{
    freopen("savg.inp", "r", stdin);
    freopen("savg.out", "w", stdout);
    scanf("%d\n", &T);
    while (T--)
    {
        enter();
        process();
    }
}
