#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)

using namespace std;
//////

typedef long long LL;
typedef pair<LL, int> data;
struct edge
{
    int x, y;
    long long w;
    bool select;
};
const
    int maxn=1e5+100, maxc=2e9+100;
const
    LL oo=1LL*maxn*maxc;

int n, m;
vector<edge> e;
vector<int> pos[maxn];
int trace[maxn];
LL d[maxn], price[maxn];
set<data> Q;
LL res;
vector<int> out1, out2;
///////

void    enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, m)
    {
        int u, v; LL w;
        scanf("%d%d%lld\n", &u, &v, &w);
        pos[u].push_back(e.size()); e.push_back({u, v, w, false});
        pos[v].push_back(e.size()); e.push_back({v, u, w, false});
    }
}
///////

LL      wp(int i)
{
    return e[i].w+price[e[i].x]-price[e[i].y];
}

bool    dijkstra(int S, int T)
{
    forn(u, 1, n) d[u]=oo;
    d[S]=0;
    while (!Q.empty()) Q.erase(Q.begin());
    Q.insert(data(0, S));
    while (!Q.empty())
    {
        int u=Q.begin()->second; Q.erase(Q.begin());
        if (u==T) return true;
        for(int i : pos[u])
        {
            int v=e[i].y; LL w=wp(i);
            if (!e[i].select && d[u]+w<d[v])
            {
                if (d[v]<oo) Q.erase(Q.find(data(d[v], v)));
                d[v]=d[u]+w;
                trace[v]=i;
                Q.insert(data(d[v], v));
            }
        }
    }
    return false;
}
//////

void optimal()
{
    forn(u, 1, n)
        if (d[u]<d[n]) price[u]+=d[u]-d[n];
    int u=n;
    while (u!=1)
    {
        int i=trace[u];
        e[i].select=true;
        e[i^1].w=-e[i].w;
        u=e[i].x;
    }
}

void remove_edge()
{
    for(int i=0; i<e.size(); i++)
        if (e[i].select && e[i^1].select)
        {
            e[i].select=false;
            e[i^1].select=false;
        }
}
//////

LL     process()
{
    forn(u, 1, n) price[u]=0;
    res=0;
    int K=2;
    while (K--)
    {
        if (!dijkstra(1, n)) return -1;
        optimal();
        res+=price[n]-price[1];
        remove_edge();
    }
    return res;
}
//////

void print()
{
    cout << res << '\n';
     if (res==-1) return;
    int u=1; out1.clear();
    while (true)
    {
        out1.push_back(u);
        if (u==n) break;
        forn(p, 0, pos[u].size()-1)
        {
            int i=pos[u][p];
            if (e[i].select)
            {
                u=e[i].y;
                e[i].select=false;
                break;
            }
        }
    }
    u=1; out2.clear();
    while (true)
    {
        out2.push_back(u);
        if (u==n) break;
        forn(p, 0, pos[u].size()-1)
        {
            int i=pos[u][p];
            if (e[i].select)
            {
                u=e[i].y;
                e[i].select=false;
                break;
            }
        }
    }

    forn(i, 0, out1.size()-1) cout << out1[i] << ' ';
    ford(i, out2.size()-2, 0) cout << out2[i] << ' ';
}
///////

int main()
{
    freopen("walk.inp", "r", stdin);
    freopen("walk.out", "w", stdout);
    enter();
    res=process();
    print();
}
