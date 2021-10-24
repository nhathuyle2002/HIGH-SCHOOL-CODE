#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)

using namespace std;
//////

typedef pair<int, int> pii;
struct edge
{
    int y, h, w;
    edge (){}
    edge (int yy, int hh, int ww) : y(yy), h(hh), w(ww) {};
};
const
    int maxn=1e3+100, oo=1e9;

int n, m, S, T;
vector<edge> e[maxn];
int d[maxn], dh, trace[maxn];
set<pii> Q;
vector<int> out;
///////

void enter()
{
    scanf("%d%d%d\n", &n, &S, &T);
    scanf("%d\n", &m);
    forn(i, 1, m)
    {
        int u, v, h, w;
        scanf("%d%d%d%d\n", &u, &v, &h, &w);
        e[u].emplace_back(v, h, w);
        e[v].emplace_back(u, h, w);
    }
}
///////

void dijkstrah(int S)
{
    forn(u, 1, n) d[u]=-1;
    d[S]=oo;
    while (!Q.empty()) Q.erase(Q.begin());
    Q.insert(pii(-oo, S));
    while (!Q.empty())
    {
        int u=(*Q.begin()).second; Q.erase(Q.begin());
        if (u==T) return;
        for(edge p : e[u])
        {
            int v=p.y, h=p.h, hh=min(h, d[u]);
            if (d[v]<hh)
            {
                if (d[v]>-1) Q.erase(Q.find(pii(-d[v], v)));
                d[v]=hh;
                Q.insert(pii(-d[v], v));
            }
        }
    }
}

void dijkstraw(int S)
{
    forn(u, 1, n) d[u]=oo;
    d[S]=0; trace[S]=0;
    while (!Q.empty()) Q.erase(Q.begin());
    Q.insert(pii(0, S));
    while (!Q.empty())
    {
        int u=(*Q.begin()).second; Q.erase(Q.begin());
        if (u==T) return;
        for(edge p : e[u])
        {
            int v=p.y, h=p.h, w=p.w, ww=w+d[u];
            if (h>=dh && d[v]>ww)
            {
                if (d[v]<oo) Q.erase(Q.find(pii(d[v], v)));
                d[v]=ww;
                Q.insert(pii(d[v], v));
                trace[v]=u;
            }
        }
    }
}

void process()
{
    dijkstrah(S);
    dh=d[T];
    dijkstraw(S);
    out.clear();
    while (T!=0)
    {
        out.push_back(T);
        T=trace[T];
    }
    cout << out.size() << '\n';
    ford(i, out.size()-1, 0) cout << out[i] << ' ';
}
///////

int main()
{
    freopen("tunnel.inp", "r", stdin);
    freopen("tunnel.out", "w", stdout);
    enter();
    process();
}
