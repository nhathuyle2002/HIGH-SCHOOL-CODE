#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

typedef long long LL;
typedef pair<LL, int> plli;
struct edge
{
    int y;
    LL w, L, R;
    edge (){}
    edge (int _y, LL _w, LL _l, LL _r) : y(_y), w(_w), L(_l), R(_r) {}
    void gan2(LL l, LL r)
    {
        L=l; R=r;
    }
};

const
    int maxn=1e5+100;
const
    LL oo=1e15;
int n, m, S, T, K, n2;
vector<edge> e[maxn];
LL d[maxn];
set<plli> Q;
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    scanf("%d%d%d%d\n", &S, &T, &K, &n2);

    int q[maxn];
    forn(i, 1, n2) scanf("%d", &q[i]); scanf("\n");
    forn(i, 1, m)
    {
        int u, v; LL w;
        scanf("%d%d%lld\n", &u, &v, &w);
        e[u].emplace_back(v, w, oo, oo);
        e[v].emplace_back(u, w, oo, oo);

    }
    d[1]=-K;
    forn(u, 1, n2-1)
    {
        repn(i, 0, e[q[u]].size())
            if (e[q[u]][i].y==q[u+1])
            {
                d[u+1]=d[u]+e[q[u]][i].w;
                e[q[u]][i].gan2(d[u], d[u+1]);
            }
        repn(i, 0, e[q[u+1]].size())
            if (e[q[u+1]][i].y==q[u])
                e[q[u+1]][i].gan2(d[u], d[u+1]);
    }
}
//////

void process()
{
    forn(u, 1, n) d[u]=oo;
    d[S]=0; Q.insert(plli(0, S));
    while (!Q.empty())
    {
        int u=(*Q.begin()).second; Q.erase(Q.begin());
        if (u==T) break;
        repn(i, 0, e[u].size())
        {
            edge e2=e[u][i];
            LL w2=d[u];
            if (e2.L<=w2 && w2<=e2.R) w2=e2.R;
            w2+=e2.w;
            if (w2<d[e2.y])
            {
                if (d[e2.y]<oo) Q.erase(plli(d[e2.y], e2.y));
                d[e2.y]=w2;
                Q.insert(plli(w2, e2.y));
            }
        }
    }
    cout << d[T];
}
//////

int main()
{
    freopen("city.inp", "r", stdin);
    freopen("city.out", "w", stdout);
    enter();
    process();
}
