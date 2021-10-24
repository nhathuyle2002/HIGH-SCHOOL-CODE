#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

typedef long long LL;
typedef pair<long long,int> plli;
struct edge
{
    int x, y, pos;
    long long l, r;
};

const
    int maxN=1e4+10, maxK=110;
const
    LL oo=1e15;
int n, m, K, T;
int S[2];
vector<plli> e[maxN];
edge a[maxK];
LL d[2][maxN];
set<plli> Q;
LL res[maxK];
//////

void enter()
{
    scanf("%d%d%d\n", &n, &m, &K);
    scanf("%d%d%d\n", &S[0], &S[1], &T);
    forn(i, 1, m)
    {
        int u, v; LL w;
        scanf("%d%d%lld\n", &u, &v, &w);
        e[u].emplace_back(w, v);
    }
    forn(i, 1, K)
    {
        scanf("%d%d%lld%lld\n", &a[i].x, &a[i].y, &a[i].l, &a[i].r);
        a[i].pos=e[a[i].x].size();
        e[a[i].x].emplace_back(a[i].r, a[i].y);
        res[i]=a[i].r;
    }
}
//////

void dijkstra(int typ)
{
    forn(u, 1, n) d[typ][u]=oo;
    int s=S[typ];
    d[typ][s]=0; Q.insert(plli(0, s));
    while (!Q.empty())
    {
        plli p=*Q.begin(); Q.erase(Q.begin());
        repn(i, 0, e[p.second].size())
        {
            plli p2=e[p.second][i];
            if (p.first+p2.first<d[typ][p2.second])
            {
                if (d[typ][p2.second]<oo) Q.erase(plli(d[typ][p2.second], p2.second));
                d[typ][p2.second]=p.first+p2.first;
                Q.insert(plli(d[typ][p2.second], p2.second));
            }
        }
    }
}

void process()
{
    dijkstra(0);
    dijkstra(1);
    while (true)
    {
        if (d[0][T]<d[1][T]) return;
        bool stop=true;
        forn(i, 1, K)
            if (d[0][a[i].x]<d[1][a[i].x] && e[a[i].x][a[i].pos].first!=a[i].l)
            {
                stop=false;
                e[a[i].x][a[i].pos].first=a[i].l;
                res[i]=a[i].l;
            }
        if (stop) return;
        dijkstra(0);
        dijkstra(1);
    }
}
//////

int main()
{
    freopen("hack.inp", "r", stdin);
    freopen("hack.out", "w", stdout);
    enter();
    process();
    if (d[0][T]<d[1][T]) cout << "WIN"; else
    if (d[0][T]==d[1][T]) cout << "DRAW"; else
    cout << "LOSE";
    if (d[0][T]<=d[1][T])
    {
        cout << '\n';
        forn(i, 1, K) cout << res[i] << ' ';
    }
}
