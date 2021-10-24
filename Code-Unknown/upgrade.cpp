#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)
using namespace std;
//////

typedef long long LL;
typedef pair<LL, int> plli;
struct edge
{
    int x, y, w;
};
const
    int maxn=1e5+100;
const
    LL oo=1e14, base=1e9+7;
int n, m;
vector<edge> e;
vector<int> pose[maxn];
LL d[maxn], dn[maxn], g[maxn], gn[maxn];
set<plli> Q;
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, m)
    {
        int u, v, w;
        scanf("%d%d%d\n", &u, &v, &w);
        pose[u].push_back(e.size()); e.push_back({u, v, w});
        pose[v].push_back(e.size()); e.push_back({v, u ,w});
    }
}
//////

void dijkstra(int S, int T)
{
    forn(u, 1, n)
    {
        d[u]=oo; g[u]=0;
    }
    d[S]=0; g[S]=1;
    Q.clear(); Q.insert({0, S});
    while (!Q.empty())
    {
        int u=Q.begin()->second; Q.erase(Q.begin());
        if (u==T) break;
        for(int i : pose[u])
        {
            int v=e[i].y, w=e[i].w;
            if (d[u]+w==d[v]) g[v]=(g[v]+g[u]) % base; else
            if (d[u]+w<d[v])
            {
                if (d[v]<oo) Q.erase({d[v], v});
                d[v]=d[u]+w; g[v]=g[u];
                Q.insert({d[v], v});
            }
        }
    }
}
//////

void process()
{
    dijkstra(n, 1);
    forn(u, 1, n)
    {
        dn[u]=d[u]; gn[u]=g[u];
    }
    dijkstra(1, n);

    int res=0;
    for(edge p : e)
    {
        int x=p.x, y=p.y, w=p.w;
        if ((d[x]+dn[x]==d[n]) &&
            (d[y]+dn[y]==d[n]) &&
            (d[x]+w==d[y]) &&
            (g[x]*gn[y] % base==g[n])) res++;
    }
    cout << res;
}
//////

int main()
{
    freopen("upgrade.inp", "r", stdin);
    freopen("upgrade.out", "w", stdout);
    enter();
    process();
}
