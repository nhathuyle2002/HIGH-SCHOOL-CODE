#include <bits/stdc++.h>
#define forn(i,a,b) for (int i=(a); i<=(b); i++)
#define repn(i,a,b) for (int i=(a); i<(b); i++)
using namespace std;
//////

struct data
{
    int u, w;
    data (){}
    data (int _u, int _w) : u(_u), w(_w) {}
    bool operator < (const data &A) const {return w>A.w;}
};
bool comp(data x, data y)
{
    if (x.w!=y.w) return x.w<y.w;
    return x.u>y.u;
}

const
    int maxn=3e4+10, oo=1e9;
int n, m, pro[maxn];
vector<data> e[maxn];
data d[maxn];
priority_queue<data, vector<data> > heap;
int res;
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(u, 1, n) scanf("%d", &pro[u]); scanf("\n");
    forn(i, 1, m)
    {
        int u, v, w;
        scanf("%d%d%d\n", &u, &v, &w);
        e[u].emplace_back(v, w);
        e[v].emplace_back(u, w);
    }
}
//////

void dijkstra(int S)
{
    forn(u, 1, n)
    {
        d[u].w=oo;
        d[u].u=pro[u];
    }
    while (!heap.empty()) heap.pop();
    d[S].w=0; heap.emplace(S, 0);

    while (!heap.empty())
    {
        data p=heap.top(); heap.pop();
        if (p.w>d[p.u].w) continue;

        repn(i, 0, e[p.u].size())
        {
            data p2=e[p.u][i];
            if (p.w+p2.w<d[p2.u].w)
            {
                d[p2.u].w=p.w+p2.w;
                heap.emplace(p2.u, d[p2.u].w);
            }
        }
    }
}

void upres()
{
    sort(d+1, d+n+1, comp);
    int max_pro=0;
    forn(u, 1, n)
    {
        if (d[u].u>=max_pro) res++;
        max_pro=max(max_pro, d[u].u);
    }
}

void process()
{
    res=0;
    forn(u, 1, n)
    {
        dijkstra(u);
        upres();
    }
    cout << res;
}

int main()
{
    freopen("impver.inp", "r", stdin);
    freopen("impver.out", "w", stdout);
    enter();
    process();
}
