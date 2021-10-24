#include <iostream>
#include <stdio.h>
#include <queue>
#include <vector>

#define forn(i,a,b) for (int i=(a); i<=(b); i++)
#define repn(i,a,b) for (int i=(a); i<(b); i++)

using namespace std;
//////

const
    int maxn=1510, maxm=5010, oo=1e9+7;

int n, m;
int d[maxn][maxn], h[maxn][maxn], d2[maxn][maxn], h2[maxn][maxn];
long long res;

struct data
{
    int u, w;
    bool operator < (const data &A) const {return w>A.w;}
};
data make_data(int u, int w)
{
    data p;
    p.u=u; p.w=w;
    return p;
}

int ex[maxn], ey[maxn], ew[maxn];
vector<data> e[maxn], e2[maxn];
priority_queue<data, vector<data> > q;
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, m)
    {
        int u, v, w;
        scanf("%d%d%d\n", &u, &v, &w);

        ex[i]=u; ey[i]=v; ew[i]=w;
        e[u].push_back(make_data(v, w));
        e2[v].push_back(make_data(u, w));
    }
}
//////

void dijkstra(int S)
{
    forn(u, 1, n) d[S][u]=oo;
    d[S][S]=0; h[S][S]=1;

    while (!q.empty()) q.pop();
    q.push(make_data(S, 0));

    while (!q.empty())
    {
        data p=q.top(); q.pop();
        if (p.w>d[S][p.u]) continue;

        repn(i, 0, e[p.u].size())
        {
            data p2=e[p.u][i];
            if (p.w+p2.w<d[S][p2.u])
            {
                d[S][p2.u]=p.w+p2.w;
                h[S][p2.u]=h[S][p.u];
                q.push(make_data(p2.u, p.w+p2.w));
            } else
            if (p.w+p2.w==d[S][p2.u])
                h[S][p2.u]=(h[S][p2.u]+h[S][p.u]) % oo;
        }
    }
}

void dijkstra2(int S)
{
    forn(u, 1, n) d2[S][u]=oo;
    d2[S][S]=0; h2[S][S]=1;

    while (!q.empty()) q.pop();
    q.push(make_data(S, 0));

    while (!q.empty())
    {
        data p=q.top(); q.pop();
        if (p.w>d2[S][p.u]) continue;

        repn(i, 0, e2[p.u].size())
        {
            data p2=e2[p.u][i];
            if (p.w+p2.w<d2[S][p2.u])
            {
                d2[S][p2.u]=p.w+p2.w;
                h2[S][p2.u]=h2[S][p.u];
                q.push(make_data(p2.u, p.w+p2.w));
            } else
            if (p.w+p2.w==d2[S][p2.u])
                h2[S][p2.u]=(h2[S][p2.u]+h2[S][p.u]) % oo;
        }
    }
}

void process()
{
    forn(x, 1, n)
    {
        dijkstra(x);
        dijkstra2(x);
    }

    forn(i, 1, m)
    {
        res=0;
        forn(x, 1, n) forn(y, 1, n)
            if(d[x][y]==d[x][ex[i]]+ew[i]+d2[y][ey[i]]) res=(res+1LL*h[x][ex[i]]*h2[y][ey[i]]) % oo;
        cout << res << '\n';
    }
}
//////

int main()
{
    freopen("paths.inp", "r", stdin);
    freopen("paths.out", "w", stdout);
    enter();
    process();
}
