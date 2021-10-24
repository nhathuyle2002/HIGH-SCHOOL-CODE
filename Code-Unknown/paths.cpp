#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i--)

using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e4+100;
int T, n, m;
bool res;
vector<int> pos[maxn];
vector<pii> e;
bool d[maxn][2];
bool dd[maxn];
///////

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, m)
    {
        int u, v;
        scanf("%d%d\n", &u, &v);
        pos[u].push_back(e.size()); e.push_back({u, v});
        pos[v].push_back(e.size()); e.push_back({v, u});
    }
}
///////

void dfs(int u, int typ)
{
    dd[u]=true;
    d[u][typ]=true;
    for(int i : pos[u])
    {
        int v=e[i].second;
        if (!d[v][1-typ]) dfs(v, 1-typ);
    }
}

void process()
{
    forn(u, 1, n)
    {
        d[u][0]=false;
        d[u][1]=false;
    }
    forn(u, 1, n) dd[u]=false;
    forn(u, 1, n)
        if (!dd[u]) dfs(u, 0);
    res=false;
    for(pii p : e)
        if (d[p.first][0] && d[p.second][0]) res=true;
    if (res) cout << "YES" << '\n'; else cout << "NO" << '\n';
}
///////

int main()
{
    freopen("paths.inp", "r", stdin);
    freopen("paths.out", "w", stdout);
    scanf("%d\n", &T);
    while (T--)
    {
        enter();
        process();
    }
}
