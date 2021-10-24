#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<=(b); ++i)
using namespace std;
//////

const
    int maxn=1e5+100, oo=1e8;

struct edge
{
    int x, y, w, f;
};
int n, m, S, T;
vector<edge> e;
vector<int> pos_e[maxn];
int cou, trace[maxn], dc[maxn], d[maxn];
deque<int> Q;
vector<int> Ans;
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    scanf("%d%d\n", &S, &T);
    forn(u, 1, n)
    {
        int W;
        scanf("%d\n", &W);
        pos_e[u].push_back(e.size());
        e.push_back({u, u+n, W, 0});
        pos_e[u+n].push_back(e.size());
        e.push_back({u+n, u, 0, 0});
    }
    forn(i, 1, m)
    {
        int u, v;
        scanf("%d%d\n", &u, &v);

        pos_e[u+n].push_back(e.size());
        e.push_back({u+n, v, oo, 0});
        pos_e[v].push_back(e.size());
        e.push_back({v, u+n, 0, 0});

        pos_e[v+n].push_back(e.size());
        e.push_back({v+n, u, oo, 0});
        pos_e[u].push_back(e.size());
        e.push_back({u, v+n, 0, 0});
    }
}
//////

bool FindPath(int S, int T)
{
    ++cou;
    Q.clear();
    d[S]=oo; dc[S]=cou; Q.push_back(S);

    while (!Q.empty())
    {
        int u=Q.front(); Q.pop_front();
        for(int pos : pos_e[u])
            if (e[pos].w-e[pos].f>0 && dc[e[pos].y]!=cou)
            {
                int v=e[pos].y;
                d[v]=min(d[u], e[pos].w-e[pos].f);
                dc[v]=cou; trace[v]=pos;
                Q.push_back(v);
                if (v==T+n) return true;
            }
    }
    return false;
}

void IncFlow(int S, int T)
{
    int v=T+n, i;
    while (v!=S)
    {
        i=trace[v];
        e[i].f+=d[T];
        e[i^1].f-=d[T];
        v=e[i].x;
    }
}

//////

void process()
{
    cou=0;
    do
    {
        if (!FindPath(S, T)) break;
        IncFlow(S, T);
    }
    while (true);

    /*int res=0;
    for(pos : pos_e[S]) res+=e[pos].f;
    cout << res << '\n';*/

    forn(u, 1, n)
        if (dc[u]==cou && dc[u+n]!=cou) cout << u << ' ';
}
//////

int main()
{
    freopen("mafia.inp", "r", stdin);
    freopen("mafia.out", "w", stdout);
    enter();
    process();
    return 0;
}
