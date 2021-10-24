#include <iostream>
#include <stdio.h>
#include <vector>
#include <queue>

#define for(i,a,b) for (int i=a; i<=b; i++)
#define pb push_back

using namespace std;

const
    int maxn=110, maxm=10010;

struct edge
{
    int y,w,t;
};

struct data
{
    int u,k,w;
};

edge make_edge(int v, int c, int tt)
{
    edge p;
    p.y=v; p.w=c; p.t=tt;
    return p;
}

data make_data(int v, int c, int tt)
{
    data p;
    p.u=v; p.k=c; p.w=tt;
    return p;
}

int st, n, m, maxw;
vector<edge> e[maxn];
int d[maxn][maxm];

struct cmp
{
    bool operator()(data x, data y) {return x.w>y.w;};
};

priority_queue<data, vector<data>, cmp> q;

void enter()
{
    scanf("%d%d%d", &maxw, &n, &m);
    for(i,1,n) e[i].clear();
    for(i,1,m)
    {
        int u,v,c,tt;
        scanf("%d%d%d%d", &u, &v, &c, &tt);
        e[u].pb(make_edge(v,c,tt));
    }
}

int process()
{
    for(i,1,n)
        for(j,0,maxw) d[i][j]=int(1e6);
    while (!q.empty()) q.pop();
    d[1][0]=0;
    q.push(make_data(1,0,0));
    do
    {
        if (q.empty()) return(-1);
        data u=q.top();
        q.pop();
        if (u.w>d[u.u][u.k]) continue;
        if (u.u==n) return(u.w);
        //cout << e[u.u].size() << ' ';
        for(i,0,int(e[u.u].size())-1)
        {
            //cout << e[u.u][i].y << ' ';
            edge p=e[u.u][i];
            if (u.k+p.t<=maxw && u.w+p.w<d[p.y][u.k+p.t])
            {
                d[p.y][u.k+p.t]=u.w+p.w;
                q.push(make_data(p.y, u.k+p.t, u.w+p.w));
            }
        }
    }
    while (true);
}

int main()
{
    freopen("roads.inp", "r", stdin);
    //freopen("roads.out", "w", stdout);
    scanf("%d", &st);
    for(i,1,st)
    {
        enter();
        cout << process() << '\n';
    }
    return 0;
}
