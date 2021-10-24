#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); ++i)
#define ford(i,a,b) for(int i=(a); i>=(b); --i)
using namespace std;
//////

struct edge
{
    int x, y;
    bool dd;
};
const
    int maxn=2e5+100, base=1e9+7;

int n, m;
vector<edge> e;
vector<int> pose[maxn];
int cou, low[maxn], num[maxn];
vector<int> Q;
int coult, id[maxn];
vector<int> lt[maxn];
bool d[maxn];
int res;
long long cres;
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, m)
    {
        int u, v;
        scanf("%d%d\n", &u, &v);
        pose[u].push_back(e.size()); e.push_back({u, v, true});
        pose[v].push_back(e.size()); e.push_back({v, u, true});
    }
}
//////

void dfs(int u)
{
    cou++; num[u]=cou; low[u]=cou;
    Q.push_back(u);
    for(int i : pose[u])
    if (e[i].dd)
    {
        e[i^1].dd=false;
        int v=e[i].y;
        if (num[v]==0)
        {
            dfs(v);
            low[u]=min(low[u], low[v]);
        } else
        if (id[v]==0)
            low[u]=min(low[u], num[v]);
    }
    if (low[u]==num[u])
    {
        coult++;
        int v=n+1;
        while (v!=u)
        {
            v=Q.back(); Q.pop_back();
            id[v]=coult;
            lt[coult].push_back(v);
        }
    }
}
//////

void process()
{
    cou=0; coult=0;
    Q.clear();
    dfs(1);
    forn(u, 1, coult) d[u]=true;
    res=0; cres=1;
    forn(uu, 1, coult)
    {
        int cou=0;
        for(int u : lt[uu])
            for(int i : pose[u])
            {
                int vv=id[e[i].y];
                if (vv!=uu && d[vv])
                {
                    d[vv]=false;
                    cou++;
                }
            }
        for(int u : lt[uu])
            for(int i : pose[u])
            {
                int vv=id[e[i].y];
                d[vv]=true;
            }
        if (cou<=1)
        {
            res++;
            cres=cres*lt[uu].size() % base;
        }
    }
    cout << res << ' ' << cres;
}
//////

int main()
{
    freopen("data.inp", "r", stdin);
    freopen("data.out", "w", stdout);
    enter();
    process();
}
