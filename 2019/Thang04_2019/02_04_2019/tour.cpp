#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)

using namespace std;
//////

typedef pair<int, int> pii;
struct edge
{
    int x, y, w;
    bool select;
};

const
    int maxn=110, oo=1e9;
int n, m;
vector<edge> e;
vector<int> pos[maxn];
int d[maxn], trace[maxn];
set<pii> Q;
int res;
///////

void enter()
{
    scanf("%d%d\n", &n, &m);
    int dd[maxn][maxn];
    forn(u, 1, n)
        forn(v, 1, n) dd[u][v]=-1;
    forn(i, 1, m)
    {
        int u, v, w;
        scanf("%d%d%d\n", &u, &v, &w);
        int p=dd[u][v];
        if (p>-1)
        {
            if (w<e[p].w)
            {
                e[p].w=w;
                e[p^1].w=w;
            }
            continue;
        }
        pos[u].push_back(e.size()); dd[u][v]=e.size(); e.push_back({u, v, w, true});
        pos[v].push_back(e.size()); dd[v][u]=e.size(); e.push_back({v, u, w, true});
    }
}
///////

void dijkstra(int S, int T, int typ)
{
    forn(u, 1, n) d[u]=oo;
    d[S]=0; trace[S]=0;
    Q.clear(); Q.insert({0, S});
    while (!Q.empty())
    {
        int u=Q.begin()->second; Q.erase(Q.begin());
        if (u==T) return;
        for(int i : pos[u])
            if (e[i].select)
        {
            int v=e[i].y, w=e[i].w;
            if (d[u]+w<d[v])
            {
                if (d[v]<oo) Q.erase({d[v], v});
                d[v]=d[u]+w;
                if (typ==1) trace[v]=u;
                Q.insert({d[v], v});
            }
        }
    }
}

void process()
{
    res=oo; int ires=0;
    for(int i=0; i<e.size(); i+=2)
    {
        edge p=e[i];
        e[i].select=false;
        dijkstra(e[i].x, e[i].y, 0);
        if (res>d[e[i].y]+e[i].w)
        {
            res=d[e[i].y]+e[i].w;
            ires=i;
        }
        e[i].select=true;
    }
    if (res==oo) cout << "NO"; else
    {
        cout << "YES" << '\n';
        //cout << res << '\n';
        e[ires].select=false;
        dijkstra(e[ires].x, e[ires].y, 1);
        cout << e[ires].x << ' ';
        int u=e[ires].y;
        while (u)
        {
            cout << u << ' ';
            u=trace[u];
        }
    }
}
///////

int main()
{
    freopen("tour.inp", "r", stdin);
    freopen("tour.out", "w", stdout);
    enter();
    process();
}
