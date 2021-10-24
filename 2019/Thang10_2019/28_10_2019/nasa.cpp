#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

const
    int maxn=210, oo=1e9;

struct edge
{
    int x, y, w, f;
};
int n, m, S, T;
vector<edge> e;
vector<int> pos_e[maxn];
long long res;
deque<int> Q;
int cou, d[maxn], dc[maxn], trace[maxn];
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    S=0; T=n+m+1;
    res=0;
    forn(u, 1, n)
    {
        int w; scanf("%d", &w);
        res+=w;
        pos_e[S].push_back(e.size());
        e.push_back({S, u, w, 0});
        pos_e[u].push_back(e.size());
        e.push_back({u, S, 0, 0});
    }
    forn(u, n+1, n+m)
    {
        int w; scanf("%d", &w);
        pos_e[u].push_back(e.size());
        e.push_back({u, T, w, 0});
        pos_e[T].push_back(e.size());
        e.push_back({T, u, 0, 0});
    }

    forn(u, 1, n)
    {
        forn(v, n+1, n+m)
        {
            int x; scanf("%d", &x);
            if (x==1)
            {
                pos_e[u].push_back(e.size());
                e.push_back({u, v, oo, 0});
                pos_e[v].push_back(e.size());
                e.push_back({v, u, 0, 0});
            }
        }
        scanf("\n");
    }
}
//////

bool FindPath(int S, int T)
{
    ++cou; Q.clear();
    d[S]=oo; dc[S]=cou; Q.push_back(S);
    while (!Q.empty())
    {
        int u=Q.front(); Q.pop_front();
        for(int pos : pos_e[u])
            if (e[pos].w-e[pos].f>0 && dc[e[pos].y]!=cou)
            {
                int v=e[pos].y;
                dc[v]=cou; trace[v]=pos;
                d[v]=min(d[u], e[pos].w-e[pos].f);
                Q.push_back(v);
                if (v==T) return true;
            }
    }
    return false;
}

void Augment(int S, int T)
{
    int v=T, i, delta=d[T];
    res-=delta;
    while (v!=S)
    {
        i=trace[v];
        e[i].f+=delta;
        e[i^1].f-=delta;
        v=e[i].x;
    }
}
//////

void process()
{
    cou=0;
    while (FindPath(S, T)) Augment(S, T);
    cout << res;
}
//////

int main()
{
    freopen("nasa.inp", "r", stdin);
    freopen("nasa.out", "w", stdout);
    enter();
    process();
}
