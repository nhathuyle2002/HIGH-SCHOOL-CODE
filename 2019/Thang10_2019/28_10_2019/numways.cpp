#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

struct edge
{
    int x, y, w, f;
};
const
    int maxn=1e5+100, oo=1e9;
int n, m, S, T;
vector<edge> e;
vector<int> pos_e[maxn];
int cou, d[maxn], dc[maxn], trace[maxn];
deque<int> Q;
//////

void add(int u, int v, int w)
{
    pos_e[u].push_back(e.size());
    e.push_back({u, v, w, 0});
    pos_e[v].push_back(e.size());
    e.push_back({v, u, 0, 0});
}

void enter()
{
    scanf("%d%d\n", &n, &m);
    S=0; T=2*n*m+1;
    forn(i, 1, n)
    {
        add(S, (i-1)*m+1, oo);
        add((i-1)*m+m+n*m, T, oo);
    }
    forn(i, 1, n*m) add(i, i+n*m, 1);

    forn(j, 1, m-1)
        forn(i, 1, n)
        {
            int sl; scanf("%d", &sl);
            while (sl--)
            {
                int i2; scanf("%d", &i2);
                add((i-1)*m+j+n*m, (i2-1)*m+j+1, oo);
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
            d[v]=min(d[u], e[pos].w-e[pos].f);
            dc[v]=cou; trace[v]=pos;
            Q.push_back(v);
            if (v==T) return true;
        }
    }
    return false;
}

void IncFlow(int S, int T)
{
    int v=T, i, delta=d[T];
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
    while (FindPath(S, T)) IncFlow(S, T);
    cout << cou-1;
}
//////

int main()
{
    freopen("numways.inp", "r", stdin);
    freopen("numways.out", "w", stdout);
    enter();
    process();
}
