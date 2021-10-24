#include <iostream>
#include <stdio.h>
#include <vector>
#include <utility>
#include <queue>

#define _y first
#define _w second

using namespace std;
///////

typedef long long ll;
typedef pair<int, ll> pil;

struct comp
{
    bool operator()(pil x, pil y){return x._w>y._w;}
};

const
    int maxn=410;
int n, nq;
vector<pil> e[maxn], e2[maxn], e3[maxn];
ll d[maxn][maxn];//, ww[maxn][maxn], ww2[maxn][maxn];

priority_queue<pil, vector<pil>, comp> q;
ll f[4][maxn], g[4][maxn];
ll res;
///////

void enter()
{
    int m;
    scanf("%d%d%d\n", &n, &m, &nq);

    for (int i=1; i<=n; i++)
        for (int j=1; j<=n; j++)
            if (i!=j) d[i][j]=ll(1e16); else d[i][j]=0;
    /*//////
    for (int i=1; i<=n+3; i++)
        for (int j=1; j<=n+3; j++)
            if (i!=j) ww[i][j]=ll(1e16); else ww[i][j]=0;
    //////*/

    for (int i=1; i<=m; i++)
    {
        int u, v; ll w;
        scanf("%d%d%lld\n", &u, &v, &w);
        e2[u].push_back(pil(v, w));
        d[u][v]=min(d[u][v], w);
        /*//////
        ww[u][v]=min(ww[u][v], w);
        //////*/
    }

    for (int k=1; k<=n; k++)
        for (int i=1; i<=n; i++)
            for (int j=1; j<=n; j++)
                d[i][j]=min(d[i][j], d[i][k]+d[k][j]);
}
///////

void dijkstra(int s, ll dd[])
{
    while (!q.empty()) q.pop();
    for (int i=1; i<=n+3; i++) dd[i]=ll(1e16);
    dd[s]=0; q.push(pil(s, 0));

    do
    {
        if (q.empty()) break;
        pil u=q.top(); q.pop();
        if (dd[u._y]!=u._w) continue;

        for (int i=0; i<e[u._y].size(); i++)
        {
            pil v=e[u._y][i];
            if (u._w+v._w<dd[v._y])
            {
                dd[v._y]=u._w+v._w;
                q.push(pil(v._y, dd[v._y]));
            }
        }
    }
    while (true);
}

///////

void process()
{
    for (int t=1; t<=nq; t++)
    {
        for (int i=1; i<=n+3; i++) e[i]=e2[i];
        int m;
        scanf("%d", &m);

        /*//////
        for (int i=1; i<=n+3; i++)
            for (int j=1; j<=n+3; j++)
                ww2[i][j]=ww[i][j];
        //////*/

        for (int i=1; i<=m; i++)
        {
            int u, v; ll w;
            scanf("%d%d%lld", &u, &v, &w);
            e[u].push_back(pil(v, w));
            /*//////
            ww2[u][v]=min(ww2[u][v], w);
            //////*/
        }

        /*//////
        for (int k=1; k<=n+3; k++)
        for (int i=1; i<=n+3; i++)
            for (int j=1; j<=n+3; j++)
                ww2[i][j]=min(ww2[i][j], ww2[i][k]+ww2[k][j]);
        res=0;
        for (int i=1; i<=n+3; i++)
            for (int j=1; j<=n+3; j++)
                res+=ww2[i][j];
        cout << res << '\n';
        //////*/

        dijkstra(n+1, f[1]);
        dijkstra(n+2, f[2]);
        dijkstra(n+3, f[3]);

        for (int i=1; i<=n+3; i++) e3[i]=e[i];
        for (int i=1; i<=n+3; i++) e[i].clear();
        for (int u=1; u<=n+3; u++)
            for (int i=0; i<e3[u].size(); i++)
        {
            pil v=e3[u][i];
            e[v._y].push_back(pil(u, v._w));
        }

        dijkstra(n+1, g[1]);
        dijkstra(n+2, g[2]);
        dijkstra(n+3, g[3]);

        res=0;
        for (int u=1; u<=3; u++)
            for (int i=1; i<=n; i++) res+=f[u][i]+g[u][i];
        for (int i=n+1; i<=n+3; i++)
            for (int j=n+1; j<=n+3; j++) res+=f[i-n][j];
        for (int i=1; i<=n; i++)
            for (int j=1; j<=n; j++)
        {
            ll w=d[i][j];
            for (int u=1; u<=3; u++)
                w=min(w, g[u][i]+f[u][j]);
            res=res+w;
        }

        cout << res << '\n';
    }
}
///////

int main()
{
    freopen("dij.inp", "r", stdin);
    freopen("dij.out", "w", stdout);
    enter();
    process();
}
