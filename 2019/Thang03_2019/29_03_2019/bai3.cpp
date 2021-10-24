#include <bits/stdc++.h>
#define forn(i,a,b) for(int i=(a); i<=(b); i++)
#define ford(i,a,b) for(int i=(a); i>=(b); i++)
using namespace std;
//////

typedef pair<int, int> pii;
const
    int maxn=1e5+100, oo=1e9;

int n, m;
vector<pii> e[maxn];
int d[maxn];
long long df[maxn];
set<pii> Q;
//////

void enter()
{
    scanf("%d%d\n", &n, &m);
    forn(i, 1, m)
    {
        int u, v, w;
        scanf("%d%d%d\n", &u, &v, &w);
        e[u].emplace_back(v, w);
        e[v].emplace_back(u, w);
    }
}
//////

void process()
{
    forn(u, 1, n)
    {
        d[u]=oo; df[u]=0;
    }
    d[1]=0; df[1]=1;
    Q.insert(pii(0, 1));
    while (!Q.empty())
    {
        int u=Q.begin()->second; Q.erase(Q.begin());
        for(pii p : e[u])
        {
            int v=p.first, w=p.second;
            if (d[u]+w==d[v]) df[v]+=df[u]; else
            if (d[u]+w<d[v])
            {
                if (d[v]<oo) Q.erase(pii(d[v], v));
                d[v]=d[u]+w;
                df[v]=df[u];
                Q.insert(pii(d[v], v));
            }
        }
    }
    cout << d[n] << ' ' << df[n];
}
//////

int main()
{
    freopen("bai3.inp", "r", stdin);
    freopen("bai3.out", "w", stdout);
    enter();
    process();
}
