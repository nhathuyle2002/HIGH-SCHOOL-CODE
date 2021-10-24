#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i++)
#define F first
#define S second
using namespace std;
//////

const
    int maxn=1e4+100, maxm=1e5+100;
int n, m;
pair<int, pair<int, int> > e[maxm];
int root[maxn], res;
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, m)
        scanf("%d%d%d\n", &e[i].S.F, &e[i].S.S, &e[i].F);
    sort(e+1, e+m+1, greater<pair<int, pair<int, int> > >());
}
//////

int find_root(int u)
{
    while (u!=root[u]) u=root[u];
    return u;
}

void process()
{
    forn(u, 1, n) root[u]=u;
    res=0;
    forn(i, 1, m)
    {
        int x=e[i].S.F, y=e[i].S.S, w=e[i].F;
        int x0=find_root(x), y0=find_root(y);
        if (x0==y0) res+=w;
        root[x]=x0; root[y]=x0; root[y0]=x0;
    }
    cout << res;
}
//////

int main()
{
    freopen("bai2.inp", "r", stdin);
    freopen("bai2.out", "w", stdout);
    enter();
    process();
}
