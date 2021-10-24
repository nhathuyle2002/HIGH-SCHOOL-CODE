#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
#define repn(i,a,b) for(int i=(a); i<(b); ++i)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=5e3+100, oo=1e9;
int n, m;
int w[maxn], d[maxn][maxn], dmin[maxn];
bool In_prime[maxn];
long long res;
//////

void minimize(int &x, int y) {if (x>y) x=y;}

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(u, 1, n) scanf("%d", &w[u]);
    forn(u, 1, n)
        forn(v, 1, n)
            d[u][v]=oo;
    forn(i, 1, m)
    {
        int u, l, r;
        scanf("%d%d%d\n", &u, &l, &r);
        forn(v, l, r)
        {
            d[u][v]=w[u]+w[v];
            d[v][u]=w[u]+w[v];
        }
    }
}
//////

void process()
{
    res=0;

    forn(u, 1, n) In_prime[u]=false;
    In_prime[1]=true;
    forn(u, 1, n) dmin[u]=d[1][u];

    forn(t, 2, n)
    {
        int umin=-1;
        forn(u, 1, n)
            if (!In_prime[u] && (umin==-1 || dmin[u]<dmin[umin])) umin=u;
        res+=dmin[umin];
        In_prime[umin]=true;
        forn(v, 1, n)
            if (!In_prime[v]) dmin[v]=min(dmin[v], d[umin][v]);
    }
    cout << res;
}
//////

int main()
{
    freopen("galaxy.inp", "r", stdin);
    freopen("galaxy_try.out", "w", stdout);
    enter();
    process();
}
