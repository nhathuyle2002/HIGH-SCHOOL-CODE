#include <iostream>
#include <stdio.h>
#include <queue>
#include <vector>

#define forn(i,a,b) for (int i=(a); i<=(b); i++)
#define repn(i,a,b) for (int i=(a); i<(b); i++)

using namespace std;
//////

const
    int maxn=1e5+100, maxk=6;
const
    long long oo=1e16;

int n, m, k, S, T;
long long d[maxn][maxk];

struct data
{
    long long w;
    int u, k;
    bool operator < (const data &A) const {return w>A.w;}
};
data make_data(int u, int k, long long w)
{
    data p;
    p.u=u; p.k=k; p.w=w;
    return p;
}
vector<data> e[maxn];
priority_queue<data, vector<data> > q;
//////

void enter()
{
    scanf("%d%d%d%d%d\n", &n, &m, &k, &S, &T);
    forn(i, 1, m)
    {
        int u, v;
	long long w;
        scanf("%d%d%lld\n", &u, &v, &w);
        e[u].push_back(make_data(v, 0, w));
        e[v].push_back(make_data(u, 0, w));
    }
}
//////

void process()
{
    forn(u, 1, n) forn(j, 0, k)
        d[u][k]=oo;
    d[S][0]=0;
    q.push(make_data(S, 0, 0));

    while (!q.empty())
    {
        data p=q.top(); q.pop();
        if (p.w>d[p.u][p.k]) continue;
        if (p.u==T)
        {
            cout << p.w;
            return;
        }

        repn(i, 0, e[p.u].size())
        {
            data p2=e[p.u][i];
            if (d[p2.u][p.k]>p.w+p2.w)
            {
                d[p2.u][p.k]=p.w+p2.w;
                q.push(make_data(p2.u, p.k, p.w+p2.w));
            }
            if (p.k<k && d[p2.u][p.k+1]>p.w)
            {
                d[p2.u][p.k+1]=p.w;
                q.push(make_data(p2.u, p.k+1, p.w));
            }
        }
    }
}
//////

int main()
{
    freopen("freebus.inp", "r", stdin);
    freopen("freebus.out", "w", stdout);
    enter();
    process();
}
