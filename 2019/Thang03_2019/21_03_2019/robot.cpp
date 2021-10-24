#include <bits/stdc++.h>
#define forn(i,a,b) for (int i=(a); i<=(b); i++)
#define repn(i,a,b) for (int i=(a); i<(b); i++)

using namespace std;
//////

struct data
{
    int u;
    long long w;
    int h;
    bool operator < (const data &A) const
    {
        if (w==A.w) return h<A.h;
        return w>A.w;
    }
    data (){}
    data (int _u, long long _w, int _h): u(_u), w(_w), h(_h){}
};

const
    int maxn=1e5+100;
const
    long long oo=1e16;
int n, m, high_first;
int high[maxn];
vector<data> e[maxn];
data d[maxn];
priority_queue<data, vector<data> > heap;
long long res;
//////

void enter()
{
    scanf("%d%d%d\n", &n, &m, &high_first);
    forn(i, 1, n) scanf("%d\n", &high[i]);
    forn(i, 1, m)
    {
        int u, v; long long w;
        scanf("%d%d%lld\n", &u, &v, &w);
        e[u].emplace_back(v, w, 0);
        e[v].emplace_back(u, w, 0);
    }
}
//////

void process()
{
    while (!heap.empty()) heap.pop();
    forn(u, 1, n) d[u].w=oo;
    d[1].w=0; d[1].h=high_first;
    heap.emplace(1, 0, high_first);

    res=oo;
    while (!heap.empty())
    {
        data p=heap.top(); heap.pop();
        if (p.w!=d[p.u].w || p.h!=d[p.u].h) continue;
        repn(i, 0, e[p.u].size())
        {
            data p2=e[p.u][i];
            if (p.h>=p2.w)
            {
                if (p.h-p2.w>high[p2.u])
                {
                    p2.w+=p.w+p.h-p2.w-high[p2.u];
                    p2.h=high[p2.u];
                } else
                {
                    p2.h=p.h-p2.w;
                    p2.w+=p.w;
                }
            } else
            {
                if (high[p.u]<p2.w) continue;
                p2.w=p.w+2*p2.w-p.h;
                p2.h=0;
            }
            if (p2.w<d[p2.u].w || (p2.w==d[p2.u].w && p2.h>d[p2.u].h))
            {
                d[p2.u]=p2;
                heap.push(p2);
            }
            if (p2.u==n) res=min(res, p2.w+high[n]-p2.h);
        }
    }
    res=min(res, d[n].w+high[n]-d[n].h);
    if (res==oo) cout << -1; else cout << res;
}
//////

int main()
{
    freopen("robot.inp", "r", stdin);
    freopen("robot.out", "w", stdout);
    enter();
    process();
}
