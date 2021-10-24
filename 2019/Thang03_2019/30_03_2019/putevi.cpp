#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e5+100, base=1e9+7;

int n;
vector<pii> e[maxn];
bool d[maxn];
long long res, f[maxn];
//////

void enter()
{
    scanf("%d\n", &n);
    forn(i, 1, n-1)
    {
        int u, v, w;
        scanf("%d%d%d\n", &u, &v, &w);
        e[u].emplace_back(v, w);
        e[v].emplace_back(u, w);
    }
}
//////

void dfs(int u)
{
    d[u]=true; f[u]=0;
    for(pii p : e[u])
    {
        int v=p.first, w=p.second;
        if (!d[v])
        {
            dfs(v);
            long long sum=(f[v]*w+w) % base;
            res=(res+sum+f[u]*sum) % base;
            f[u]=(f[u]+sum) % base;
        }
    }
}

void process()
{
    forn(u, 1, n) d[u]=false;
    res=0; dfs(1);
    cout << res;
}
//////

int main()
{
    freopen("putevi.inp", "r", stdin);
    freopen("putevi.out", "w", stdout);
    enter();
    process();
}
