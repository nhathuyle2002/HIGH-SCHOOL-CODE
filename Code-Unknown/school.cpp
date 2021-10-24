#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

typedef long long LL;
typedef pair<int, int> data;
struct edge
{
    int x, y, w1, w2;
};
const
    int maxn=1e5+100, oo=1e9;

int n, m, K;
vector<edge> e;
vector<int> pose[maxn];
int s[maxn];
set<data> Q;
int d1[maxn], d2[maxn], d3[maxn];

//////

void enter()
{
    scanf("%d%d%d\n", &n, &m, &K);
    forn(i, 1, m)
    {
        int u, v, w1, w2;
        scanf("%d%d%d%d\n", &u, &v, &w2, &w1);
        pose[u].push_back(e.size()); e.push_back({u, v, w1, w2});
    }
}
//////

void dijkstra(int S)
{
    forn(u, 1, n) s[u]=oo;
    s[S]=0;
    Q.clear(); Q.insert({0, S});
    while (!Q.empty())
    {
        int u=Q.begin()->second; Q.erase(Q.begin());
        for(int i : pose[u])
        {
            int v=e[i].y, w=e[i].w1;
            if (s[u]+w<s[v])
            {
                if (s[v]<oo) Q.erase({s[v], v});
                s[v]=s[u]+w;
                Q.insert({s[v], v});
            }
        }
    }
}
//////

void process()
{
    dijkstra(1);
    forn(u, 1, n) d1[u]=s[u];

    forn(i, 0, e.size()-1)
        swap(e[i].x, e[i].y);

    forn(u, 1, n) pose[u].clear();
    forn(i, 0, e.size()-1)
        pose[e[i].x].push_back(i);

    dijkstra(n);
    forn(u, 1, n) d2[u]=s[u];

    forn(i, 0, e.size()-1)
        swap(e[i].w1, e[i].w2);

    dijkstra(K);
    forn(u, 1, n) d3[u]=s[u];

    int res=oo;
    forn(u, 1, n)
        if (d1[u]+d3[u]<=59) res=min(res, d1[u]+d2[u]);
    cout << res;
}
//////

int main()
{
    freopen("school.inp", "r", stdin);
    freopen("school.out", "w", stdout);
    enter();
    process();
}
