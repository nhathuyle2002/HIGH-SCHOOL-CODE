#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define repn(i,a,b) for(int i=(a); i<(b); i++)
using namespace std;
//////

const
    int maxn=1e4+100;
int n, m;
vector<int> e[maxn];
bool d[maxn];
int cou1, cou2, cou;
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, m)
    {
        int u, v;
        scanf("%d%d\n", &u, &v);
        e[u].push_back(v);
        e[v].push_back(u);
    }
}
//////

void dfs(int u)
{
    cou++;
    d[u]=false;
    repn(i, 0, e[u].size())
        if (d[e[u][i]]) dfs(e[u][i]);
}

void process()
{
    cou1=0; cou2=0;
    forn(u, 1, n) d[u]=true;
    forn(u, 1, n)
        if (d[u])
        {
            cou=0;
            dfs(u);
            if (cou>=cou1)
            {
                cou2=cou1; cou1=cou;
            } else
            if (cou>cou2)
                cou2=cou;
        }
    cout << cou1+cou2;
}

int main()
{
    freopen("kinhdoanh.inp", "r", stdin);
    freopen("kinhdoanh.out", "w", stdout);
    enter();
    process();
}
